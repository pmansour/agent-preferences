---
name: refactor-sweep
description: "Periodic refactor/simplification sweeps for codebases to identify dead code, redundant abstractions, duplicated UI/logic patterns, and oversized modules. Use when asked to audit a repo for cleanup opportunities or to plan ongoing refactor checkups."
---

# Refactor Sweep

## Overview

Use this skill to run a structured audit for dead code, redundant abstractions, duplicated patterns, and oversized modules. This skill is LLM-first: rely on direct repository exploration and reasoning instead of a fixed scan script.

## Workflow

1. **Scope the sweep** to the current workspace root (local repo path or cloud workspace path).
2. **Explore directly** with repository-aware searches (`rg`, `find`, `git ls-files`, targeted file reads).
3. **Triage findings** using `references/refactor-checklist.md`.
4. **Propose refactors** with evidence (files/lines) and a plan (delete, simplify, consolidate, split).
5. **Execute changes** (if requested), add tests, and verify by running the standard test suite.

## Quick Start

Start from the active workspace root:

```bash
pwd
```

For local repos, prefer fast repository-aware scans:

```bash
rg --files
rg --line-number "TODO|FIXME|deprecated|legacy|obsolete" src tests docs
```

For cloud workspaces, run the same workflow from the mounted workspace root (commonly `/workspace`), then use the checklist below.

Use `references/refactor-checklist.md` to label each finding as:
- **Delete** (dead code / unused files / unused exports)
- **Simplify** (over-abstracted or premature patterns)
- **Consolidate** (duplicated logic or UI)
- **Split** (oversized modules with multiple responsibilities)

## Notes

- Prefer `rg` over `grep -R` for large codebases when available.
- If `rg` is unavailable, fall back to `find` + `grep`.
- Always cite files and line numbers for each recommendation.
- Treat all findings as candidates that require local verification.
- When implementing changes, ensure tests are updated and run the full test suite.

## Resources (optional)

### references/
`refactor-checklist.md` provides a triage checklist for findings.
