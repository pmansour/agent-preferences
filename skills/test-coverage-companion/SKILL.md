---
name: test-coverage-companion
description: Enforce sufficient automated test coverage for every code change with behavior-based unit tests and feature-level integration tests. Use when implementing or reviewing code changes to map intended behaviors, add one granular unit test per behavior, add one integration test per feature, target >90% statement coverage where feasible, avoid change-detector assertions, document minimal refactors needed for testability, and run all available tests locally and in CI.
---

# Test Coverage Companion

## Overview

Apply a repeatable, behavior-first testing workflow to every code change.
Prioritize meaningful confidence over implementation-coupled tests.

## Workflow

1. Identify scope before writing tests.
   - List every modified unit (function, class, module, component, endpoint, job, CLI command).
   - Group units into product features for integration testing.
2. Define behavior contracts for each unit.
   - Summarize intended purpose.
   - Summarize public interface: inputs, outputs, side effects, failure modes.
   - Convert each expected behavior into one test case.
3. Implement unit tests first.
   - Write one fast, isolated, granular test per behavior.
   - Assert externally visible outcomes, not internal implementation details.
   - Use deterministic data and avoid sleeps, randomness, and network calls.
4. Implement integration tests per feature.
   - Add one automated end-to-end or service-level integration test per feature.
   - Exercise real dependencies by default (database, filesystem, queue, HTTP server internals).
   - Stub or fake only external systems that are slow, flaky, costly, or unsafe.
5. Evaluate testability and refactor minimally if blocked.
   - Prefer dependency injection, pure helper extraction, boundary adapters, and stable interfaces.
   - Keep behavior unchanged.
   - Report the smallest refactor set required.
6. Run and verify all tests.
   - Run targeted unit tests.
   - Run targeted integration tests.
   - Run the full test suite.
   - Collect statement coverage and confirm >90% for touched areas when feasible.
7. Ensure CI executes new tests.
   - Ensure simple local commands exist for unit, integration, all tests, and coverage.
   - Reuse the same commands in CI to avoid drift.
   - Confirm tests run in existing CI jobs, or update CI config to include them.

## Unit Test Standard

- Name tests by behavior, not method internals.
- Keep one reason to fail per test.
- Use explicit Arrange/Act/Assert structure.
- Prefer real collaborators for owned code; mock only true boundaries.
- Avoid loops/conditionals in tests unless table-driven style is clearly simpler.
- Avoid snapshot assertions unless output is large and stable.
- Apply Google Testing on the Toilet principles from `references/unit-tests.md`.

## Integration Test Standard

- Validate feature outcomes through public entry points.
- Keep tests production-like but fast.
- Seed realistic fixtures and clean up deterministically.
- Verify both success path and the highest-risk failure path when practical.

## Anti-Patterns To Reject

- Tests that only mirror line-by-line implementation.
- Assertions on private methods or transient call ordering without product value.
- Large tests validating multiple unrelated behaviors.
- Excessive mocks that hide integration breakage.

## Required Output

When using this skill, always produce:

1. Unit inventory:
   - Touched unit list with purpose and interface summaries.
   - Behavior checklist and matching test names.
2. Feature inventory:
   - Feature list and one integration test per feature.
3. Testability notes:
   - Minimal required refactors (or `None`).
4. Verification:
   - Commands run and pass/fail summary for unit, integration, full suite, and coverage.
   - CI path confirming new tests run in automation.

## References

- For detailed unit-test design and review checks, read `references/unit-tests.md`.
- For integration-test scoping and dependency rules, read `references/integration-tests.md`.
