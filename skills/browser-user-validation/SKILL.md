---
name: browser-user-validation
description: Validate recently implemented changes from an end-user browser perspective in web applications. Use when a coding task modifies behavior, UI, navigation, or interaction flow; for this repository, run this skill at the end of every coding task before returning control to the user.
---

# Browser User Validation

Validate completed coding work from a real browser-user perspective before final handoff.

## Required Companion Skill

- Use `$agent-browser` to perform browser startup and all browser interactions.
- Load instructions from `skills/agent-browser/SKILL.md` before running the interactive validation flow.
- Do not use DOM-only inspection tools as the primary validation method.

## Workflow

1. Determine the task scope and impacted user journey.
- Identify what changed (bug fix, feature, navigation, performance, styling, accessibility, interaction logic).
- Map the affected pages/screens and any prerequisite flows needed to reach them.

2. Start the local app.
- Run `npm run dev`.
- Wait for a reachable local URL.

3. Run an interactive browser session with `$agent-browser`.
- Start and control the browser via `agent-browser` commands.
- Navigate with `agent-browser open <url>`.
- Capture interactive targets with `agent-browser snapshot -i`.
- Interact through user-like actions (`click`, `fill`, `select`, `press`, `scroll`) and re-snapshot after DOM changes.
- Use screenshots and visible page state to validate UX, not DOM text alone.

4. Execute the user flow.
- Navigate from entry screens through prerequisites to the changed area.
- Exercise the exact newly changed behavior and key adjacent paths.

5. Observe runtime quality issues.
- Check for console errors and warnings tied to the changed flow.
- Watch for slow responses, broken loading states, and timeouts.
- Detect UI defects: overlap, clipping, hidden controls, poor focus handling, keyboard traps, and inaccessible interactions.
- Check for behavioral regressions: loops, dead ends, stale state, unexpected resets, and inability to reach the intended outcome.

6. Triage and act.
- Fix issues that are clearly in scope and reasonably actionable.
- Document systemic or out-of-scope issues with rationale.
- If code changes are made during triage: add or update tests, rerun tests, and repeat this validation workflow.

7. Report before handoff.
- Summarize tested flows and environments.
- List issues found, fixes applied, and unresolved items with rationale.
- Include at least one screenshot that clearly shows the new feature or bug fix outcome.
- Explicitly confirm whether the changed behavior works from a browser-user perspective.

## Exit Criteria

Do not finalize the task until one of these is true:
- The changed flow is validated in-browser and no blocking issues remain.
- Remaining issues are explicitly documented with severity and rationale for deferral.

## Report Template

Use this compact format in the final response when the skill runs:

- Scope: <what changed and which screens were validated>
- Browser flow exercised: <path taken including prerequisites>
- Screenshot: <markdown image to local screenshot path showing the implemented change>
- Issues found: <none | concise list>
- Fixes applied: <none | concise list>
- Deferred items: <none | concise list with rationale>
- Final validation status: <pass | pass with caveats | fail>
