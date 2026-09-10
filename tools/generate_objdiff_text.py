#!/usr/bin/env python3
"""Generate per-source objdiff targets from the canonical loader assembly."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

# Ranges are half-open original addresses and deliberately contain no
# linker-layout assumptions.
UNIT_RANGES = {
    "main": ((".text", 0x0201820C, 0x0201821C),),
    "interrupt": ((".text", 0x0201821C, 0x02018348),),
    "m_msg": ((".text", 0x02018348, 0x02018428),),
    "init": ((".text", 0x02018428, 0x020184B8),),
    "m_font_draw": ((".text", 0x020184B8, 0x020187A8),),
    "lib": ((".text", 0x020187A8, 0x02018A18),),
    "audio": ((".text", 0x02018A18, 0x02018A3C),),
    "m_msg_util": ((".text", 0x02018A3C, 0x02018B1C),),
    "game": ((".text", 0x02018B1C, 0x0201907C),),
    "joyboot": ((".text", 0x0201907C, 0x02019548),),
    "m_msg_sprite": ((".text", 0x02019548, 0x02019A64),),
    "sdk": ((".text", 0x02019A64, 0x02019B98),),
}

FUNCTION_START = re.compile(
    r"^[ \t]*(?:thumb|arm|non_word_aligned_thumb)_func_start[ \t]+(\w+)[ \t]*$"
    r".*?^[ \t]*\1:[^\n]*@[ \t]*(0x[0-9A-Fa-f]+)",
    re.MULTILINE | re.DOTALL,
)
SOURCE_FUNCTION = re.compile(
    r"/\*[ \t]*Original address:[ \t]*(0x[0-9A-Fa-f]+)[ \t]*\*/"
    r"[ \t\r\n]*([^;{}]+?)\{",
    re.MULTILINE,
)
DATA_LABEL = re.compile(r"^(\w+):[ \t]*@[ \t]*(0x[0-9A-Fa-f]+)", re.MULTILINE)
LINKER_SYMBOL = re.compile(r"^(\w+)[ \t]*=[ \t]*(0x[0-9A-Fa-f]+);", re.MULTILINE)


def source_function_names() -> dict[int, str]:
    result: dict[int, str] = {}
    for path in sorted((ROOT / "payload/src").glob("*.c")):
        source = path.read_text(encoding="utf-8")
        for address_text, declaration in SOURCE_FUNCTION.findall(source):
            declaration = re.sub(r"__attribute__\s*\(\(.*?\)\)", "", declaration)
            names = re.findall(r"\b([A-Za-z_]\w*)\s*\(", declaration)
            if names:
                result[int(address_text, 16)] = names[0]
    return result


def address_symbols() -> dict[int, str]:
    result: dict[int, str] = {}
    data_source = (ROOT / "payload/data/data.s").read_text(encoding="utf-8")
    linker = (ROOT / "payload/ld_script.txt").read_text(encoding="utf-8")
    for name, address in DATA_LABEL.findall(data_source):
        result[int(address, 16)] = name
    for name, address in LINKER_SYMBOL.findall(linker):
        result.setdefault(int(address, 16), name)
    return result


def rename_symbols(source: str) -> str:
    for address, name in source_function_names().items():
        source = re.sub(rf"\bsub_{address:08X}\b", name, source)

    symbols = address_symbols()

    def replace_literal(match: re.Match[str]) -> str:
        value = int(match.group(2), 16)
        return match.group(1) + symbols.get(value, match.group(2))

    return re.sub(r"(\.4byte[ \t]+)(0x[0-9A-Fa-f]+)", replace_literal, source)


def split_functions(source: str) -> tuple[str, list[tuple[int, str]]]:
    matches = list(FUNCTION_START.finditer(source))
    if not matches:
        raise ValueError("no functions found in canonical assembly")
    preamble = source[: matches[0].start()]
    preamble = re.sub(r"^[ \t]*\.ifndef SDK_ONLY[ \t]*\r?\n", "", preamble, flags=re.MULTILINE)
    functions: list[tuple[int, str]] = []
    for index, match in enumerate(matches):
        end = matches[index + 1].start() if index + 1 < len(matches) else len(source)
        body = source[match.start():end]
        # The SDK_ONLY guard ends between the last reconstructed function and
        # the first SDK function.  A per-unit target has already discarded the
        # opening directive with the preamble, so discard its matching close.
        body = re.sub(r"^[ \t]*\.endif[ \t]*\r?\n", "", body, flags=re.MULTILINE)
        functions.append((int(match.group(2), 16), body))
    return preamble, functions


def generate(unit: str, assembly: Path) -> str:
    preamble, functions = split_functions(assembly.read_text(encoding="utf-8"))
    output = [preamble]
    for section, start, end in UNIT_RANGES[unit]:
        output.append(f"\n\t.section {section}, \"ax\", %progbits\n")
        selected = [body for address, body in functions if start <= address < end]
        if not selected:
            raise ValueError(f"no functions found for {unit} range {start:#x}-{end:#x}")
        output.extend(selected)
    if unit == "m_msg_sprite":
        output.append(
            "\n\t.section .rodata, \"a\", %progbits\n"
            "\t.incbin \"data/data.bin\", 0x1570, 0x18\n"
        )
    return rename_symbols("".join(output))


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--assembly", type=Path, default=Path("payload/asm/all.s"))
    parser.add_argument("--unit", choices=sorted(UNIT_RANGES), required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(generate(args.unit, args.assembly), encoding="utf-8", newline="\n")
    print(f"Generated {args.output}: {args.unit}")


if __name__ == "__main__":
    main()
