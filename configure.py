#!/usr/bin/env python3
"""Generate Ninja and objdiff configuration for island-loader-mb."""

from __future__ import annotations

import argparse
import json
import os
import shutil
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent
C_UNITS = [
    "main",
    "interrupt",
    "m_msg",
    "init",
    "m_font_draw",
    "lib",
    "audio",
    "m_msg_util",
    "game",
    "joyboot",
    "m_msg_sprite",
]


def posix(path: Path | str) -> str:
    return Path(path).as_posix()


def escape(value: str) -> str:
    return value.replace("$", "$$").replace(" ", "$ ").replace(":", "$:")


class NinjaWriter:
    def __init__(self) -> None:
        self.lines: list[str] = []

    def line(self, value: str = "") -> None:
        self.lines.append(value)

    def variable(self, name: str, value: str) -> None:
        self.line(f"{name} = {value}")

    def rule(self, name: str, command: str, **attributes: str) -> None:
        self.line(f"rule {name}")
        self.line(f"  command = {command}")
        for key, value in attributes.items():
            self.line(f"  {key} = {value}")
        self.line()

    def build(
        self,
        outputs: str | list[str],
        rule: str,
        inputs: str | list[str] = (),
        *,
        implicit: list[str] = (),
        variables: dict[str, str] | None = None,
    ) -> None:
        if isinstance(outputs, str):
            outputs = [outputs]
        if isinstance(inputs, str):
            inputs = [inputs]
        output_text = " ".join(escape(value) for value in outputs)
        input_text = " ".join(escape(value) for value in inputs)
        implicit_text = ""
        if implicit:
            implicit_text = " | " + " ".join(escape(value) for value in implicit)
        self.line(f"build {output_text}: {rule} {input_text}{implicit_text}".rstrip())
        for key, value in (variables or {}).items():
            self.line(f"  {key} = {value}")

    def write(self, path: Path) -> None:
        path.write_text("\n".join(self.lines) + "\n", encoding="utf-8", newline="\n")


def find_ninja(explicit: Path | None) -> Path:
    if explicit is not None:
        candidate = explicit
    elif found := shutil.which("ninja"):
        candidate = Path(found)
    elif os.name == "nt":
        candidate = Path(sys.executable).parent / "Scripts/ninja.exe"
    else:
        candidate = Path("ninja")
    if candidate != Path("ninja") and not candidate.is_file():
        raise SystemExit(f"Ninja executable not found: {candidate}")
    return candidate.resolve() if candidate.is_file() else candidate


def require(path: Path, description: str) -> None:
    if not path.is_file():
        raise SystemExit(f"{description} not found: {path}")


def emit_c_object(
    ninja: NinjaWriter,
    unit: str,
    *,
    cppflags: str,
    cflags: str,
    asflags: str,
) -> str:
    stem = f"payload/build/payload/src/{unit}"
    source = f"payload/src/{unit}.c"
    ninja.build(f"{stem}.i", "cpp", source, variables={"cppflags": cppflags})
    ninja.build(
        f"{stem}.p.c",
        "preproc",
        f"{stem}.i",
        implicit=["tools/capture_stdout.py"],
        variables={"charmap": "payload/charmap.txt"},
    )
    ninja.build(f"{stem}.s", "cc1", f"{stem}.p.c", variables={"cflags": cflags})
    ninja.build(
        f"{stem}.o",
        "as_compiled",
        f"{stem}.s",
        implicit=["tools/agbcc_footer.s"],
        variables={"asflags": asflags},
    )
    return f"{stem}.o"


def write_objdiff(ninja_path: Path) -> None:
    flags = "-O2 -g -mthumb-interwork -fhex-asm -Wimplicit -Werror -ffix-debug-line"
    units: list[dict[str, object]] = []
    for name in C_UNITS:
        units.append(
            {
                "name": f"payload/{name}",
                "target_path": f"payload/build/objdiff/{name}.target.o",
                "base_path": f"payload/build/payload/src/{name}.o",
                "scratch": {
                    "platform": "gba",
                    "compiler": "agbcc",
                    "c_flags": flags,
                    "ctx_path": f"payload/build/payload/src/{name}.i",
                    "build_ctx": False,
                },
                "metadata": {
                    "complete": False,
                    "source_path": f"payload/src/{name}.c",
                    "auto_generated": False,
                },
            }
        )
    units.extend(
        [
            {
                "name": "payload/sdk",
                "target_path": "payload/build/objdiff/sdk.target.o",
                "base_path": "payload/build/payload/asm/sdk.o",
                "metadata": {
                    "complete": True,
                    "source_path": "payload/asm/all.s",
                    "auto_generated": False,
                },
            },
            {
                "name": "payload/data",
                "target_path": "payload/build/objdiff/data.target.o",
                "base_path": "payload/build/payload/data/data.o",
                "metadata": {
                    "complete": True,
                    "source_path": "payload/data/data.s",
                    "auto_generated": False,
                },
            },
        ]
    )
    config = {
        "min_version": "3.7.1",
        "custom_make": posix(ninja_path),
        "build_base": True,
        "build_target": True,
        "watch_patterns": ["*.c", "*.h", "*.s", "*.inc", "*.py", "*.bin", "*.txt", "*.json"],
        "ignore_patterns": ["build/**/*", "payload/build/**/*"],
        "units": units,
    }
    (ROOT / "objdiff.json").write_text(
        json.dumps(config, indent=2) + "\n", encoding="utf-8", newline="\n"
    )


def generate(args: argparse.Namespace) -> None:
    ninja_path = find_ninja(args.ninja)
    devkitarm = args.devkitarm.resolve()
    tool_root = args.tool_root.resolve()
    suffix = ".exe" if os.name == "nt" else ""
    tool_bin = devkitarm / "bin"
    cpp = tool_bin / f"arm-none-eabi-cpp{suffix}"
    assembler = tool_bin / f"arm-none-eabi-as{suffix}"
    linker = tool_bin / f"arm-none-eabi-ld{suffix}"
    objcopy = tool_bin / f"arm-none-eabi-objcopy{suffix}"
    cc1 = tool_root / f"agbcc/bin/agbcc{suffix}"
    preproc = tool_root / f"preproc/preproc{suffix}"
    gbagfx = tool_root / f"gbagfx/gbagfx{suffix}"
    gbafix = tool_root / f"gbafix/gbafix{suffix}"
    for path, description in (
        (cpp, "ARM preprocessor"),
        (assembler, "ARM assembler"),
        (linker, "ARM linker"),
        (objcopy, "ARM objcopy"),
        (cc1, "agbcc"),
        (preproc, "preproc"),
        (gbagfx, "gbagfx"),
        (gbafix, "gbafix"),
    ):
        require(path, description)

    payload_build = ROOT / "payload/build/payload"
    outer_build = ROOT / "build/island-loader-mb"
    for directory in (
        payload_build / "src",
        payload_build / "asm",
        payload_build / "data",
        ROOT / "payload/build/objdiff",
        outer_build / "asm",
        outer_build / "data",
    ):
        directory.mkdir(parents=True, exist_ok=True)
    (payload_build / "ld_script.ld").write_text(
        (ROOT / "payload/ld_script.txt").read_text(encoding="utf-8"),
        encoding="utf-8",
        newline="\n",
    )
    (outer_build / "ld_script.ld").write_text(
        (ROOT / "ld_script.txt").read_text(encoding="utf-8"),
        encoding="utf-8",
        newline="\n",
    )

    payload_defines = " -DNONMATCHING" if args.nonmatching else ""
    cppflags = (
        "-I " + posix(tool_root / "agbcc/include")
        + " -iquote payload/include -nostdinc -undef" + payload_defines
    )
    cflags = "-O2 -g -mthumb-interwork -fhex-asm -Wimplicit -Werror -ffix-debug-line"
    asflags = "-mcpu=arm7tdmi -I payload -I payload/include"
    if args.nonmatching:
        asflags += " --defsym NONMATCHING=1"

    ninja = NinjaWriter()
    ninja.line("# Generated by configure.py. Do not edit.")
    ninja.line("ninja_required_version = 1.10")
    ninja.variable("python", posix(Path(sys.executable).resolve()))
    ninja.variable("ninja", posix(ninja_path))
    ninja.variable("cpp", posix(cpp))
    ninja.variable("as", posix(assembler))
    ninja.variable("ld", posix(linker))
    ninja.variable("objcopy", posix(objcopy))
    ninja.variable("cc1", posix(cc1))
    ninja.variable("preproc", posix(preproc))
    ninja.variable("gbagfx", posix(gbagfx))
    ninja.variable("gbafix", posix(gbafix))
    ninja.line()

    configure_args = [
        f'--ninja "{posix(ninja_path)}"',
        f'--devkitarm "{posix(devkitarm)}"',
        f'--tool-root "{posix(tool_root)}"',
    ]
    if args.nonmatching:
        configure_args.append("--nonmatching")
    ninja.rule(
        "configure",
        '"$python" configure.py ' + " ".join(configure_args),
        description="CONFIGURE",
        generator="1",
    )
    ninja.rule(
        "cpp",
        '"$cpp" $cppflags -MMD -MF "${out}.d" -MT "$out" -o "$out" "$in"',
        description="CPP $in",
        depfile="${out}.d",
        deps="gcc",
    )
    ninja.rule(
        "preproc",
        '"$python" tools/capture_stdout.py "$out" "$preproc" "$in" "$charmap"',
        description="PREPROC $in",
    )
    ninja.rule("cc1", '"$cc1" $cflags -o "$out" "$in"', description="CC $in")
    ninja.rule(
        "as_compiled",
        '"$as" $asflags -o "$out" "$in" tools/agbcc_footer.s',
        description="AS $out",
    )
    ninja.rule("as", '"$as" $asflags -o "$out" "$in"', description="AS $out")
    ninja.rule("objcopy", '"$objcopy" -O binary "$in" "$out"', description="OBJCOPY $out")
    ninja.rule("payload_lz", '"$gbagfx" "$in" "$out" -search 1', description="LZ $out")
    ninja.rule(
        "objcopy_fix",
        'cmd /d /s /c ""$objcopy" -O binary "$in" "$out" && "$gbafix" "$out" --silent"',
        description="OBJCOPY $out",
    )
    ninja.rule(
        "payload_link",
        'cmd /d /s /c "cd /d payload\\build\\payload && "$ld" -Map ../../payload.map '
        '-T ld_script.ld -o ../../payload.elf $link_inputs -L' + posix(tool_root / "agbcc/lib")
        + ' -lgcc -lc"',
        description="LD payload/payload.elf",
    )
    ninja.rule(
        "outer_link",
        'cmd /d /s /c "cd /d build\\island-loader-mb && "$ld" -Map ../../island-loader-mb.map '
        '-T ld_script.ld -o ../../island-loader-mb.elf asm/crt0.o data/payload.o '
        '-L' + posix(tool_root / "agbcc/lib") + ' -lgcc -lc && "$gbafix" '
        '../../island-loader-mb.elf -cAGBJ -m01 -r0 --silent"',
        description="LD island-loader-mb.elf",
    )
    ninja.rule(
        "objdiff_split",
        '"$python" tools/generate_objdiff_text.py --unit $unit --output "$out"',
        description="SPLIT $unit",
    )
    ninja.rule(
        "objdiff_prepare",
        '"$python" tools/prepare_objdiff_target.py "$in" "$out"',
        description="OBJDIF-FIX $out",
    )

    ninja.build(
        [
            "build.ninja",
            "objdiff.json",
            "payload/build/payload/ld_script.ld",
            "build/island-loader-mb/ld_script.ld",
        ],
        "configure",
        ["configure.py", "payload/ld_script.txt", "ld_script.txt", "tools/generate_objdiff_text.py"],
    )

    c_objects = [
        emit_c_object(ninja, unit, cppflags=cppflags, cflags=cflags, asflags=asflags)
        for unit in C_UNITS
    ]
    payload_asm_dependencies = [
        "asm/macros/function.inc",
        "constants/gba_constants.inc",
    ]
    outer_asm_dependencies = [
        "asm/macros/function.inc",
        "constants/gba_constants.inc",
    ]
    crt = "payload/build/payload/asm/crt0.o"
    sdk = "payload/build/payload/asm/sdk.o"
    data = "payload/build/payload/data/data.o"
    ninja.build(
        crt,
        "as",
        "payload/asm/crt0.s",
        implicit=payload_asm_dependencies,
        variables={"asflags": asflags},
    )
    ninja.build(
        sdk,
        "as",
        "payload/asm/all.s",
        implicit=payload_asm_dependencies,
        variables={"asflags": asflags + " --defsym SDK_ONLY=1"},
    )
    ninja.build(
        data,
        "as",
        "payload/data/data.s",
        implicit=["payload/data/data.bin", *payload_asm_dependencies],
        variables={"asflags": asflags},
    )

    payload_link_inputs = [crt, *c_objects, sdk, data]
    relative_inputs = [
        "asm/crt0.o",
        *[f"src/{unit}.o" for unit in C_UNITS],
        "asm/sdk.o",
        "data/data.o",
    ]
    ninja.build(
        "payload/payload.elf",
        "payload_link",
        payload_link_inputs,
        implicit=["payload/build/payload/ld_script.ld"],
        variables={"link_inputs": " ".join(relative_inputs)},
    )
    ninja.build("payload/payload.gba", "objcopy", "payload/payload.elf")
    ninja.build("payload/payload.gba.lz", "payload_lz", "payload/payload.gba")

    outer_crt = "build/island-loader-mb/asm/crt0.o"
    outer_data = "build/island-loader-mb/data/payload.o"
    ninja.build(
        outer_crt,
        "as",
        "asm/crt0.s",
        implicit=outer_asm_dependencies,
        variables={"asflags": "-mcpu=arm7tdmi -I ."},
    )
    ninja.build(
        outer_data,
        "as",
        "data/payload.s",
        implicit=["payload/payload.gba.lz"],
        variables={"asflags": "-mcpu=arm7tdmi -I ."},
    )
    ninja.build(
        "island-loader-mb.elf",
        "outer_link",
        [outer_crt, outer_data],
        implicit=["build/island-loader-mb/ld_script.ld"],
    )
    ninja.build("island-loader-mb.gba", "objcopy_fix", "island-loader-mb.elf")

    objdiff_targets: list[str] = []
    for unit in [*C_UNITS, "sdk"]:
        target_asm = f"payload/build/objdiff/{unit}.target.s"
        raw_target = f"payload/build/objdiff/{unit}.raw.o"
        target = f"payload/build/objdiff/{unit}.target.o"
        ninja.build(
            target_asm,
            "objdiff_split",
            "payload/asm/all.s",
            implicit=["tools/generate_objdiff_text.py", *[f"payload/src/{name}.c" for name in C_UNITS]],
            variables={"unit": unit},
        )
        ninja.build(
            raw_target,
            "as",
            target_asm,
            implicit=payload_asm_dependencies,
            variables={"asflags": asflags},
        )
        ninja.build(
            target,
            "objdiff_prepare",
            raw_target,
            implicit=["tools/prepare_objdiff_target.py"],
        )
        objdiff_targets.append(target)
    data_target = "payload/build/objdiff/data.target.o"
    ninja.build(
        data_target,
        "as",
        "payload/data/data.s",
        implicit=["payload/data/data.bin", *payload_asm_dependencies],
        variables={"asflags": asflags},
    )
    objdiff_targets.append(data_target)

    ninja.build("objdiff_targets", "phony", objdiff_targets)
    ninja.build("payload", "phony", "payload/payload.gba.lz")
    ninja.build("rom", "phony", "island-loader-mb.gba")
    ninja.build("all", "phony", "rom")
    ninja.line()
    ninja.line("default all")
    ninja.write(ROOT / "build.ninja")
    write_objdiff(ninja_path)
    print(f"Generated build.ninja and objdiff.json (Ninja: {ninja_path})")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--ninja", type=Path, help="path to Ninja")
    parser.add_argument(
        "--devkitarm",
        type=Path,
        default=Path(os.environ.get("DEVKITARM", "C:/devkitPro/devkitARM")),
    )
    parser.add_argument("--tool-root", type=Path, default=Path("tools"))
    parser.add_argument("--nonmatching", action="store_true")
    generate(parser.parse_args())


if __name__ == "__main__":
    main()
