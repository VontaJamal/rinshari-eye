# Design Preflight

Before UI/UX work in downstream repos, complete all of the following:

1. Scan the repository for animation and motion-related implementation first (CSS keyframes/transitions, JS/TS animation libraries, timing tokens, motion utility files, animation tests, and reduced-motion handling).
2. For each proposed flourish or motion change, map the intended UX outcome (delight, orientation, comprehension, or feedback) and state why that outcome matters for user behavior.
3. Verify reduced-motion behavior for each motion pattern and document fallback behavior when users prefer less motion.
4. Summarize what exists, what must be preserved, and what conflicts with the intended change before proposing UI/UX edits.
5. Read relevant docs in `design/rinshari-eye/principles/`.
6. Read local `docs/site-soul-brief.md`.
7. Declare AI intent: where AI is used, why AI is needed, and why non-AI execution is insufficient; if AI is not used, state that explicitly.
8. Declare AI data boundaries: no raw secrets, credentials, or sensitive user data to external AI systems, with redaction/abstraction method when AI is used.
9. Define AI reliability controls: validation method, confidence limits, and fallback/manual behavior.
10. State intended visual/UX effect and how it supports user goals and product/value outcomes.
11. Identify one accessibility risk and mitigation.
12. In PR/task output, include:
   - Applied principles
   - Site Soul alignment
   - Animation audit summary (files checked + keep/change decisions)
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
