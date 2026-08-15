# GitHub Release Process

## Flow

```text
release/1.0.0
  -> develop
  -> develop validation
  -> pull request: develop -> main
  -> main validation and Pages deployment
  -> annotated tag v1.0.0
  -> GitHub Release v1.0.0
```

## 1. Finalize the changelog

```bash
./scripts/finalize-release.sh 1.0.0
```

Review and commit the change through `develop`.

## 2. Create the main pull request

```text
base: main
compare: develop
title: Release 1.0.0
```

Merge only after all required checks are green.

## 3. Validate main

After merge, wait for:

- regression tests;
- Serenity report generation;
- artifact upload;
- GitHub Pages deployment.

## 4. Synchronize local main

```bash
git checkout main
git pull --ff-only origin main
./scripts/check-version.sh
```

## 5. Create the annotated tag

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git show v1.0.0 --no-patch
git push origin v1.0.0
```

## 6. Create the GitHub Release

```bash
./scripts/create-github-release.sh 1.0.0
```

The script requires an existing remote tag and uses `--verify-tag`.

## 7. Verify

```bash
gh release view v1.0.0
```
