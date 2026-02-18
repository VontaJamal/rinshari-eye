# Design Preflight

Before UI/UX work in downstream repos, complete all of the following:

1. Scan the repository for animation and motion-related implementation first (CSS keyframes/transitions, JS/TS animation libraries, timing tokens, motion utility files, animation tests, and reduced-motion handling).
2. Summarize what exists, what must be preserved, and what conflicts with the intended change before proposing UI/UX edits.
3. Read relevant docs in `design/rinshari-ui/principles/`.
4. Read local `docs/site-soul-brief.md`.
5. State intended visual/UX effect and how it supports user goals.
6. Identify one accessibility risk and mitigation.
7. In PR/task output, include:
   - Applied principles
   - Site Soul alignment
   - Animation audit summary (files checked + keep/change decisions)

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
