# 002 Reference Before Invention

## Intent
Turn visual taste from guesswork into an evidence-backed design decision. Before inventing a component or interaction, understand the user outcome, inspect the product's existing foundation, and study suitable working references. Reuse the current solution when it already fits; adapt the smallest external or internal module that closes a proven gap; build new only when neither option works.

References expand the solution space. They do not choose the solution, replace product judgment, or authorize a collage of attractive parts. Every adopted module must become native to the product's Site Soul, state model, semantics, tokens, and maintenance model.

## Operating Principle

Apply this sequence to every material UI/UX change:

1. **Name the outcome and gap.** State what users cannot understand, do, or feel with the current experience and why closing that gap matters.
2. **Inspect the local foundation.** Trace active components, layout primitives, tokens, typography, motion, states, dependencies, and tests. Inactive or leftover files do not count as reusable implementation.
3. **Search references deliberately.** Use the local system first, then inspect relevant official catalog indexes, registries, agent-readable inventories, source repositories, and live previews. Search the discoverable set for the defined need rather than choosing the first visually striking example.
4. **Record keep, adapt, or build.** Compare the current solution with viable candidates. Name the useful difference, Site Soul fit, license and attribution terms, dependency and security cost, accessibility and reduced-motion risk, performance cost, and maintenance burden.
5. **Integrate into the product.** Copy only what was selected. Preserve or improve semantics and behavior, replace foreign design tokens and copy, cover every required state, and keep motion subordinate to comprehension and feedback.
6. **Verify the integrated result.** Test the real product implementation across responsive sizes, keyboard and screen-reader paths, pointer and touch input, reduced motion, loading/empty/error/disabled/success states, and relevant performance budgets. A catalog demo is evidence for discovery, not proof of acceptance.

## Decision Rule

- **Keep** when the active local component already closes the established gap.
- **Adapt** when an existing internal or licensed external module closes the gap with less cost than new design and can be made native to the product.
- **Build** when no suitable module meets the behavior, identity, accessibility, performance, or maintenance constraints. Document why the inspected options failed.

Distinctive or decorative modules that are not required for the established outcome are experiments. They need a baseline, a success signal, and a removal path. Modules that neither close a gap nor test a defined hypothesis are unnecessary.

## UX Effect
Improve hierarchy, interaction quality, state coverage, and perceived craft while reducing generic AI layouts and avoidable reinvention. The product should feel more intentional without looking assembled from unrelated kits.

## Accessibility Implication
External code inherits no accessibility trust. Verify semantics, focus order, keyboard operation, screen-reader output, contrast, target size, touch behavior, zoom/reflow, non-color cues, and reduced-motion parity after the module is adapted. Preserve non-motion communication for every animated state change.

## Motion / Animation Implication
Reference motion by purpose: orientation, comprehension, feedback, or delight. Importing a component does not justify importing all of its motion. Remove decorative movement that conflicts with the Site Soul, replace foreign timing with local motion tokens, avoid paint-heavy effects when a composited equivalent exists, and verify `prefers-reduced-motion` behavior in the integrated surface.

## Failure Modes / Anti-patterns
- Browsing components before defining the user outcome, then inventing a problem for an attractive module to solve.
- Ignoring the active local component or design system because an external demo looks newer.
- Installing an entire library or premium catalog to obtain one interaction.
- Mixing multiple source aesthetics without normalizing tokens, typography, spacing, iconography, copy, and motion.
- Copying code without recording source, version or commit, license, attribution duties, and introduced dependencies.
- Trusting source claims about accessibility, performance, responsiveness, or reduced motion without integrated verification.
- Using component discovery to replace visual direction, hierarchy, content design, or product judgment.
- Redistributing restricted source material as a shared kit when its terms allow only use inside an end product.

## Source Traces
- `ingestion/lessons/2026-08-27-reference-first-component-composition.md`
- https://x.com/EXM7777/status/2092250905655812121
- https://ui.shadcn.com/
- https://beui.dev/
- https://rareui.com/
- https://transitions.dev/
