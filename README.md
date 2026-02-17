# rinshari-ui

`rinshari-ui` is the central UI/UX design guide for VontaJamal repositories.

It exists to capture reusable design principles, not one-size-fits-all templates, so each product can keep its own identity while still sharing quality standards.

## Purpose
- Maintain a principle-first design knowledge base.
- Translate learning inputs into durable guidance agents can apply.
- Keep accessibility, hierarchy, and interaction quality explicit.
- Support deterministic design preflight across downstream repos.

## Agent Entry Points
- Start with `AGENTS.md` in this repo for operating rules.
- Use `templates/lesson-card.md` for new lesson ingestion.
- Use `governance/checklist.md` before promoting or updating principles.

## Repository Structure
- `principles/`: stable principle docs used across products.
- `patterns/`: implementation patterns derived from principles.
- `playbooks/`: repeatable workflows for application.
- `ingestion/lessons/`: draft/promoted lesson cards from incoming material.
- `decision-log/`: major design-system decisions and rationale.
- `templates/`: required templates for ingestion and downstream use.
- `governance/`: quality and policy checks.

## Public Contracts
- `templates/lesson-card.md`: canonical schema for lesson ingestion.
- `templates/design-preflight.md`: preflight checklist downstream agents must read.
- `templates/site-soul-brief.md`: per-project identity brief template.
- `governance/checklist.md`: required quality gate for principle updates.

## Content Policy
This is a paraphrase-only repo for course-derived material.
- Do not store full transcripts.
- Do not store raw clips or full lesson dumps.
- Store distilled guidance with source traces.

## Downstream Integration Model
- Downstream repos mount this repo as submodule path `design/rinshari-ui`.
- Agents in downstream repos must read:
  - `design/rinshari-ui/templates/design-preflight.md`
  - relevant `design/rinshari-ui/principles/*`
  - local `docs/site-soul-brief.md`
- New guidance reaches downstream repos when the submodule pointer is bumped and merged.

## Automation Scripts
- `ops/bootstrap-downstream.sh`: bootstraps submodule + policy files + workflows in downstream repos.
- `scripts/new-lesson-draft.sh`: creates lesson-card drafts from paraphrased claims and evidence metadata.
