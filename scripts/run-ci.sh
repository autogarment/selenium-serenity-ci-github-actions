#!/usr/bin/env bash

set -uo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
BROWSER="${1:-chrome}"
HEADLESS="${2:-true}"
TAGS="${3:-@smoke}"
LOG_FILE="$ROOT/maven-ci.log"

cd "$ROOT"

printf '\n==========================================\n'
printf ' Selenium Serenity CI\n'
printf '==========================================\n'
printf 'Browser : %s\n' "$BROWSER"
printf 'Headless: %s\n' "$HEADLESS"
printf 'Tags    : %s\n' "$TAGS"
printf '==========================================\n\n'

MAVEN_ARGS=(
  --batch-mode
  --no-transfer-progress
  clean
  verify
  "-Dcucumber.filter.tags=$TAGS"
  "-Dtags=$TAGS"
  "-Dwebdriver.driver=$BROWSER"
  "-Dheadless=$HEADLESS"
)

if [[ "$HEADLESS" == "true" ]]; then
  MAVEN_ARGS+=(
    "-Dchrome.switches=--headless=new,--no-sandbox,--disable-dev-shm-usage,--disable-gpu,--window-size=1920,1080"
  )
fi

printf 'Maven arguments:\n'
printf '  %q\n' "${MAVEN_ARGS[@]}"
printf '\n'

set +e
mvn "${MAVEN_ARGS[@]}" 2>&1 | tee "$LOG_FILE"
TEST_EXIT_CODE=${PIPESTATUS[0]}
set -e

printf '\n==========================================\n'
printf ' Report verification\n'
printf '==========================================\n'

check_file() {
  local path="$1"
  local label="$2"

  if [[ -f "$path" ]]; then
    printf 'OK   %-18s %s\n' "$label" "$path"
  else
    printf 'WARN %-18s %s\n' "$label" "$path"
  fi
}

check_file "$ROOT/target/site/serenity/index.html" "Serenity"
check_file "$ROOT/target/jacoco.exec" "JaCoCo exec"
check_file "$ROOT/target/site/jacoco/index.html" "JaCoCo HTML"
check_file "$ROOT/target/site/jacoco/jacoco.xml" "JaCoCo XML"
check_file "$LOG_FILE" "Maven log"

printf '\nMaven/test exit code: %s\n' "$TEST_EXIT_CODE"
exit "$TEST_EXIT_CODE"
