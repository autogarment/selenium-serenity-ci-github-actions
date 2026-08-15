# Troubleshooting

## Chrome startup
Use `--headless=new,--no-sandbox,--disable-dev-shm-usage,--disable-gpu`.

## Serenity shows zero tests
Pass both `-Dcucumber.filter.tags` and `-Dtags`; confirm JSON files exist under `target/site/serenity`.

## Pages artifact missing
Confirm `actions/upload-pages-artifact@v3` uploads `target/github-pages` as `github-pages`.
