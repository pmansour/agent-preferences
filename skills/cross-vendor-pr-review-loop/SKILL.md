---
name: cross-vendor-pr-review-loop
description: Run a full implementation-to-merge workflow with mandatory cross-vendor code review. Use when an agent is implementing code and must: create a feature branch, implement and test changes, publish a full GitHub PR when available, launch a second agent from a different vendor at its highest-tier model to review using this same skill, iterate on comments until quality bars are met (bugs, design, tests, CI, repo rules), and merge only after approval. If GitHub PR flow is unavailable (for example local-only repos with no remote), run an equivalent local file-based review loop under agent-docs.
---

# Cross Vendor PR Review Loop

Run this workflow from the implementer agent.

## Required Outcomes

- Create and publish a GitHub PR for the change set.
- Route review to a different vendor's highest-tier model.
- Require review comments/fixes until the reviewer confirms no known bugs or regressions.
- Require reviewer confirmation that design and implementation quality meet repo standards.
- Require reviewer confirmation that test coverage is sufficient and updated where needed.
- Require reviewer confirmation that CI is green and repo-specific requirements are satisfied.
- Merge only after reviewer approval in GitHub mode, or `Approved.md` in local-file mode.

## Model and Vendor Routing

Determine the implementer vendor first.

- If implementing in Claude Code, launch Codex CLI as reviewer with model `gpt-5.3-codex`.
- If implementing in Codex, launch Claude CLI as reviewer with model `opus`.

Never use the same vendor for both implementation and review.
If a requested model identifier is unavailable for the current account tier, select the highest-tier available model from that vendor and continue.

## Select Review Transport

Pick one mode before launching the reviewer.

- Use **GitHub mode** when the repository can publish and review a PR (`git remote` + `gh` workflow is available).
- Use **Local-file mode** when GitHub PR flow is unavailable (no remote, local-only repo, no auth, or no network).

## End-to-End Workflow

1. Prepare branch and implement.
- Create a feature branch from `main` using prefix `codex/` when in Codex.
- Implement changes.
- Add and update tests per repository standards.
- Run required local checks before opening PR.

2. Publish review context.
- In GitHub mode: push branch and open PR with complete context.
- In Local-file mode: create a review directory and write equivalent context to `PR.md`.

3. Spawn cross-vendor reviewer agent via CLI.
- Build a review prompt that includes:
- PR number and branch (GitHub mode) or review directory path (Local-file mode).
- Repo-specific requirements to enforce.
- Explicit instruction to use `$cross-vendor-pr-review-loop`.
- Instruction to leave review artifacts in the active transport:
- GitHub mode: comments/review through `gh`.
- Local-file mode: `Review-XX.md` and `Approved.md` files.
- Instruction to approve only when all bars are met.
- Ask the reviewer to use an isolated worktree when needed (`git worktree add /tmp/review-<branch> <branch>`).

4. Address comments and loop.
- Implementer applies fixes, adds tests, reruns checks, and updates artifacts.
- Implementer replies to each finding with fix notes or rationale.
- Relaunch reviewer agent with updated context.
- Repeat until reviewer approves.

5. Merge after approval.
- Verify approval artifact from the cross-vendor reviewer:
- GitHub mode: PR approval.
- Local-file mode: `Approved.md` created by reviewer.
- Verify required checks are green.
- Merge to `main` with the repository's preferred strategy.

## Command Templates

Adapt commands to repository conventions.

```bash
# 1) Branch, implement, test, push
git checkout main
git pull --ff-only
git checkout -b codex/<short-topic>
# ...implement + tests...
git add -A
git commit -m "Implement <feature/fix>"
git push -u origin codex/<short-topic>

# 2) Open PR (fill body with full details)
gh pr create --base main --head codex/<short-topic> --title "<clear title>" --body-file <pr-body.md>
```

### GitHub Mode: Reviewer Launch From Claude Code (reviewer is Codex)

```bash
codex exec -m "gpt-5.3-codex" -C "<repo-path>" \
  "Use \$cross-vendor-pr-review-loop to review PR #<N>. Fetch the PR, review for bugs/design/tests/CI/repo requirements, leave actionable comments on GitHub, and approve only when all issues are resolved."
```

If the configured Codex model is rejected by account policy, stop and resolve account/model access rather than downgrading silently.

### GitHub Mode: Reviewer Launch From Codex (reviewer is Claude CLI)

```bash
# Use your installed Claude CLI command shape; example:
claude --model "opus" -p \
  "Use \$cross-vendor-pr-review-loop to review PR #<N>. Fetch the PR, review for bugs/design/tests/CI/repo requirements, leave actionable comments on GitHub, and approve only when all issues are resolved."
```

Run from repo root before invoking Claude (for example: `cd <repo-path> && claude ...`). If `claude` is not on `PATH`, use the full binary path.

## Local-File Mode Protocol

Use this mode when GitHub PR flow is unavailable.

### Directory Scheme

Write review artifacts in one directory:

- Preferred: `agent-docs/features/<feature-name>/PR_Review/`
- Fallback: `agent-docs/PR_Review/<branch-name>/`

Create these files in sequence:

1. `PR.md` (implementer)
2. `Review-01.md` (reviewer)
3. `Response-01.md` (implementer)
4. `Review-02.md` / `Response-02.md` ...
5. `Approved.md` (reviewer, final)

Use zero-padded indices (`01`, `02`, ...).

### Required File Content

`PR.md` must include:

- Title
- Branch name and commit range under review
- Problem statement
- Design/implementation summary
- Changed files/modules
- Test plan and executed command results
- CI or local check status
- Known risks or follow-ups

`Review-XX.md` must include:

- Verdict (`REQUEST_CHANGES` or `APPROVE_PENDING`)
- Findings list with stable IDs (`R1`, `R2`, ...)
- Severity per finding (`high`, `medium`, `low`)
- Evidence (file paths/lines and reasoning)
- Required action for each finding

`Response-XX.md` must include:

- One section per finding ID
- Resolution status (`FIXED`, `DECLINED_WITH_RATIONALE`)
- Commit hash(es) or file diff references
- Added/updated tests and command output summary

`Approved.md` must include:

- Reviewer identity (agent vendor + model)
- Statement that no blocking findings remain
- Confirmation on bugs/design/tests/CI/repo requirements
- Final approval timestamp

### Local-File Mode: Reviewer Launch Commands

```bash
# Reviewer is Codex, implementer is Claude
codex exec -m "gpt-5.3-codex" -C "<repo-path>" \
  "Use \$cross-vendor-pr-review-loop in local-file mode. Read <review-dir>/PR.md, inspect the branch diff and tests, write <review-dir>/Review-01.md with actionable findings, and create <review-dir>/Approved.md only when all bars are met."
```

```bash
# Reviewer is Claude, implementer is Codex (adapt flags to local CLI)
claude --model "opus" -p \
  "Use \$cross-vendor-pr-review-loop in local-file mode. Read <review-dir>/PR.md, inspect the branch diff and tests, write <review-dir>/Review-01.md with actionable findings, and create <review-dir>/Approved.md only when all bars are met."
```

Run from repo root before invoking Claude (for example: `cd <repo-path> && claude ...`). If `claude` is not on `PATH`, use the full binary path.

## Reviewer Checklist

Reviewer must verify at minimum:

- Correctness and regression risk.
- Edge cases and failure handling.
- Test quality (unit/integration), not change-detector tests.
- CI status and failing checks.
- Conformance to repository-specific instructions and architecture constraints.

If any item fails, leave comments and request changes. Do not approve.

## Implementer Exit Criteria

Do not merge until all are true:

- All reviewer findings are resolved or explicitly accepted by reviewer.
- Reviewer approves:
- GitHub mode: PR approval.
- Local-file mode: `Approved.md` exists in review directory.
- Required checks are green.
- Final diff still matches the intended scope.

Then merge PR and clean up branch per repository policy.
