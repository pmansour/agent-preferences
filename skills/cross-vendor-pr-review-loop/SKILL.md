---
name: cross-vendor-pr-review-loop
description: Run a full implementation-to-merge workflow with mandatory cross-vendor code review. Use when an agent is implementing code and must: create a feature branch, implement and test changes, open and publish a GitHub PR with full context, launch a second agent from a different vendor at its highest-tier model to review the PR using this same skill, iterate on review comments until quality bars are met (bugs, design, tests, CI, repo rules), then approve and merge to main.
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
- Merge only after reviewer approval.

## Model and Vendor Routing

Determine the implementer vendor first.

- If implementing in Claude Code, launch Codex CLI as reviewer with model `GPT-5.3-Codex High`.
- If implementing in Codex, launch Claude Code as reviewer with model `Opus 4.6`.

Never use the same vendor for both implementation and review.

## End-to-End Workflow

1. Prepare branch and implement.
- Create a feature branch from `main` using prefix `codex/` when in Codex.
- Implement changes.
- Add and update tests per repository standards.
- Run required local checks before opening PR.

2. Publish PR with full context.
- Push branch.
- Open PR with a complete description:
- Problem being solved.
- Design/implementation approach.
- Test coverage added and commands run.
- Any caveats, risks, or follow-ups.

3. Spawn cross-vendor reviewer agent via CLI.
- Build a review prompt that includes:
- PR number and branch.
- Repo-specific requirements to enforce.
- Explicit instruction to use `$cross-vendor-pr-review-loop`.
- Instruction to leave review comments on GitHub via `gh pr review`/`gh api`.
- Instruction to approve only when all bars are met.
- Ask the reviewer to use an isolated worktree when needed (`git worktree add /tmp/review-<branch> <branch>`).

4. Address comments and loop.
- Implementer fetches review feedback, fixes issues, adds tests, reruns checks, pushes updates.
- Implementer replies to each review thread/comment with fix notes or rationale.
- Relaunch reviewer agent with updated context.
- Repeat until reviewer approves.

5. Merge after approval.
- Verify PR has reviewer approval from the cross-vendor agent.
- Verify CI is green.
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

### Reviewer Launch From Claude Code (reviewer is Codex)

```bash
codex exec -m "gpt-5.3-codex-high" -C "<repo-path>" \
  "Use \$cross-vendor-pr-review-loop to review PR #<N>. Fetch the PR, review for bugs/design/tests/CI/repo requirements, leave actionable comments on GitHub, and approve only when all issues are resolved."
```

### Reviewer Launch From Codex (reviewer is Claude Code)

```bash
# Use your installed Claude Code CLI command shape; example:
claude code --model "opus-4.6" --cwd "<repo-path>" \
  "Use \$cross-vendor-pr-review-loop to review PR #<N>. Fetch the PR, review for bugs/design/tests/CI/repo requirements, leave actionable comments on GitHub, and approve only when all issues are resolved."
```

If the local Claude CLI uses different flags, keep the same intent: `Opus 4.6`, same repo, same skill, same approval bar.

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

- All reviewer comments are resolved or explicitly accepted by reviewer.
- Reviewer approves the PR.
- Required checks are green.
- Final diff still matches the intended scope.

Then merge PR and clean up branch per repository policy.
