#!/usr/bin/env bash
set -Eeuo pipefail
mkdir -p release-assets
echo "$(cat VERSION)" > release-assets/version.txt
[ -d target/site/serenity ] && (cd target/site && zip -rq ../../release-assets/serenity-report.zip serenity) || true
[ -f environment.properties ] && cp environment.properties release-assets/ || true
./scripts/generate-checksums.sh
