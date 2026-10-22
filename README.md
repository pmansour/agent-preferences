# agent-preferences

Global agent configuration for AI coding assistants (Claude Code, Codex, etc.).

Contains:
- `CLAUDE.md` / `AGENTS.md` — global agent instructions symlinked to `~/`
- `skills/` — reusable agent skills for test coverage and flight searches with cash and points

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

## Flight searches with cash and points

[find-flights-cash-and-points](skills/find-flights-cash-and-points/SKILL.md) compares practical cash and award itineraries, verifies seats for the whole party, and helps prepare a booking handoff. It works with available browser tools; paid award aggregators are optional.

On first use, it asks about the traveler's cards, points/miles programs, status, and preferences, then saves confirmed non-secret details through the agent's supported private memory. If persistent private memory is unavailable, it offers a private profile file. Personal profiles stay outside the skill and this repository.

To install just this skill in Codex, give it this prompt:

> Use skill-installer to install https://github.com/pmansour/agent-preferences/tree/main/skills/find-flights-cash-and-points

For manual installation, copy the complete `skills/find-flights-cash-and-points` folder into `~/.agents/skills/` for Codex, or the documented skills location for another agent. Include all supporting references.

Then ask your agent to use `find-flights-cash-and-points` for a trip. In Codex, mention it as `$find-flights-cash-and-points`. Searching does not authorize point transfers or purchases.
