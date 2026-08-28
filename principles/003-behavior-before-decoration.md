# 003 Behavior Before Decoration

## Intent
Treat visual excellence as the result of correct behavior, not as a cosmetic layer. After `002-reference-before-invention.md` establishes the outcome, direction, and reuse decision, build the chosen design with layout, responsiveness, content, components, motion, and polish that remain coherent under real conditions.

Correctness is part of aesthetics. A page that only looks right at one width, with one copy length and one input method, is not a finished design.

## Operating Principle

Apply this order to every material interface:

1. **Preserve meaning and order.** Start from semantic HTML, content hierarchy, reading order, and focus order. Visual rearrangement must not create a different story for keyboard or assistive-technology users.
2. **Choose the relationship before the property.** Use Flow for document rhythm, Flexbox for one-dimensional distribution, Grid for two-dimensional relationships, and positioned layout for deliberate overlays or out-of-flow responsibilities. Combine modes through clear parent and child ownership instead of compensating offsets.
3. **Make size content-aware.** Prefer intrinsic sizing, `auto`, `min-*`, `max-*`, `minmax()`, `fit-content`, and bounded fluid values. Fixed heights are for truly fixed objects, not unknown copy. Diagnose overflow rather than hiding it.
4. **Respond to the actual constraint.** Add breakpoints where content loses clarity, use container queries when a component depends on its container, and account for viewport behavior, zoom, pointer precision, hover capability, and user preferences. Device labels are not acceptance criteria.
5. **Keep component styling coherent.** Give each component one authoritative style boundary, a small set of meaningful variants, and composition paths for structural differences. A component catalog supplies parts, not the product's visual system.
6. **Respect type and media as layout inputs.** Protect readable line measure and stable body copy, load fonts and images without avoidable layout shift, use responsive media, and choose alt text from the image's meaning rather than its appearance alone.
7. **Design motion from the action.** Distinguish entrance from exit and success from dismissal. Sequence elements only when order improves comprehension. Prefer transform and opacity for frequent motion, name transitioned properties explicitly, keep the interaction target stationary, and define a reduced-motion equivalent.
8. **Polish with a local physical model.** Shadows should imply one lighting environment; radii should nest intentionally; color needs contrast and non-color reinforcement; gradients, filters, clipping, and 3D effects need a specific role. Optical correction may override mathematical symmetry when the visible result is more balanced.
9. **Prove the integrated behavior.** Test the real product with long and short content, narrow and wide containers, zoom and reflow, keyboard and touch input, reduced motion, slow media, and applicable loading, empty, error, disabled, success, and permission states.

## Decision Rule

- **Required:** Structural, responsive, semantic, state, focus, media, or motion work needed for the intended experience to remain understandable and usable.
- **Experiment:** A distinctive flourish whose outcome is plausible but unproven. Define the baseline, success signal, and removal path.
- **Unnecessary:** An effect, abstraction, dependency, or breakpoint that neither closes a proven gap nor tests a defined hypothesis.

## UX Effect
Create interfaces that feel calm, intentional, tactile, and premium because their hierarchy and interactions remain convincing—not because more effects were added. The expected result is stronger comprehension, confidence, task completion, and perceived craft across devices and input modes.

## Accessibility Implication
The DOM remains the source of truth for meaning, reading, and focus order. Verify visible focus, keyboard operation, semantic controls, contrast, non-color cues, touch targets, text zoom, reflow, image alternatives, and input-capability fallbacks. Every motion pattern needs a non-motion route that preserves the same information and task outcome.

## Motion / Animation Implication
Motion is action-driven communication. Use it for orientation, comprehension, feedback, or bounded delight; choose direction, timing, easing, and orchestration from that purpose. Avoid layout- and paint-heavy animation when a composited equivalent works, and test on lower-powered devices. Reduced motion may shorten, simplify, or remove movement, but it must preserve state change and focus continuity.

## Failure Modes / Anti-patterns
- Copying the surface appearance of a reference while ignoring its layout relationships and content constraints.
- Treating `width: 100%`, fixed heights, arbitrary offsets, overflow clipping, or escalating `z-index` as general repairs.
- Using visual order, hover-only behavior, color alone, or animation alone to communicate meaning.
- Adding breakpoints for named devices instead of observed content pressure.
- Applying multiple style sources or oversized variant APIs to one component.
- Transitioning `all`, animating the hover target itself, or running simultaneous motion that has no narrative order.
- Combining shadows, glass, gradients, clipping, and 3D effects without a shared visual or product rationale.
- Accepting a polished source demo as proof that the integrated product is responsive, accessible, or performant.

## Source Traces
- `ingestion/lessons/2026-08-28-css-craft-and-motion.md`
- `ingestion/lessons/2026-08-27-reference-first-component-composition.md`
- `principles/002-reference-before-invention.md`
- https://courses.joshwcomeau.com/css-for-js
- https://courses.joshwcomeau.com/css-for-js/video-archive
- https://courses.joshwcomeau.com/css-for-js/treasure-trove
