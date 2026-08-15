#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
BROWSER="${1:-chrome}"
HEADLESS="${2:-false}"
TAGS="${3:-@video}"

cd "$ROOT"
printf '\n=== Java Selenium Demo v4.0 - Serenity Phase 1-3 ===\n'
printf 'Browser : %s\nHeadless: %s\nTags    : %s\n\n' "$BROWSER" "$HEADLESS" "$TAGS"

mvn clean verify \
  -Dwebdriver.driver="$BROWSER" \
  -Dheadless="$HEADLESS" \
  -Dtags="$TAGS" \
  -Dcucumber.filter.tags="$TAGS"

"$ROOT/scripts/apply-serenity-bright-theme.sh" "$ROOT/target/site/serenity"

REPORT="$ROOT/target/site/serenity/index.html"
[[ -f "$REPORT" ]] || { echo "Serenity report was not generated: $REPORT" >&2; exit 1; }
printf '\nSerenity report: %s\n' "$REPORT"
