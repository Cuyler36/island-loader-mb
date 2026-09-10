#!/usr/bin/env python3
"""Extract and rebuild the island loader's BG tiles and palette.

The PNG is an 8-bit indexed image so it can retain all 256 BG palette colors.
Its pixels select one 16-color palette bank while retaining their original
4bpp values for conversion back to GBA data.

Examples:
    python tools/loader_bg_tiles.py extract payload/data/data.bin loader_bg.png --palette-index 0
    python tools/loader_bg_tiles.py extract-all payload/data/data.bin loader_bg_palettes
    python tools/loader_bg_tiles.py palettes payload/data/data.bin loader_bg_palette_swatches
    python tools/loader_bg_tiles.py import loader_bg.png loader_bg.4bpp loader_bg.gbapal --palette-index 0
    python tools/loader_bg_tiles.py sprites payload/data/data.bin extracted_sprites
    python tools/loader_bg_tiles.py world payload/data/data.bin extracted_world
    python tools/loader_bg_tiles.py roundtrip payload/data/data.bin
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import tempfile
from dataclasses import asdict, dataclass
from pathlib import Path

try:
    from PIL import Image
except ImportError as error:
    raise SystemExit("Pillow is required: install it with 'python -m pip install Pillow'") from error


BG_TILES_OFFSET = 0xFE98
BG_TILES_SIZE = 0x8000
BG_PALETTE_OFFSET = 0x17E98
BG_PALETTE_SIZE = 0x200
OBJ_TILES_OFFSET = 0x7E98
OBJ_TILES_SIZE = 0x8000
OBJ_PALETTE_OFFSET = 0x1A098
OBJ_PALETTE_SIZE = 0x200
TILE_WIDTH = 8
TILE_HEIGHT = 8
TILE_SIZE_4BPP = 32
SHEET_WIDTH_TILES = 32
SHEET_WIDTH = SHEET_WIDTH_TILES * TILE_WIDTH
SHEET_HEIGHT = (BG_TILES_SIZE // TILE_SIZE_4BPP // SHEET_WIDTH_TILES) * TILE_HEIGHT
PALETTE_COUNT = 16
COLORS_PER_PALETTE = 16
PALETTE_SWATCH_SIZE = 16
OAM_DIMENSIONS = {
    0: ((8, 8), (16, 16), (32, 32), (64, 64)),
    1: ((16, 8), (32, 8), (32, 16), (64, 32)),
    2: ((8, 16), (8, 32), (16, 32), (32, 64)),
}


@dataclass
class OamEntry:
    x: int
    y: int
    width: int
    height: int
    tile: int
    palette: int
    bpp: int
    h_flip: bool
    v_flip: bool
    affine: bool
    attr0: int
    attr1: int
    attr2: int


def validate_palette_index(palette_index: int) -> None:
    if not 0 <= palette_index < PALETTE_COUNT:
        raise ValueError(f"palette index must be between 0 and {PALETTE_COUNT - 1}")


def read_loader_bg(data_path: Path) -> tuple[bytes, bytes]:
    data = data_path.read_bytes()
    required_size = BG_PALETTE_OFFSET + BG_PALETTE_SIZE
    if len(data) < required_size:
        raise ValueError(
            f"{data_path} is too small: expected at least 0x{required_size:X} bytes, "
            f"got 0x{len(data):X}"
        )
    return (
        data[BG_TILES_OFFSET : BG_TILES_OFFSET + BG_TILES_SIZE],
        data[BG_PALETTE_OFFSET : BG_PALETTE_OFFSET + BG_PALETTE_SIZE],
    )


def read_loader_obj(data_path: Path) -> tuple[bytes, bytes]:
    data = data_path.read_bytes()
    required_size = OBJ_PALETTE_OFFSET + OBJ_PALETTE_SIZE
    if len(data) < required_size:
        raise ValueError(
            f"{data_path} is too small: expected at least 0x{required_size:X} bytes, "
            f"got 0x{len(data):X}"
        )
    return (
        data[OBJ_TILES_OFFSET : OBJ_TILES_OFFSET + OBJ_TILES_SIZE],
        data[OBJ_PALETTE_OFFSET : OBJ_PALETTE_OFFSET + OBJ_PALETTE_SIZE],
    )


def gba_palette_to_rgb(palette: bytes) -> list[int]:
    if len(palette) != BG_PALETTE_SIZE:
        raise ValueError(f"expected a 0x{BG_PALETTE_SIZE:X}-byte palette")

    rgb: list[int] = []
    for offset in range(0, len(palette), 2):
        color = int.from_bytes(palette[offset : offset + 2], "little")
        if color & 0x8000:
            raise ValueError("palette bit 15 cannot be represented in a PNG palette")
        for shift in (0, 5, 10):
            component = (color >> shift) & 0x1F
            rgb.append((component << 3) | (component >> 2))
    return rgb


def rgb_to_gba_palette(rgb: list[int]) -> bytes:
    if len(rgb) < 256 * 3:
        raise ValueError("PNG must contain all 256 palette entries")

    palette = bytearray()
    for index in range(256):
        red, green, blue = rgb[index * 3 : index * 3 + 3]
        color = (red >> 3) | ((green >> 3) << 5) | ((blue >> 3) << 10)
        palette.extend(color.to_bytes(2, "little"))
    return bytes(palette)


def gba_tiles_to_pixels(tiles: bytes, palette_index: int = 0) -> list[int]:
    if len(tiles) != BG_TILES_SIZE:
        raise ValueError(f"expected 0x{BG_TILES_SIZE:X} bytes of BG tiles")
    validate_palette_index(palette_index)

    pixels = [0] * (SHEET_WIDTH * SHEET_HEIGHT)
    palette_base = palette_index * COLORS_PER_PALETTE
    for tile_index in range(len(tiles) // TILE_SIZE_4BPP):
        tile_x = (tile_index % SHEET_WIDTH_TILES) * TILE_WIDTH
        tile_y = (tile_index // SHEET_WIDTH_TILES) * TILE_HEIGHT
        tile_offset = tile_index * TILE_SIZE_4BPP
        for y in range(TILE_HEIGHT):
            row_offset = tile_offset + y * 4
            pixel_offset = (tile_y + y) * SHEET_WIDTH + tile_x
            for pair in range(4):
                packed = tiles[row_offset + pair]
                pixels[pixel_offset + pair * 2] = palette_base + (packed & 0x0F)
                pixels[pixel_offset + pair * 2 + 1] = palette_base + (packed >> 4)
    return pixels


def pixels_to_gba_tiles(pixels: list[int], palette_index: int = 0) -> bytes:
    expected_pixels = SHEET_WIDTH * SHEET_HEIGHT
    if len(pixels) != expected_pixels:
        raise ValueError(f"expected {expected_pixels} pixels, got {len(pixels)}")
    validate_palette_index(palette_index)
    palette_base = palette_index * COLORS_PER_PALETTE
    palette_end = palette_base + COLORS_PER_PALETTE
    if any(not palette_base <= pixel < palette_end for pixel in pixels):
        raise ValueError(
            f"PNG contains colors outside palette bank {palette_index} "
            f"(indices {palette_base}..{palette_end - 1})"
        )
    pixels = [pixel - palette_base for pixel in pixels]

    tiles = bytearray(BG_TILES_SIZE)
    for tile_index in range(BG_TILES_SIZE // TILE_SIZE_4BPP):
        tile_x = (tile_index % SHEET_WIDTH_TILES) * TILE_WIDTH
        tile_y = (tile_index // SHEET_WIDTH_TILES) * TILE_HEIGHT
        tile_offset = tile_index * TILE_SIZE_4BPP
        for y in range(TILE_HEIGHT):
            row_offset = tile_offset + y * 4
            pixel_offset = (tile_y + y) * SHEET_WIDTH + tile_x
            for pair in range(4):
                low = pixels[pixel_offset + pair * 2]
                high = pixels[pixel_offset + pair * 2 + 1]
                tiles[row_offset + pair] = low | (high << 4)
    return bytes(tiles)


def extract_png(data_path: Path, png_path: Path, palette_index: int = 0) -> None:
    tiles, palette = read_loader_bg(data_path)
    image = Image.new("P", (SHEET_WIDTH, SHEET_HEIGHT))
    image.putdata(gba_tiles_to_pixels(tiles, palette_index))
    image.putpalette(gba_palette_to_rgb(palette), rawmode="RGB")
    png_path.parent.mkdir(parents=True, exist_ok=True)
    image.save(png_path, format="PNG", bits=8, optimize=False)


def extract_all_palettes(
    data_path: Path, output_directory: Path, count: int, palette_index: int = 0
) -> None:
    validate_palette_index(palette_index)
    if count < 1 or palette_index + count > PALETTE_COUNT:
        raise ValueError(
            f"count must be between 1 and {PALETTE_COUNT - palette_index} "
            f"for starting palette {palette_index}"
        )
    output_directory.mkdir(parents=True, exist_ok=True)
    for index in range(palette_index, palette_index + count):
        extract_png(data_path, output_directory / f"loader_bg_pal{index:02d}.png", index)


def extract_palette_swatches(data_path: Path, output_directory: Path) -> None:
    """Export each 16-color BG palette bank as one horizontal swatch strip."""
    _, palette = read_loader_bg(data_path)
    palette_rgb = gba_palette_to_rgb(palette)
    output_directory.mkdir(parents=True, exist_ok=True)

    for palette_index in range(PALETTE_COUNT):
        image = Image.new(
            "RGB",
            (COLORS_PER_PALETTE * PALETTE_SWATCH_SIZE, PALETTE_SWATCH_SIZE),
        )
        for color_index in range(COLORS_PER_PALETTE):
            palette_color = palette_index * COLORS_PER_PALETTE + color_index
            base = palette_color * 3
            color = tuple(palette_rgb[base : base + 3])
            x0 = color_index * PALETTE_SWATCH_SIZE
            image.paste(color, (x0, 0, x0 + PALETTE_SWATCH_SIZE, PALETTE_SWATCH_SIZE))
        image.save(output_directory / f"loader_bg_palette{palette_index:02d}.png")

    print(
        f"exported {PALETTE_COUNT} BG palette strips "
        f"({COLORS_PER_PALETTE * PALETTE_SWATCH_SIZE}x{PALETTE_SWATCH_SIZE})"
    )


def import_png(
    png_path: Path, tiles_path: Path, palette_path: Path, palette_index: int = 0
) -> None:
    with Image.open(png_path) as image:
        if image.mode != "P":
            raise ValueError(f"{png_path} must be an indexed-color PNG (mode P)")
        if image.size != (SHEET_WIDTH, SHEET_HEIGHT):
            raise ValueError(
                f"expected a {SHEET_WIDTH}x{SHEET_HEIGHT} PNG, "
                f"got {image.width}x{image.height}"
            )
        palette = image.getpalette(rawmode="RGB")
        if palette is None:
            raise ValueError(f"{png_path} has no RGB palette")
        tiles = pixels_to_gba_tiles(list(image.getdata()), palette_index)
        gba_palette = rgb_to_gba_palette(palette)

    tiles_path.parent.mkdir(parents=True, exist_ok=True)
    palette_path.parent.mkdir(parents=True, exist_ok=True)
    tiles_path.write_bytes(tiles)
    palette_path.write_bytes(gba_palette)


def roundtrip(data_path: Path) -> None:
    expected_tiles, expected_palette = read_loader_bg(data_path)
    with tempfile.TemporaryDirectory(prefix="loader_bg_roundtrip_") as directory:
        temp = Path(directory)
        for palette_index in range(PALETTE_COUNT):
            png_path = temp / f"loader_bg_pal{palette_index:02d}.png"
            tiles_path = temp / f"loader_bg_pal{palette_index:02d}.4bpp"
            palette_path = temp / f"loader_bg_pal{palette_index:02d}.gbapal"
            extract_png(data_path, png_path, palette_index)
            import_png(png_path, tiles_path, palette_path, palette_index)
            if tiles_path.read_bytes() != expected_tiles:
                raise AssertionError(
                    f"BG tile data changed during palette {palette_index} PNG round trip"
                )
            if palette_path.read_bytes() != expected_palette:
                raise AssertionError(
                    f"BG palette data changed during palette {palette_index} PNG round trip"
                )

    digest = hashlib.sha256(expected_tiles + expected_palette).hexdigest()
    print(
        f"all {PALETTE_COUNT} palette variants round trip OK: "
        f"0x{len(expected_tiles):X} tile bytes + "
        f"0x{len(expected_palette):X} palette bytes (sha256 {digest})"
    )


def signed_coordinate(value: int, bits: int) -> int:
    sign = 1 << (bits - 1)
    return value - (1 << bits) if value & sign else value


def decode_oam_entry(attr0: int, attr1: int, attr2: int) -> OamEntry | None:
    shape = (attr0 >> 14) & 3
    size = (attr1 >> 14) & 3
    if shape not in OAM_DIMENSIONS:
        return None
    width, height = OAM_DIMENSIONS[shape][size]
    affine = bool((attr0 >> 8) & 3)
    return OamEntry(
        x=signed_coordinate(attr1 & 0x1FF, 9),
        y=signed_coordinate(attr0 & 0xFF, 8),
        width=width,
        height=height,
        tile=attr2 & 0x3FF,
        palette=(attr2 >> 12) & 0xF,
        bpp=8 if attr0 & 0x2000 else 4,
        h_flip=not affine and bool(attr1 & 0x1000),
        v_flip=not affine and bool(attr1 & 0x2000),
        affine=affine,
        attr0=attr0,
        attr1=attr1,
        attr2=attr2,
    )


def parse_c_integer(value: str) -> int:
    value = value.strip()
    value = re.sub(r"[uUlL]+$", "", value)
    if not re.fullmatch(r"(?:0[xX][0-9a-fA-F]+|[0-9]+)", value):
        raise ValueError(f"unsupported OAM_ENTRY value: {value}")
    return int(value, 0)


def find_initializer_end(source: str, start: int) -> int:
    depth = 0
    for position in range(start, len(source)):
        if source[position] == "{":
            depth += 1
        elif source[position] == "}":
            depth -= 1
            if depth == 0:
                return position
    raise ValueError("unterminated OAMData initializer")


def parse_oam_arrays(source_path: Path) -> list[tuple[str, list[list[OamEntry]]]]:
    source = source_path.read_text(encoding="utf-8")
    declaration = re.compile(r"\bOAMData\s+(\w+)\s*(?:\[[^\]]*\]\s*)+\s*=\s*\{")
    entry_pattern = re.compile(r"OAM_ENTRY\s*\(([^()]*)\)")
    arrays: list[tuple[str, list[list[OamEntry]]]] = []

    for match in declaration.finditer(source):
        body_start = source.find("{", match.start())
        body_end = find_initializer_end(source, body_start)
        frames: list[list[OamEntry]] = []
        frame: list[OamEntry] = []
        for entry_match in entry_pattern.finditer(source, body_start, body_end):
            values = [parse_c_integer(value) for value in entry_match.group(1).split(",")]
            if len(values) != 4:
                raise ValueError(f"expected four OAM_ENTRY arguments in {source_path}")
            attr0, attr1, attr2, affine_param = values
            if affine_param == 0xFFFF:
                if frame:
                    frames.append(frame)
                    frame = []
                continue
            decoded = decode_oam_entry(attr0, attr1, attr2)
            if decoded is not None:
                frame.append(decoded)
        if frame:
            frames.append(frame)
        if frames:
            arrays.append((match.group(1), frames))
    return arrays


def top_level_records(initializer: str) -> list[str]:
    records: list[str] = []
    depth = 0
    start = 0
    for position, character in enumerate(initializer):
        if character == "{":
            depth += 1
            if depth == 2:
                start = position + 1
        elif character == "}":
            if depth == 2:
                records.append(initializer[start:position])
            depth -= 1
    return records


def parse_struct_sprite_arrays(source_path: Path) -> list[tuple[str, list[list[OamEntry]]]]:
    source = re.sub(r"/\*.*?\*/|//[^\n]*", "", source_path.read_text(encoding="utf-8"), flags=re.S)
    definitions = {
        "FieldObjectSpriteFrame": (3, None, None),
        "IslandBuildingSprite": (3, 4, 5),
        "FallingFruitProfile": (3, 6, 7),
    }
    arrays: list[tuple[str, list[list[OamEntry]]]] = []
    number_pattern = re.compile(r"-?(?:0[xX][0-9a-fA-F]+|[0-9]+)")

    for type_name, (tile_field, palette_field, h_flip_field) in definitions.items():
        declaration = re.compile(rf"\b{type_name}\s+(\w+)\s*\[[^\]]*\]\s*=\s*\{{")
        for match in declaration.finditer(source):
            body_start = source.find("{", match.start())
            body_end = find_initializer_end(source, body_start)
            frames: list[list[OamEntry]] = []
            for record in top_level_records(source[body_start : body_end + 1]):
                values = [int(value, 0) for value in number_pattern.findall(record)]
                if len(values) <= tile_field:
                    continue
                oam_attributes, y_offset, x_offset = values[:3]
                palette = values[palette_field] if palette_field is not None else 0
                h_flip = values[h_flip_field] if h_flip_field is not None else 0
                v_flip = values[6] if type_name == "IslandBuildingSprite" else 0
                attr0 = ((oam_attributes >> 14) & 3) << 14
                attr1 = ((oam_attributes >> 30) & 3) << 14
                attr1 |= (h_flip & 1) << 12 | (v_flip & 1) << 13
                attr2 = (values[tile_field] & 0x3FF) | ((palette & 0xF) << 12)
                entry = decode_oam_entry(attr0, attr1, attr2)
                if entry is not None:
                    entry.x = x_offset
                    entry.y = y_offset
                    frames.append([entry])
            if frames:
                arrays.append((match.group(1), frames))
    return arrays


def obj_pixel(tiles: bytes, entry: OamEntry, x: int, y: int) -> int:
    if entry.h_flip:
        x = entry.width - 1 - x
    if entry.v_flip:
        y = entry.height - 1 - y
    tile_x, pixel_x = divmod(x, 8)
    tile_y, pixel_y = divmod(y, 8)
    tile_unit = entry.tile + tile_y * 32

    if entry.bpp == 4:
        tile_unit += tile_x
        offset = tile_unit * 32 + pixel_y * 4 + pixel_x // 2
        if offset >= len(tiles):
            return 0
        packed = tiles[offset]
        color = (packed >> (4 * (pixel_x & 1))) & 0xF
        return entry.palette * 16 + color if color else 0

    tile_unit += tile_x * 2
    offset = tile_unit * 32 + pixel_y * 8 + pixel_x
    return tiles[offset] if offset < len(tiles) else 0


def render_oam_frame(
    entries: list[OamEntry], tiles: bytes, palette_rgb: list[int]
) -> Image.Image:
    min_x = min(entry.x for entry in entries)
    min_y = min(entry.y for entry in entries)
    max_x = max(entry.x + entry.width for entry in entries)
    max_y = max(entry.y + entry.height for entry in entries)
    image = Image.new("RGBA", (max_x - min_x, max_y - min_y), (0, 0, 0, 0))
    pixels = image.load()

    # Earlier OAM entries win ties, so paint later entries first.
    for entry in reversed(entries):
        for y in range(entry.height):
            for x in range(entry.width):
                color = obj_pixel(tiles, entry, x, y)
                if color & 0xF or entry.bpp == 8 and color:
                    base = color * 3
                    pixels[entry.x - min_x + x, entry.y - min_y + y] = (
                        palette_rgb[base],
                        palette_rgb[base + 1],
                        palette_rgb[base + 2],
                        255,
                    )
    return image


def render_loader_backgrounds(data_path: Path, output_directory: Path) -> int:
    data = data_path.read_bytes()
    tiles, palette = read_loader_bg(data_path)
    palette_rgb = gba_palette_to_rgb(palette)
    tilemap_offsets = {0: 0x1648, 1: 0x18098, 2: 0x3648, 3: 0x5648}
    background_directory = output_directory / "loader_backgrounds"
    background_directory.mkdir(parents=True, exist_ok=True)

    for bg, tilemap_offset in tilemap_offsets.items():
        tilemap = data[tilemap_offset : tilemap_offset + 0x2000]
        image = Image.new("RGB", (512, 512))
        pixels = image.load()
        for tile_y in range(64):
            for tile_x in range(64):
                screen_block = (tile_y // 32) * 2 + tile_x // 32
                map_index = screen_block * 1024 + (tile_y % 32) * 32 + tile_x % 32
                entry = int.from_bytes(tilemap[map_index * 2 : map_index * 2 + 2], "little")
                tile_number = entry & 0x3FF
                palette_base = ((entry >> 12) & 0xF) * 16
                for y in range(8):
                    source_y = 7 - y if entry & 0x800 else y
                    for x in range(8):
                        source_x = 7 - x if entry & 0x400 else x
                        offset = tile_number * 32 + source_y * 4 + source_x // 2
                        packed = tiles[offset]
                        color = palette_base + ((packed >> (4 * (source_x & 1))) & 0xF)
                        base = color * 3
                        pixels[tile_x * 8 + x, tile_y * 8 + y] = tuple(
                            palette_rgb[base : base + 3]
                        )
        image.save(background_directory / f"bg{bg}.png")
    return len(tilemap_offsets)


def render_text_tilemap(
    tilemap: bytes,
    width_tiles: int,
    height_tiles: int,
    tiles: bytes,
    palette_rgb: list[int],
    transparent_zero: bool = False,
) -> Image.Image:
    if len(tilemap) != width_tiles * height_tiles * 2:
        raise ValueError("tilemap size does not match its dimensions")
    image = Image.new("RGBA", (width_tiles * 8, height_tiles * 8), (0, 0, 0, 0))
    pixels = image.load()
    for tile_y in range(height_tiles):
        for tile_x in range(width_tiles):
            map_index = tile_y * width_tiles + tile_x
            entry = int.from_bytes(tilemap[map_index * 2 : map_index * 2 + 2], "little")
            if transparent_zero and entry == 0:
                continue
            tile_number = entry & 0x3FF
            palette_base = ((entry >> 12) & 0xF) * 16
            for y in range(8):
                source_y = 7 - y if entry & 0x800 else y
                for x in range(8):
                    source_x = 7 - x if entry & 0x400 else x
                    offset = tile_number * 32 + source_y * 4 + source_x // 2
                    packed = tiles[offset]
                    color = palette_base + ((packed >> (4 * (source_x & 1))) & 0xF)
                    if transparent_zero and (color & 0xF) == 0:
                        continue
                    base = color * 3
                    pixels[tile_x * 8 + x, tile_y * 8 + y] = (
                        palette_rgb[base],
                        palette_rgb[base + 1],
                        palette_rgb[base + 2],
                        255,
                    )
    return image


def parse_item_field_tiles(program_root: Path) -> list[tuple[int, str, int, int]]:
    source_path = program_root / "payload" / "src" / "island_field.c"
    source = source_path.read_text(encoding="utf-8")
    start = source.find("g_ItemDefinitions[")
    if start < 0:
        raise ValueError(f"g_ItemDefinitions not found in {source_path}")
    body_start = source.find("{", start)
    body_end = find_initializer_end(source, body_start)
    pattern = re.compile(
        r"\{\s*(0[xX][0-9a-fA-F]+|[0-9]+)\s*,\s*"
        r"(0[xX][0-9a-fA-F]+|[0-9]+)[^{}]*\}\s*,?\s*/\*\s*(Item_\w+)\s*\*/"
    )
    return [
        (index, match.group(3), int(match.group(1), 0), int(match.group(2), 0))
        for index, match in enumerate(pattern.finditer(source, body_start, body_end))
    ]


def load_world_graphics(
    data_path: Path, program_root: Path, island_data_path: Path | None
) -> tuple[bytes, bytes, bytes]:
    tiles, _ = read_loader_bg(data_path)
    program_data_path = program_root / "payload" / "data" / "data.bin"
    program_data = program_data_path.read_bytes()
    required_size = 0xC15C + BG_PALETTE_SIZE
    if len(program_data) < required_size:
        raise ValueError(f"{program_data_path} is too small for the world assets")
    palette = program_data[0xC15C : 0xC15C + BG_PALETTE_SIZE]
    if island_data_path is not None:
        island_data = island_data_path.read_bytes()
        if len(island_data) < 0x2948:
            raise ValueError(f"{island_data_path} is too small to contain earth_tex")
        tiles = island_data[0x1948:0x2948] + tiles[0x1000:]
    return tiles, palette, program_data


def extract_world_assets(
    data_path: Path, output_directory: Path, program_root: Path, island_data_path: Path | None
) -> int:
    program_root = program_root.resolve()
    tiles, palette, program_data = load_world_graphics(data_path, program_root, island_data_path)
    palette_rgb = gba_palette_to_rgb(palette)
    world_directory = output_directory / "world"
    acres_directory = world_directory / "acres"
    buildings_directory = world_directory / "buildings"
    items_directory = world_directory / "items"
    for directory in (acres_directory, buildings_directory, items_directory):
        directory.mkdir(parents=True, exist_ok=True)
    manifest: list[dict[str, object]] = []

    for side, offset in (("right", 0x1D64), ("left", 0x3D64)):
        for variant in range(4):
            start = offset + variant * 0x800
            relative = Path("acres") / f"{side}_{variant}.png"
            render_text_tilemap(
                program_data[start : start + 0x800], 32, 32, tiles, palette_rgb
            ).save(world_directory / relative)
            manifest.append(
                {"png": relative.as_posix(), "kind": "acre", "side": side, "variant": variant}
            )

    building_maps = (
        ("cabana", 0x6584, 8, 8),
        ("islander_house", 0x6604, 8, 6),
    )
    for name, offset, width, height in building_maps:
        size = width * height * 2
        relative = Path("buildings") / f"{name}.png"
        render_text_tilemap(
            program_data[offset : offset + size],
            width,
            height,
            tiles,
            palette_rgb,
            transparent_zero=True,
        ).save(world_directory / relative)
        manifest.append({"png": relative.as_posix(), "kind": "building", "name": name})

    for item_index, name, tile_entry, entity_type in parse_item_field_tiles(program_root):
        # Values 1 and 2 select the separately defined building maps.
        if tile_entry in (1, 2):
            continue
        relative = Path("items") / f"{item_index:03d}_{name}.png"
        if entity_type in (12, 13):
            stump_base = 0x328C if entity_type == 12 else 0x3294
            item_entries = (0, tile_entry, tile_entry + 1, 0) + tuple(
                stump_base + offset for offset in range(4)
            )
            width_tiles, height_tiles = 4, 2
        else:
            item_entries = tuple(tile_entry + offset for offset in range(4))
            width_tiles, height_tiles = 2, 2
        item_tilemap = b"".join(entry.to_bytes(2, "little") for entry in item_entries)
        render_text_tilemap(
            item_tilemap,
            width_tiles,
            height_tiles,
            tiles,
            palette_rgb,
            transparent_zero=True,
        ).save(world_directory / relative)
        manifest.append(
            {
                "png": relative.as_posix(),
                "kind": "field_item",
                "item_index": item_index,
                "name": name,
                "tile_entry": f"0x{tile_entry:04X}",
                "field_entity_type": entity_type,
                "tile": tile_entry & 0x3FF,
                "palette": (tile_entry >> 12) & 0xF,
                "width": width_tiles * 8,
                "height": height_tiles * 8,
            }
        )

    (world_directory / "manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
    )
    print(f"extracted {len(manifest)} world assets")
    return len(manifest)


def extract_sprites(
    data_path: Path,
    output_directory: Path,
    program_root: Path,
    include_backgrounds: bool,
    island_data_path: Path | None,
    include_world: bool,
) -> None:
    tiles, palette = read_loader_obj(data_path)
    if island_data_path is not None:
        island_data = island_data_path.read_bytes()
        if len(island_data) < 0x3968:
            raise ValueError(
                f"{island_data_path} is too small to contain npc_tex and npc_pal"
            )
        tiles = island_data[0x2948:0x3948] + tiles[0x1000:]
        palette = palette[:0x20] + island_data[0x3948:0x3968] + palette[0x40:]
    palette_rgb = gba_palette_to_rgb(palette)
    loader_root = Path(__file__).resolve().parents[1]
    roots = (("loader", loader_root), ("program", program_root.resolve()))
    manifest: list[dict[str, object]] = []
    sprite_count = 0

    for source_name, root in roots:
        source_directory = root / "payload" / "src"
        if not source_directory.is_dir():
            raise ValueError(f"sprite definition directory does not exist: {source_directory}")
        for source_path in sorted(source_directory.rglob("*.c")):
            if source_path.name == "all.c":
                continue
            arrays = parse_oam_arrays(source_path)
            if source_name == "program":
                arrays += parse_struct_sprite_arrays(source_path)
            for array_name, frames in arrays:
                array_directory = output_directory / source_name / source_path.stem / array_name
                array_directory.mkdir(parents=True, exist_ok=True)
                for frame_index, entries in enumerate(frames):
                    relative_png = (
                        Path(source_name) / source_path.stem / array_name / f"frame_{frame_index:04d}.png"
                    )
                    render_oam_frame(entries, tiles, palette_rgb).save(output_directory / relative_png)
                    manifest.append(
                        {
                            "png": relative_png.as_posix(),
                            "source": str(source_path.relative_to(root)).replace("\\", "/"),
                            "array": array_name,
                            "frame": frame_index,
                            "parts": [asdict(entry) for entry in entries],
                        }
                    )
                    sprite_count += 1

    background_count = render_loader_backgrounds(data_path, output_directory) if include_backgrounds else 0
    world_count = (
        extract_world_assets(data_path, output_directory, program_root, island_data_path)
        if include_world
        else 0
    )
    output_directory.mkdir(parents=True, exist_ok=True)
    (output_directory / "manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
    )
    print(
        f"extracted {sprite_count} composite sprite frames from loader/program definitions"
        + (f" and {background_count} loader backgrounds" if background_count else "")
        + (f"; {world_count} world assets are under world/" if world_count else "")
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)

    extract_parser = subparsers.add_parser("extract", help="extract BG tiles and palette to PNG")
    extract_parser.add_argument("data", type=Path, help="loader payload data.bin")
    extract_parser.add_argument("png", type=Path, help="output indexed PNG")
    extract_parser.add_argument(
        "--palette-index", type=int, default=0, help="palette bank to display (default: 0)"
    )

    all_parser = subparsers.add_parser(
        "extract-all", help="export copies of the BG tiles using consecutive palette banks"
    )
    all_parser.add_argument("data", type=Path, help="loader payload data.bin")
    all_parser.add_argument("output_directory", type=Path, help="directory for output PNGs")
    all_parser.add_argument(
        "--count", type=int, default=PALETTE_COUNT, help="number of palette copies (default: 16)"
    )
    all_parser.add_argument(
        "--palette-index", type=int, default=0, help="first palette bank (default: 0)"
    )

    palettes_parser = subparsers.add_parser(
        "palettes", help="export each BG palette bank as a 256x16 color swatch strip"
    )
    palettes_parser.add_argument("data", type=Path, help="loader payload data.bin")
    palettes_parser.add_argument(
        "output_directory", type=Path, help="directory for the 16 palette PNGs"
    )

    import_parser = subparsers.add_parser("import", help="convert the PNG back to GBA binaries")
    import_parser.add_argument("png", type=Path, help="input indexed PNG")
    import_parser.add_argument("tiles", type=Path, help="output 4bpp tile data")
    import_parser.add_argument("palette", type=Path, help="output GBA palette data")
    import_parser.add_argument(
        "--palette-index", type=int, default=0, help="palette bank used by the PNG (default: 0)"
    )

    sprites_parser = subparsers.add_parser(
        "sprites", help="render individual composite sprites from OAM definitions"
    )
    sprites_parser.add_argument("data", type=Path, help="loader payload data.bin")
    sprites_parser.add_argument("output_directory", type=Path, help="directory for extracted PNGs")
    sprites_parser.add_argument(
        "--program-root",
        type=Path,
        default=Path(__file__).resolve().parents[2] / "island-program-mb",
        help="island-program-mb repository (default: sibling of island-loader-mb)",
    )
    sprites_parser.add_argument(
        "--no-backgrounds",
        action="store_true",
        help="do not also render the loader's four tilemap-defined backgrounds",
    )
    sprites_parser.add_argument(
        "--island-data",
        type=Path,
        help="optional 0x3980-byte AGB island data used to overlay NPC tiles and palette",
    )
    sprites_parser.add_argument(
        "--no-world",
        action="store_true",
        help="do not export acre variants, buildings, and field-item tiles",
    )

    world_parser = subparsers.add_parser(
        "world", help="render acre variants, buildings, and environmental field tiles"
    )
    world_parser.add_argument("data", type=Path, help="loader payload data.bin")
    world_parser.add_argument("output_directory", type=Path, help="directory for extracted PNGs")
    world_parser.add_argument(
        "--program-root",
        type=Path,
        default=Path(__file__).resolve().parents[2] / "island-program-mb",
        help="island-program-mb repository (default: sibling of island-loader-mb)",
    )
    world_parser.add_argument(
        "--island-data",
        type=Path,
        help="optional 0x3980-byte AGB island data used to overlay earth_tex",
    )

    test_parser = subparsers.add_parser("roundtrip", help="verify a byte-identical PNG round trip")
    test_parser.add_argument("data", type=Path, help="loader payload data.bin")
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if args.command == "extract":
        extract_png(args.data, args.png, args.palette_index)
    elif args.command == "extract-all":
        extract_all_palettes(args.data, args.output_directory, args.count, args.palette_index)
    elif args.command == "palettes":
        extract_palette_swatches(args.data, args.output_directory)
    elif args.command == "import":
        import_png(args.png, args.tiles, args.palette, args.palette_index)
    elif args.command == "sprites":
        extract_sprites(
            args.data,
            args.output_directory,
            args.program_root,
            not args.no_backgrounds,
            args.island_data,
            not args.no_world,
        )
    elif args.command == "world":
        extract_world_assets(args.data, args.output_directory, args.program_root, args.island_data)
    else:
        roundtrip(args.data)


if __name__ == "__main__":
    main()
