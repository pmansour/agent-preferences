# Integration Tests: Feature Coverage Playbook

## Goal

Add one automated integration test per product feature touched by the change.

## Feature Mapping

1. List features affected by the code change.
2. For each feature, define:
   - Entry point (HTTP endpoint, CLI, event handler, UI action).
   - Real dependencies involved (DB, filesystem, queue, service adapters).
   - Expected user-visible outcome.

## Test Scope Rules

- Exercise real internal dependencies by default.
- Mock/stub only external third-party boundaries.
- Validate complete behavior flow, not helper internals.
- Keep runtime short with small fixtures and ephemeral state.

## Per-Feature Test Template

1. Arrange:
   - Boot app/service with test config.
   - Seed minimal realistic data.
2. Act:
   - Execute feature through public interface.
3. Assert:
   - Verify response/output.
   - Verify durable side effects (DB rows, files, emitted messages).
   - Verify key failure handling path when risk is material.

## Stability Rules

- Avoid live network calls to third-party APIs.
- Avoid sleeps; use polling with bounded retries only when unavoidable.
- Isolate test data and clean up after each test.
- Ensure tests pass locally and in CI consistently.

## CI Integration Checklist

- Ensure integration tests run in default CI pipeline.
- Ensure required services (DB, cache) are provisioned in CI.
- Keep command surface simple:
  - unit tests
  - integration tests
  - all tests
  - coverage report
