# Contributing to ISEE Advisor

Thank you for your interest in contributing! This guide will help you get started.

## How to Contribute

### Reporting Issues

- Use [GitHub Issues](https://github.com/suuus/isee-advisor/issues) to report bugs or request features.
- Search existing issues before opening a new one.
- Use the provided issue templates when available.

### Submitting Changes

1. **Fork** the repository.
2. **Create a branch** from `main` for your change:
   ```bash
   git checkout -b feat/your-feature
   ```
3. **Make your changes** — keep commits focused and well-described.
4. **Test locally** — verify the agent and skills work as expected.
5. **Open a pull request** against `main` and fill out the PR template.

### Branch Naming

| Prefix    | Purpose               |
|-----------|-----------------------|
| `feat/`   | New feature           |
| `fix/`    | Bug fix               |
| `docs/`   | Documentation only    |
| `chore/`  | Maintenance / tooling |

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add new assessment signal for deployment frequency
fix: prevent false positive on missing CODEOWNERS
docs: clarify drift mode usage
```

### What Makes a Good Contribution

- **Skills & agents**: Improvements to assessment accuracy, new signals, better recommendations.
- **Documentation**: Clearer explanations, more examples, typo fixes.
- **Framework alignment**: Anything that better reflects the ISEE model.

### What to Avoid

- Changes that break backward compatibility without discussion.
- Large refactors without an issue or prior discussion.
- Generated or AI-written content submitted without review.

## Development Setup

```bash
git clone https://github.com/suuus/isee-advisor.git
cd isee-advisor
```

The project is a GitHub Copilot plugin composed of agent definitions (`.github/agents/`) and skills (`.github/skills/`). No build step is required — test changes by loading the plugin locally in GitHub Copilot.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold it.

## Questions?

Open a [discussion](https://github.com/suuus/isee-advisor/discussions) or an issue — we're happy to help.
