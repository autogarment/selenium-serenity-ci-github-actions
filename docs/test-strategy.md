# Test Strategy

- `@smoke`: critical paths for pull requests.
- `@regression`: broad coverage for branch pushes.
- `@sanity`: focused post-change validation.

Tests should use stable locators, deterministic data and explicit assertions. A failed main build must not replace the last successful public report.
