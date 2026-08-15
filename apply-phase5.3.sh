#!/usr/bin/env bash
set -Eeuo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DST="${1:-.}"
mkdir -p "$DST/.github" "$DST/docs" "$DST/scripts"
cp -a "$SRC/.github/." "$DST/.github/"
cp -a "$SRC/docs/." "$DST/docs/"
cp -a "$SRC/scripts/." "$DST/scripts/"
for f in README.md CHANGELOG.md CONTRIBUTING.md .gitignore LICENSE; do cp "$SRC/$f" "$DST/$f"; done
chmod +x "$DST/scripts/prepare-github-pages.sh"
echo "Applied Phase 5.3 to $DST"
