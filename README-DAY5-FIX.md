# Day 5 GitHub Pages Fix

Files included:

- `.github/workflows/selenium-ci.yml`
- `scripts/prepare-github-pages.sh`

Apply:

```bash
cp .github/workflows/selenium-ci.yml <project>/.github/workflows/selenium-ci.yml
cp scripts/prepare-github-pages.sh <project>/scripts/prepare-github-pages.sh
chmod +x <project>/scripts/prepare-github-pages.sh
```

The workflow prepares and deploys GitHub Pages only when the Selenium test step succeeds.
Diagnostic and normal report artifacts are still uploaded when tests fail.
