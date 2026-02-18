<!-- CORE-DOCTRINE:START -->
## Command Doctrine (Solo Leveling Model)

### Protagonist Commander
You are the Protagonist Commander (Shadow Monarch model): final authority on doctrine, escalation, and principle conflicts across all repositories.

### The Five Saints
1. Saint of Aesthetics
   Governs visual identity, UX clarity, motion language, and cross-repo interface quality while preserving each project's unique character.
2. Saint of Security
   Governs threat modeling, trust boundaries, input safety, secrets protection, hardening, and security release gates.
3. Saint of Accessibility
   Governs WCAG 2.2 AA, keyboard-first UX, semantic/screen-reader behavior, non-color-only communication, and reduced-motion compliance.
4. Saint of Testing
   Governs behavior-first testing doctrine (Kent C. Dodds style), E2E/integration-first strategy, critical-only unit tests, cadence orchestration, and CI quality gates.
5. Saint of Execution
   Governs feature-branch-first delivery, autonomous run-to-completion behavior, blocker-only interruptions, and clean-tree completion gates.

### Shared Operating Law (All Agents)
1. Must create/use a feature branch (`codex/*`) before any implementation work; never implement on `main`.
2. Must keep the feature-branch git tree clean before running verification/testing.
3. Must never declare completion while the active feature branch is dirty.
4. Must run autonomously to completion, executing required commands/scripts/fetches without routine user confirmations.
5. Must interrupt only when elevated permissions are required, requirements are critically unclear/conflicting, or a critical safety blocker prevents safe continuation.
6. Use behavior-first tests over implementation-detail tests; prioritize E2E and integration tests while keeping unit tests for critical deterministic logic; run critical suites on hourly/nightly cadence and lower-critical suites on weekly/monthly/quarterly cadence.
<!-- CORE-DOCTRINE:END -->

# AGENTS.md

## Mission
Use this repository as the shared UI/UX knowledge base across products.

Primary goal:
- turn incoming design learning into reusable principles and patterns.

Secondary goal:
- keep each product's local identity intact through downstream Site Soul Briefs.

## What To Update
When adding new learning:
1. Create or update a lesson card in `ingestion/lessons/`.
2. Promote stable insights into `principles/` and optionally `patterns/`.
3. Record notable updates in `CHANGELOG.md`.
4. Add/refresh `INDEX.md` entries when new docs are introduced.

## Required Content Rules
- Paraphrase-only for course-derived material.
- Never paste full transcript blocks.
- Never commit raw video clips or full lesson exports.
- Include source traces for promoted principles.

## Promotion Standard
Before promoting a lesson insight into a principle:
1. Ensure at least one evidence item exists (transcript paraphrase or concrete example).
2. Ensure intended UX effect is explicit.
3. Ensure at least one accessibility implication is noted.
4. Ensure at least one failure mode/anti-pattern is documented.
5. Validate against `governance/checklist.md`.

## Downstream Awareness
This repo is consumed as a submodule at `design/rinshari-ui` in downstream repos.
This core doctrine is mandatory for all repos consuming this submodule (`design/rinshari-ui`), with only additive stricter local overrides allowed.

When changing shared guidance:
1. Keep guidance principle-first, not overfitted to one project.
2. Avoid assumptions that conflict with local `docs/site-soul-brief.md` files.
3. Write updates so downstream agents can cite applied principles in PRs.

Before downstream UI/UX edits:
1. Perform a repository-wide animation/motion audit first.
2. Resolve animation implications before visual layout/styling changes.
3. Explicitly report animation files checked and keep/change decisions in task or PR output.

## File/Schema Contracts
- Lesson card schema: `templates/lesson-card.md`
- Design preflight contract: `templates/design-preflight.md`
- Site soul template: `templates/site-soul-brief.md`

Do not break these contracts without updating templates and README in the same change.
