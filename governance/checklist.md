# Governance Checklist

Every principle/pattern update must satisfy:

- [ ] Evidence is present (transcript paraphrase and/or concrete implementation example).
- [ ] Intended UX effect is explicit.
- [ ] Accessibility implications are documented.
- [ ] Motion/animation implications are documented, including reduced-motion behavior when applicable.
- [ ] Motion/flourish decisions are explicitly linked to user outcomes and product/value outcomes.
- [ ] AI usage is intentional and tied to explicit UX and value outcomes.
- [ ] Strict external AI data boundary is documented and satisfied (no raw secrets, credentials, or sensitive user data to external AI systems).
- [ ] AI output validation method and fallback/manual path are documented.
- [ ] At least one failure mode/anti-pattern is documented.
- [ ] Guidance remains principle-first (not rigidly template-locked).
- [ ] Source trace is included.
- [ ] The active local component, token, state, and test foundation was inspected before external discovery.
- [ ] A specific user-facing gap and the assumption that would make the change unnecessary are documented.
- [ ] Suitable official catalog/index surfaces were inspected without importing code during discovery.
- [ ] Every candidate has a keep/adapt/build/reject decision and a concrete outcome difference.
- [ ] Selected external modules have canonical source, accessed version or commit, license, attribution, dependency, security, performance, accessibility, motion, maintenance, and Site Soul notes.
- [ ] The integrated product, not the source demo, supplies acceptance evidence.
- [ ] Major changed regions document semantic/content order, layout model and owner, intrinsic constraints, responsive triggers, and applicable states.
- [ ] Typography and media choices cover readable measure, loading/layout shift, responsive sizing, cropping, icons, and semantic alternatives where applicable.
- [ ] Motion is action-specific, uses suitable properties, keeps interaction targets stable, and preserves state/focus continuity under reduced motion.
- [ ] Integrated proof covers applicable narrow/standard/wide containers, zoom/reflow, pointer/touch capabilities, content extremes, overflow, and lower-powered-device risk.
- [ ] Whimsical motion quality is intentional and directly aligned to user tasks.
- [ ] Reduced-motion parity is explicitly mapped for each animated element.
- [ ] Keyboard and screen-reader semantics remain equivalent in guided flows.
- [ ] First-run walkthrough steps are constrained (default 5 or fewer unless justified).
- [ ] Onboarding impact score (0-5) is explicitly recorded for UI changes.
- [ ] Scores 3-5 include a feature onboarding manifest entry/version bump with trigger metadata.
