# Refactor Sweep Checklist

Use this checklist to triage LLM-driven sweep findings and decide next actions.

## Workspace setup
- Confirm the active workspace root before scanning (`pwd`).
- In cloud workspaces, run from the mounted project root (commonly `/workspace/...`).
- Prefer repo-aware file discovery first (`rg --files` or `git ls-files`), then deep reads.

## Delete (dead code)
- Unreferenced files or exports (not imported/used anywhere).
- Feature flags or experiments removed from the UI but still in store/types/utils.
- Tests targeting removed flows or deprecated data structures.

## Simplify (over-abstracted)
- Small helpers that obscure simple logic.
- Optional layers that only wrap a single use-site.
- Overly generic types or factories with one consumer.

## Consolidate (duplication)
- Repeated UI markup across steps/components.
- Duplicate helper logic or copy-pasted calculations.
- Similar flows that can share a hook or utility.

## Split (oversized modules)
- Files >400–500 LOC with multiple responsibilities.
- Services mixing client config, schemas, and multiple features.
- Components that combine state, effects, and large UI blocks.

## Evidence to collect
- File path + line numbers for each candidate.
- Reason for change (dead/duplicate/over-abstracted).
- Minimal plan (delete, extract component, split module).
- Validation note (what was checked to confirm it is real and not a false positive).

## Confidence check before proposing edits
- **High confidence**: multiple signals (usage search + type references + runtime path checks) agree.
- **Medium confidence**: one strong signal, but depends on nearby context.
- **Low confidence**: weak signal (comment text, naming, or intuition only); investigate further before recommending deletion.
