#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT="$ROOT/target/site/serenity/index.html"
[[ -f "$REPORT" ]] || { echo "Report not found. Run ./scripts/run-demo.sh first." >&2; exit 1; }
xdg-open "$REPORT" >/dev/null 2>&1 &
