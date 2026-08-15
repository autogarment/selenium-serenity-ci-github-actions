#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$ROOT/VERSION"
CHANGELOG="$ROOT/CHANGELOG.md"

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 <version> [date]"
  exit 1
fi

VERSION="$1"
DATE="${2:-$(date +%F)}"
SEMVER='^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$'

[[ "$VERSION" =~ $SEMVER ]] || { echo "ERROR: invalid stable version"; exit 1; }
[ -f "$VERSION_FILE" ] || { echo "ERROR: VERSION missing"; exit 1; }
[ -f "$CHANGELOG" ] || { echo "ERROR: CHANGELOG.md missing"; exit 1; }

CURRENT="$(tr -d '[:space:]' < "$VERSION_FILE")"
[ "$CURRENT" = "$VERSION" ] || {
  echo "ERROR: VERSION mismatch: $CURRENT != $VERSION"
  exit 1
}

python3 - "$CHANGELOG" "$VERSION" "$DATE" <<'PY'
from pathlib import Path
import re, sys
path = Path(sys.argv[1])
version, date = sys.argv[2], sys.argv[3]
text = path.read_text(encoding="utf-8")
marker = "## [Unreleased]"
heading = f"## [{version}] - {date}"
if marker not in text:
    raise SystemExit("ERROR: missing [Unreleased] section")
pattern = re.compile(rf"^## \[{re.escape(version)}\](?: - \d{{4}}-\d{{2}}-\d{{2}})?$", re.M)
if pattern.search(text):
    text = pattern.sub(heading, text, count=1)
else:
    text = text.replace(marker, marker + "\n\n" + heading, 1)
path.write_text(text, encoding="utf-8")
PY

echo "CHANGELOG finalized for $VERSION ($DATE)"
