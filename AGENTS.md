# Root Agent Instructions

These are Peter's global preferences. Project-specific CLAUDE.md files inherit and can override these.

---

## Architecture Philosophy

- Prefer the simplest architecture that solves the problem. A static web app beats a client+server split. A CLI tool or TUI beats a web app if it fits. Only add complexity (backends, microservices, queues) when there's a concrete need.
- No strong stack preference — pick whatever fits the project. But always justify added complexity.

## Code Style

- Pragmatic: strong types where they matter, don't over-engineer for strictness alone.
- No `any` unless genuinely unavoidable and commented why.
- Keep abstractions minimal — three similar lines are better than a premature helper.
- Avoid over-commenting. Code should be self-explanatory; add comments only for non-obvious "why" decisions.

## Agent Autonomy

- **Plan up front, then execute.** Get alignment on spec/design/plan before coding. Once approved, execute autonomously.
- Only ask mid-implementation if truly blocked or facing a high-risk decision not covered by the plan.
- If you spot improvements unrelated to the current task, don't act on them — add them to `agent-docs/BACKLOG.md` as a checklist item for async follow-up. If the improvement is blocking or directly relevant to current work, fix it in-place.

## Documentation Structure

Every project maintains structured docs in `agent-docs/` at the repo root.

### Project-Level Docs

```
agent-docs/
  SPEC.md          # What we're building (requirements, goals, constraints)
  DESIGN.md        # How we're building it (architecture, data model, key decisions)
  PLAN.md          # Implementation plan (ordered checklist of tasks)
  BACKLOG.md       # Discovered improvements / tech debt for async follow-up
```

### Feature-Level Docs

Each feature gets its own subdirectory:

```
agent-docs/features/<feature-name>/
  SPEC.md          # Feature requirements and acceptance criteria
  DESIGN.md        # Feature design decisions and approach
  PLAN.md          # Feature implementation checklist
```

### Doc Workflow

For both project-level and feature-level work, follow this sequence:

1. **Spec phase**: User describes what they want. Agent asks clarifying questions, resolves ambiguity, and documents big decisions. Write `SPEC.md` once aligned.
2. **Design phase**: Agent proposes a design. Interactive Q&A for design decisions and iterations. Write `DESIGN.md` once approved.
3. **Plan phase**: Agent converts the design into an ordered implementation checklist with concrete tasks suitable for subagent execution. Write `PLAN.md` once approved.

Always keep these docs up to date as the project evolves.

## Testing

Every code change (feature or bug fix) must include broad test coverage.

### Test Skill

Use the test-coverage-companion skill at `skills/test-coverage-companion/SKILL.md`. Follow its full workflow for every code change:

- **Unit tests**: One fast, isolated test per behavior. Assert outcomes, not internals. Name by behavior, not method. Arrange/Act/Assert structure.
- **Integration tests**: One per feature. Exercise real dependencies by default; stub only slow/flaky/costly externals.
- **Coverage target**: >90% statement coverage for touched areas where feasible.
- **Anti-patterns to reject**: Change-detector tests, assertions on private methods, excessive mocking, tests validating multiple unrelated behaviors.
- Run unit tests, integration tests, and the full suite. Confirm all pass before considering a task complete.

## CI

### New Projects

When starting a project from scratch, propose a CI plan that covers:

- Build + unit tests + integration tests.
- Runnable both locally (single command) and on GitHub Actions.
- Optimize for speed (parallelism, caching, minimal images).
- Add a CI status badge to the root `README.md`.
- Use the same commands locally and in CI to prevent drift.

### Ongoing

- Every agent must run CI and keep it green before considering work done.
- If CI breaks, fix it before moving on.

## Code Review

Every task must be code-reviewed by a different agent before merge.

### Review Workflow

Use the `cross-vendor-pr-review-loop` skill at `skills/cross-vendor-pr-review-loop/SKILL.md` for all implementation PRs.

The implementing agent must execute that skill end-to-end:

1. Create and publish a PR with complete context.
2. Launch a reviewer agent from a different vendor at the highest-tier model.
3. Iterate on review comments until quality, testing, CI, and repo-specific requirements are satisfied.
4. Require reviewer approval before merge.
5. Merge only after approval and green required checks.

Treat the skill as the source of truth for exact command patterns and loop mechanics.

## Git Conventions

- Descriptive commit messages — clear and readable, no strict conventional-commits format required.
- Use feature branches for all work. Never commit directly to main.
- Keep commits focused: one logical change per commit.

## Skills

The following skills are available globally and should be used when applicable:

- **test-coverage-companion** (`skills/test-coverage-companion/SKILL.md`): Use on every code change to ensure proper test coverage.
- **cross-vendor-pr-review-loop** (`skills/cross-vendor-pr-review-loop/SKILL.md`): Use for all implementation PRs to enforce cross-vendor, highest-tier review and comment-resolution loops before merge.
