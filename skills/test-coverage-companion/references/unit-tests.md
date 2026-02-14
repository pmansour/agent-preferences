# Unit Tests: Behavior-First Playbook

## Goal

Add one small test per behavior the unit promises, independent of the current implementation.

## Per-Unit Procedure

1. Define contract:
   - Purpose in one sentence.
   - Inputs and accepted ranges/types.
   - Outputs/return value.
   - Observable side effects.
   - Error behavior.
2. Convert contract to behavior list:
   - One bullet per distinct behavior.
3. Add exactly one primary test per behavior:
   - If setup is large, use fixtures/builders.
4. Add boundary/negative tests for risky behavior:
   - Invalid input handling.
   - Empty/state edge cases.
   - Retry/idempotency/timeout behavior when relevant.

## Test Design Rules

- Make tests independent and order-agnostic.
- Keep each test focused on one behavior.
- Prefer precise assertions over broad snapshots.
- Assert user-visible outcomes and state transitions.
- Do not assert private helper calls unless required for behavior.
- Keep timing deterministic; inject clocks and randomness when needed.

## TOTT-Aligned Checklist

- Keep tests small, focused, and readable.
- Avoid logic in tests that can hide failures.
- Prefer behavior/specification assertions over implementation coupling.
- Keep tests hermetic: no shared global state or environment leakage.
- Minimize mocking; use fakes at true boundaries and real collaborators otherwise.
- Eliminate flakes by removing nondeterminism and order dependence.
- Name tests to describe behavior and expected outcome.
- Treat tests as first-class production code: refactor duplicates and keep intent clear.

## Suggested Naming Style

`<unit>_<behavior>_<expected_outcome>`

Examples:

- `price_calculator_applies_member_discount_returns_reduced_total`
- `session_store_expired_token_lookup_returns_none`

## Fast Quality Check

- Could this test still pass if internals were refactored but behavior stayed the same?
- Does this test fail only when one behavior regresses?
- Can a new teammate understand the behavior from the test name and assertion?
