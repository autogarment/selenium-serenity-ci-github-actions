#!/usr/bin/env bash

set -uo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

BROWSER="${1:-chrome}"
HEADLESS="${2:-true}"
TAGS="${3:-@smoke}"

cd "$ROOT"

echo
echo "========================================"
echo " Selenium Serenity CI"
echo "========================================"
echo "Browser : $BROWSER"
echo "Headless: $HEADLESS"
echo "Tags    : $TAGS"
echo

set +e

mvn \
  --batch-mode \
  --no-transfer-progress \
  clean verify \
  -Dwebdriver.driver="$BROWSER" \
  -Dheadless="$HEADLESS" \
  -Dtags="$TAGS" \
  -Dcucumber.filter.tags="$TAGS"

TEST_EXIT_CODE=$?

set -e

echo
echo "========================================"
echo " Report verification"
echo "========================================"

SERENITY_REPORT="$ROOT/target/site/serenity/index.html"
JACOCO_REPORT="$ROOT/target/site/jacoco/index.html"
JACOCO_XML="$ROOT/target/site/jacoco/jacoco.xml"

if [[ -f "$SERENITY_REPORT" ]]; then
    echo "OK Serenity:"
    echo "   $SERENITY_REPORT"
else
    echo "WARN Serenity report was not generated"
fi

if [[ -f "$JACOCO_REPORT" ]]; then
    echo "OK JaCoCo HTML:"
    echo "   $JACOCO_REPORT"
else
    echo "WARN JaCoCo HTML report was not generated"
fi

if [[ -f "$JACOCO_XML" ]]; then
    echo "OK JaCoCo XML:"
    echo "   $JACOCO_XML"
else
    echo "WARN JaCoCo XML report was not generated"
fi

if [[ -f "$ROOT/target/jacoco.exec" ]]; then
    echo "OK JaCoCo execution data:"
    echo "   $ROOT/target/jacoco.exec"
else
    echo "WARN target/jacoco.exec was not generated"
fi

echo
echo "Maven/test exit code: $TEST_EXIT_CODE"

exit "$TEST_EXIT_CODE"
