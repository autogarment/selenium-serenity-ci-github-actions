#!/usr/bin/env bash
set -Eeuo pipefail
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PAGES_DIR="$PROJECT_ROOT/target/github-pages"
rm -rf "$PAGES_DIR"
mkdir -p "$PAGES_DIR"
copy_report(){ local src="$1" dst="$2" name="$3"; if [ -d "$src" ] && [ -n "$(find "$src" -mindepth 1 -print -quit)" ]; then mkdir -p "$PAGES_DIR/$dst"; cp -a "$src/." "$PAGES_DIR/$dst/"; echo "COPIED: $name"; else echo "SKIPPED: $name"; fi; }
copy_report "$PROJECT_ROOT/target/site/serenity" serenity Serenity
copy_report "$PROJECT_ROOT/target/allure-report" allure Allure
copy_report "$PROJECT_ROOT/reports/masterthought" masterthought Masterthought
copy_report "$PROJECT_ROOT/reports/dashboard" dashboard Dashboard
copy_report "$PROJECT_ROOT/reports/portal" portal Portal
touch "$PAGES_DIR/.nojekyll"
cat > "$PAGES_DIR/index.html" <<'HTML'
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Selenium Serenity CI Reports</title><style>body{font-family:system-ui,sans-serif;margin:0;background:#f6f8fb;color:#172033}main{max-width:960px;margin:auto;padding:48px 20px}.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:18px}a{display:block;background:#fff;border:1px solid #dfe5ee;border-radius:16px;padding:22px;color:inherit;text-decoration:none}a:hover{border-color:#2563eb;transform:translateY(-2px)}p{color:#637083;line-height:1.6}.status{display:inline-block;background:#ecfbea;color:#176b0d;padding:8px 12px;border-radius:999px;font-weight:700}</style></head><body><main><h1>Selenium Serenity CI Reports</h1><p>Latest successful automation reports published from the main branch.</p><p class="status">GitHub Pages deployment active</p><section class="grid"><a href="./serenity/index.html"><h2>Serenity BDD</h2><p>Scenarios, steps, screenshots and evidence.</p></a><a href="./allure/index.html"><h2>Allure</h2><p>Available when generated.</p></a><a href="./dashboard/index.html"><h2>Dashboard</h2><p>Available when generated.</p></a><a href="./portal/index.html"><h2>Report Portal</h2><p>Available when generated.</p></a><a href="./masterthought/index.html"><h2>Masterthought</h2><p>Available when generated.</p></a></section></main></body></html>
HTML
test -f "$PAGES_DIR/index.html"
test -f "$PAGES_DIR/serenity/index.html"
echo "GitHub Pages website prepared successfully."
