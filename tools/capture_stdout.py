#!/usr/bin/env python3
"""Run a command and atomically capture its standard output."""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) < 3:
        raise SystemExit(f"usage: {sys.argv[0]} OUTPUT COMMAND [ARG ...]")
    output = Path(sys.argv[1])
    temporary = output.with_name(output.name + ".tmp")
    try:
        with temporary.open("wb") as stream:
            subprocess.run(sys.argv[2:], stdout=stream, check=True)
        os.replace(temporary, output)
    finally:
        temporary.unlink(missing_ok=True)


if __name__ == "__main__":
    main()
