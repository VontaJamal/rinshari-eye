# CSS Craft Review

Use this playbook after `reference-first-design-sop.md` has established the user outcome, Site Soul direction, and keep/adapt/build/reject decision. Reference selection answers what belongs. This review answers whether the integrated design behaves like a finished product.

## 1. Map Each Major Region

Create one row for every major page region or interaction:

| Region or interaction | User job | Semantic and focus order | Layout model and owner | Intrinsic constraint | Responsive trigger | Motion purpose and action | Reduced-motion equivalent | Proof |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| _Name it_ | _What the user must understand or do_ | _DOM order and control behavior_ | _Flow, Flexbox, Grid, or positioned layout_ | _Content, media, or container pressure_ | _Observed breakpoint, container, or capability_ | _Orientation, comprehension, feedback, or delight_ | _Equivalent state and cue_ | _Test, screenshot, or video_ |

If the layout model or behavior cannot be explained without listing offsets, stop and inspect the relationship again.

## 2. Establish the Structural Pass

- Keep the DOM in meaningful reading and focus order.
- Use semantic elements and native controls before recreating behavior.
- Assign each parent one primary layout responsibility and make child overrides intentional.
- Use Flow for content rhythm, Flexbox for a line or axis, Grid for rows and columns, and positioned layout for overlays.
- Locate the real containing block, scroll container, stacking context, and clipping ancestor before changing offsets or `z-index`.
- Prefer gap or parent-owned spacing over margins leaking across component boundaries.
- Keep hidden content behavior explicit: layout, visibility, assistive-technology, and search behavior are separate decisions.

## 3. Establish the Resilience Pass

- Let content determine height unless the object is truly fixed-size.
- Use intrinsic sizing and min/max constraints before hard-coded width and height.
- Test long words, translated or expanded copy, empty content, missing media, and oversized controls.
- Add breakpoints at observed dead zones, not from a device-name checklist.
- Use container queries when the same component lives in differently sized regions.
- Query hover, pointer, color, and motion capabilities when behavior depends on them.
- Diagnose horizontal overflow at its source; do not hide it globally as a repair.
- Verify narrow, standard, and wide layouts plus 200% text zoom and reflow.

## 4. Establish the Type and Media Pass

- Keep body text readable and line measure controlled without shrinking it for small screens.
- Verify fallback fonts and loading behavior do not create disruptive layout shifts.
- Use SVG for interface icons where appropriate and pair icon-only controls with accessible names.
- Choose empty alt text for decorative media and contextual alt text when the image carries meaning.
- Reserve media space with dimensions or aspect ratio; use responsive sources and appropriate formats.
- Use `object-fit` and `object-position` to control cropping, and background images only when the media is decorative or tiling.

## 5. Establish the Motion Pass

- Name the initiating action and the state change before choosing an animation.
- Let entrance and exit use different timing or direction when the actions have different meanings.
- Sequence elements only when the order clarifies hierarchy or cause and effect.
- Transition named properties; favor transform and opacity for repeated motion.
- Keep the hover or focus hit target stable and animate a child when movement would cause flicker.
- Use keyframes for reusable multi-step or autonomous sequences; use transitions for direct state changes.
- Test pause, interruption, rapid repeated input, focus continuity, and lower-powered devices.
- Gate motion with the product's reduced-motion policy and preserve the same status, destination, and task completion without movement.

## 6. Establish the Polish Pass

- Use one lighting direction and a small elevation scale for shadows.
- Calculate nested radii from the visible relationship instead of repeating one radius everywhere.
- Verify text and UI contrast and add shape, copy, iconography, or state changes when color carries meaning.
- Smooth gradient transitions and use saturated midpoints only when the Site Soul calls for them.
- Preserve visible focus and touch-friendly targets; use `:focus-visible` and `:focus-within` where they improve clarity without removing keyboard cues.
- Treat smooth scrolling, scroll snapping, custom scrollbars, filters, clipping, backdrop effects, and 3D transforms as progressive enhancements with an explicit outcome.
- Use optical alignment when equal numeric spacing looks visibly unequal, and record deviations from the token scale.

## 7. Run the Product Proof Matrix

Minimum evidence for a material interface change:

- semantic, keyboard, focus, and screen-reader behavior;
- narrow, standard, and wide containers;
- 200% text zoom and reflow;
- pointer, touch, hover-capable, and hover-incapable input where applicable;
- default and reduced-motion behavior;
- long, short, missing, loading, empty, error, disabled, success, and permission content states that apply;
- media loading, layout shift, horizontal overflow, and animation smoothness;
- integrated screenshots or short video from the final branch.

## Hard Stops

Do not advance polish or add another reference component when:

- the user-facing gap is still undefined;
- the DOM order and visual order disagree;
- the chosen layout model cannot explain the intended relationship;
- overflow, stacking, or sticky behavior is being hidden rather than diagnosed;
- motion has no user outcome or reduced-motion equivalent;
- the current component already satisfies the need;
- the proposed effect conflicts with the Site Soul;
- acceptance has only been demonstrated in a source demo.

## Required Handoff

Report:

- reference-first decision and established gap;
- region behavior map and layout models chosen;
- responsive constraints and content dead zones tested;
- typography and media decisions;
- motion intent, action-specific behavior, performance choice, and reduced-motion parity;
- polish system decisions and optical exceptions;
- integrated proof matrix results;
- required work, bounded experiments with success signals, and unnecessary work rejected.
