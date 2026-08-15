#!/usr/bin/env bash
set -Eeuo pipefail
mkdir -p release-assets
cd release-assets
rm -f SHA256SUMS
find . -maxdepth 1 -type f ! -name SHA256SUMS -print0 | xargs -0 sha256sum > SHA256SUMS
echo "Checksums generated"
