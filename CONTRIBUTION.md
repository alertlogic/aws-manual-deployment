# Contributing

✨🎉 Thank you for your contributions, they are always appreciated! ✨🎉

## Commit Messages

This repo uses pre-commit checks against commit messages. We will follow
the [conventional commit](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional)
style for commits, and you should not push any changes that do not conform.

Similarly, PR titles should follow the same conventional commit syntax.

Good PR titles:

- `feat: add additional column`
- `task: remove comment`
- `docs: update README`

NOTE: Anything that is not prefixed with `feat` or `fix` will not trigger a new version as
per [Semantic Release configuration](https://semantic-release.gitbook.io/semantic-release/usage/getting-started).

# Testing

Integration tests should be included where it is possible, but these will not be included in code coverage analysis.
