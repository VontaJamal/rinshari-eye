# Lumen CSS Craft Lab

An original, dependency-free landing-page study built to practice implementation techniques from the promoted CSS craft lesson. It is not a copy of a course workshop, solution, brand, or asset.

## Visual Thesis

Dark architectural calm with one warm luminous object. Typography and negative space lead; amber is reserved for light, emphasis, and action.

## Content Plan

1. Full-canvas poster hero: brand, promise, one dominant image, one entry action.
2. Sticky material story: image depth paired with a paced explanation.
3. Cardless method sequence: three decisions connected by structure and rhythm.
4. Horizontal material studies: touch-friendly progressive enhancement.
5. Final viewing action: native popover with action-specific motion.

## Interaction Thesis

- A clipped, staggered hero entrance establishes hierarchy once.
- The material image remains sticky on wide layouts while the explanation advances.
- Stable parent controls animate their children for navigation flips and tactile button feedback.
- The popover arrives deliberately and dismisses quickly; reduced motion preserves the state change without travel.

## Techniques Practiced

- full-bleed hero with an independently constrained content column;
- Flow, Grid, positioned layout, and sticky positioning with explicit ownership;
- intrinsic sizing, `clamp()`, content-based breakpoints, and a container query;
- purposeful image cropping with reserved dimensions and lazy loading below the fold;
- stable hover and focus targets;
- child transforms, `clip-path`, layered shadows, nested radii, and optical correction;
- native popover behavior with entrance and exit transitions;
- reduced-motion parity, visible focus, semantic order, touch targets, and mobile scroll snapping.

## Run

Serve this directory with any static server and open `index.html`. For example:

    python3 -m http.server 4173 --directory examples/lumen-craft-lab

## Provenance

- Course-derived ideas are paraphrased in `../../ingestion/lessons/2026-08-28-css-craft-and-motion.md`.
- The implementation and copy are original.
- `assets/lumen-hero.png` was generated for this lab with the built-in OpenAI image generator. It contains no copied course or third-party asset.
