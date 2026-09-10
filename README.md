This repository builds one of the Animal Crossing Multiboot images which comes compressed within the GameCube Animal Crossing entry. This is done to assist in [the decompilation of the overall game](https://github.com/Prakxo/ac-decomp/).

Requires agbcc.  Need to install it like the Pokémon Decompilations, i.e.:

```
git clone https://github.com/pret/agbcc.git
cd agbcc
./build.sh
./install.sh path/to/island_loader_mb
```

It builds the following image:

    da1560a44a9f921238397ea04996b1fa990c91f4  island-loader-mb.gba

## Ninja build

After installing agbcc and devkitARM, generate the build graph and build the
ROM:

```sh
python configure.py
ninja
```

If Ninja was installed as a Python package but is not on `PATH`, pass its
executable to `configure.py` with `--ninja PATH`. `configure.py` also accepts
`--devkitarm PATH` and `--tool-root PATH` when those tools are not installed in
their default locations. Use `--nonmatching` to enable the repository's
nonmatching build mode; rerun the configure command when switching modes.

Useful targets are `payload`, `rom`, and `objdiff_targets`. The Makefiles remain
available as a fallback.

The generated `objdiff.json` exposes one unit for each reconstructed C
translation unit, plus the remaining SDK assembly and payload data. Running
`ninja objdiff_targets` regenerates the per-unit target objects directly from
the canonical assembly and data.
