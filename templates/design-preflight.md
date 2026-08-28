# Design Preflight

Before UI/UX work in downstream repos, complete all of the following:

1. Scan the repository for animation and motion-related implementation first (CSS keyframes/transitions, JS/TS animation libraries, timing tokens, motion utility files, animation tests, and reduced-motion handling).
2. For each proposed flourish or motion change, map the intended UX outcome (delight, orientation, comprehension, or feedback) and state why that outcome matters for user behavior.
3. Verify reduced-motion behavior for each motion pattern and document fallback behavior when users prefer less motion.
4. Summarize what exists, what must be preserved, and what conflicts with the intended change before proposing UI/UX edits.
5. Inventory the active local component foundation, design tokens, required states, and tests; identify reusable implementation before proposing something new.
6. State the specific user-facing or product gap and the assumption that would make the proposed change unnecessary.
7. Read relevant docs in `design/rinshari-eye/principles/`, including `002-reference-before-invention.md` and `003-behavior-before-decoration.md` for material interface work.
8. Read `design/rinshari-eye/playbooks/reference-first-design-sop.md`, `design/rinshari-eye/playbooks/css-craft-review.md`, and local `docs/site-soul-brief.md`.
9. Inspect suitable official component catalogs, registries, agent-readable indexes, source repositories, and live previews. Do not install during discovery.
10. Record keep/adapt/build/reject decisions. For every selected external module, record canonical source, accessed version or commit, license and attribution, dependencies, security and performance cost, accessibility and motion risk, and Site Soul adaptations.
11. Record the semantic/content order, layout model, intrinsic constraints, responsive triggers, typography/media behavior, motion action, and reduced-motion equivalent for each major changed region.
12. Declare AI intent: where AI is used, why AI is needed, and why non-AI execution is insufficient; if AI is not used, state that explicitly.
13. Declare AI data boundaries: no raw secrets, credentials, or sensitive user data to external AI systems, with redaction/abstraction method when AI is used.
14. Define AI reliability controls: validation method, confidence limits, and fallback/manual behavior.
15. State intended visual/UX effect and how it supports user goals and product/value outcomes.
16. Identify one accessibility risk and mitigation.
17. In PR/task output, include:
   - Applied principles
   - Site Soul alignment
   - Animation audit summary (files checked + keep/change decisions)
   - Reference and reuse decision (local foundation + sources inspected + keep/adapt/build/reject + provenance and risk gates)
   - CSS craft and behavior summary (content order + layout model + intrinsic/responsive constraints + type/media + proof matrix)
   - Motion intent map (effect -> user goal -> reduced-motion fallback -> expected value outcome)
   - AI intent map (task -> value hypothesis -> data class -> validation -> fallback)

## Required Hard-Gate Sections (Blocking)

### Whimsy & Motion Intent
- Primary delight moment:
- Secondary reinforcement moment:
- Interaction feedback moments:

### Motion Accessibility Parity
- Reduced-motion equivalent behavior for each delight moment:
- Non-motion fallback cues (copy/state/contrast/focus):

### Cognitive Clarity
- Why motion improves understanding (not decoration-only):
- Overload risk and mitigation:

### Reference and Reuse Decision
- Established gap and assumption that would make the change unnecessary:
- Active local components, tokens, states, and tests inspected:
- Official catalogs, registries, agent-readable indexes, source repositories, and previews inspected:
- Candidates considered:
- Decision for each candidate (`keep` | `adapt` | `build` | `reject`):
- Concrete useful difference and outcome impact:
- Canonical source, accessed version or commit, license, and attribution:
- Dependency, security, performance, and maintenance cost:
- Accessibility, motion, and Site Soul adaptations required:

### CSS Craft and Behavior Decision
- Major regions and user jobs:
- Semantic, reading, and focus order:
- Layout model and ownership per region:
- Intrinsic sizing and overflow constraints:
- Responsive content dead zones, containers, and input capabilities:
- Typography, font-loading, image, icon, and media behavior:
- Action-specific motion and performance choices:
- Narrow/standard/wide, zoom/reflow, input, state, and reduced-motion proof:

### Onboarding Impact Scoring
- Onboarding impact score (0-5):
- Onboarding update decision (`none` | `copy-only` | `mini-tour`):
- Feature onboarding manifest change (required when score >= 3):
  - `featureId`:
  - `version`:
  - `trigger` (`viewer_open` | `feature_unlocked` | `first_use`):
- Scoring rule:
  - `0-2`: guided onboarding update is optional.
  - `3-5`: onboarding manifest entry/version bump is required.
