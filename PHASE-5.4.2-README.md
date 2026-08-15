# Phase 5.4.2 — GitHub Release Engineering

## Apply

Copy the files into the repository while preserving paths:

```bash
chmod +x scripts/finalize-release.sh
chmod +x scripts/create-github-release.sh
```

## Current sequence

1. Finalize `CHANGELOG.md`.
2. Merge the changelog update into `develop`.
3. Open `develop -> main`.
4. Merge after CI passes.
5. Confirm the `main` regression and Pages deployment.
6. Create and push annotated tag `v1.0.0`.
7. Run `./scripts/create-github-release.sh 1.0.0`.

The automatic tag-triggered release workflow is reserved for Phase 5.4.3.
