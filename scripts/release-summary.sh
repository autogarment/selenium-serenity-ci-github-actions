#!/usr/bin/env bash
set -Eeuo pipefail
mkdir -p release-assets
cat > release-assets/release-summary.txt <<EOF
Version: $(cat VERSION)
Commit: $(git rev-parse --short HEAD)
Date: $(date -u)
EOF
