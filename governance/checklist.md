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
- [ ] Whimsical motion quality is intentional and directly aligned to user tasks.
- [ ] Reduced-motion parity is explicitly mapped for each animated element.
- [ ] Keyboard and screen-reader semantics remain equivalent in guided flows.
- [ ] First-run walkthrough steps are constrained (default 5 or fewer unless justified).
- [ ] Onboarding impact score (0-5) is explicitly recorded for UI changes.
- [ ] Scores 3-5 include a feature onboarding manifest entry/version bump with trigger metadata.
