#!/usr/bin/env bash
set -Eeuo pipefail
for f in version.txt release-summary.txt SHA256SUMS; do
 [ -f release-assets/$f ] || { echo "Missing $f"; exit 1; }
done
echo "Release assets verified."
