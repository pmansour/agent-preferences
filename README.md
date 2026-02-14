# agent-preferences

Global agent configuration for AI coding assistants (Claude Code, Codex, etc.).

Contains:
- `CLAUDE.md` / `AGENTS.md` — global agent instructions symlinked to `~/`
- `skills/` — reusable agent skills (test-coverage-companion, browser-user-validation, etc.)

## Setup

```bash
./init.sh
```

This creates symlinks:
- `~/CLAUDE.md` -> `<repo>/CLAUDE.md`
- `~/AGENTS.md` -> `<repo>/AGENTS.md`
- `~/.claude/skills/<name>` -> `<repo>/skills/<name>` for each skill

The script is idempotent — safe to re-run.

## Usage in other repos

Add this repo as a git submodule to make skills available in project-specific agent configs:

```bash
git submodule add https://github.com/pmansour/agent-preferences.git .agents/agent-preferences
```

Then reference skills via relative paths in your project's `AGENTS.md`:

```
.agents/agent-preferences/skills/<skill-name>/SKILL.md
```
