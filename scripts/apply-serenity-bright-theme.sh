#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="${1:-$ROOT/target/site/serenity}"
SOURCE_CSS="$ROOT/dashboard-theme/serenity-bright-theme.css"
TARGET_CSS="$REPORT_DIR/serenity-bright-theme.css"

[[ -d "$REPORT_DIR" ]] || {
  echo "Serenity report directory not found: $REPORT_DIR" >&2
  exit 1
}
[[ -f "$SOURCE_CSS" ]] || {
  echo "Theme file not found: $SOURCE_CSS" >&2
  exit 1
}

cp "$SOURCE_CSS" "$TARGET_CSS"

python3 - "$REPORT_DIR" <<'PY'
from pathlib import Path
import sys

report_dir = Path(sys.argv[1])
marker = '<link rel="stylesheet" href="serenity-bright-theme.css">'
updated = 0

for html_file in report_dir.glob('*.html'):
    text = html_file.read_text(encoding='utf-8', errors='replace')
    if marker in text:
        continue
    if '</head>' not in text:
        continue
    text = text.replace('</head>', f'  {marker}\n</head>', 1)
    html_file.write_text(text, encoding='utf-8')
    updated += 1

print(f"Applied bright theme to {updated} Serenity HTML file(s).")
PY
