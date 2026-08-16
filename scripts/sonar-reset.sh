#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "WARNING: This removes the local SonarQube database and all local SonarQube data."
read -r -p "Type RESET to continue: " answer
[[ "$answer" == "RESET" ]] || { echo "Cancelled."; exit 0; }

docker compose --env-file .env.sonar -f docker-compose.sonar.yml down -v
