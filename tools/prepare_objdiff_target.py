#!/usr/bin/env python3
"""Remove GNU assembler marker relocations unsupported by objdiff 3.7.x."""

from __future__ import annotations

import argparse
import struct
from dataclasses import dataclass
from pathlib import Path


ELF_HEADER_SIZE = 52
EM_ARM = 40
SHT_RELA = 4
SHT_REL = 9
R_ARM_V4BX = 40


@dataclass(frozen=True)
class Section:
    header_offset: int
    section_type: int
    offset: int
    size: int
    entry_size: int


def read_sections(data: bytearray) -> list[Section]:
    if len(data) < ELF_HEADER_SIZE or data[:4] != b"\x7fELF":
        raise ValueError("input is not an ELF file")
    if data[4] != 1 or data[5] != 1 or struct.unpack_from("<H", data, 18)[0] != EM_ARM:
        raise ValueError("expected a 32-bit little-endian ARM object")
    table = struct.unpack_from("<I", data, 32)[0]
    stride, count = struct.unpack_from("<HH", data, 46)
    result = []
    for index in range(count):
        header = table + index * stride
        fields = struct.unpack_from("<10I", data, header)
        result.append(Section(header, fields[1], fields[4], fields[5], fields[9]))
    return result


def remove_v4bx(data: bytearray, sections: list[Section]) -> int:
    removed = 0
    for section in sections:
        if section.section_type not in (SHT_REL, SHT_RELA):
            continue
        entry_size = section.entry_size or (8 if section.section_type == SHT_REL else 12)
        entries = []
        for offset in range(section.offset, section.offset + section.size, entry_size):
            entry = bytes(data[offset:offset + entry_size])
            relocation_info = struct.unpack_from("<I", entry, 4)[0]
            if relocation_info & 0xFF == R_ARM_V4BX:
                removed += 1
            else:
                entries.append(entry)
        compacted = b"".join(entries)
        old_end = section.offset + section.size
        new_end = section.offset + len(compacted)
        data[section.offset:new_end] = compacted
        data[new_end:old_end] = b"\0" * (old_end - new_end)
        struct.pack_into("<I", data, section.header_offset + 20, len(compacted))
    return removed


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    data = bytearray(args.input.read_bytes())
    removed = remove_v4bx(data, read_sections(data))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(data)
    print(f"Prepared {args.output}: removed {removed} R_ARM_V4BX relocations")


if __name__ == "__main__":
    main()
