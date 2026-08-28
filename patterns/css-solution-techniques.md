# CSS Solution Techniques

This is a practical pattern atlas, not a universal checklist. Use it to recognize construction moves, understand why they work, and adapt them to the product rather than copying their surface appearance.

The runnable reference is `examples/lumen-craft-lab/`.

## 1. Full-Bleed Visual, Constrained Content

**Use when:** the first viewport needs one dominant visual without allowing text to become unreadably wide.

**Construction:** let the section and media reach every viewport edge; constrain only the inner content column. Overlay the header when it belongs to the composition so it does not consume an extra viewport row.

**What it prevents:** a branded hero trapped inside shared page gutters or a max-width card.

## 2. Intrinsic Wrapper Before Fixed Width

**Use when:** content should breathe on small screens and stop growing on large ones.

**Construction:** combine a maximum content width with fluid gutters. Let block width remain automatic and constrain it instead of forcing `width: 100%`.

**What it prevents:** overflow caused by percentage width plus padding or margin, and dozens of device-specific widths.

## 3. Match the Layout Algorithm to the Relationship

**Use when:** a composition has document rhythm, one-dimensional distribution, two-dimensional alignment, or a deliberate overlay.

**Construction:** use Flow for reading rhythm, Flexbox for one axis, Grid for rows and columns, and positioned layout for explicit overlays. Let each parent own one primary relationship.

**What it prevents:** random offsets and brittle absolute positioning standing in for structure.

## 4. Make the Real Parent the Containing Block

**Use when:** a badge, close button, caption, or flourish belongs to a specific surface.

**Construction:** keep the decorative child inside the semantic surface, establish that surface as the containing block, then position the child relative to it. A percentage translate can move the child by its own size.

**What it prevents:** viewport-relative elements drifting away from their visual owner.

## 5. Sticky Storytelling Needs the Correct Scroll Container

**Use when:** one visual should remain while adjacent explanation advances.

**Construction:** make the visual sticky inside a section tall enough to create meaningful travel. Check every ancestor for overflow or transform behavior that changes the sticky or fixed containing context.

**What it prevents:** sticky elements that never stick, stop too soon, or bind to an accidental scroll container.

## 6. Crop Media Deliberately

**Use when:** differently shaped images must occupy a stable designed frame.

**Construction:** reserve space with dimensions or `aspect-ratio`, use `object-fit: cover`, and choose `object-position` around the subject. Re-evaluate the crop at narrow sizes.

**What it prevents:** squashed imagery, layout shift, and subjects disappearing on mobile.

## 7. Keep the Interaction Target Stable

**Use when:** a link, card, or button should move on hover or focus.

**Construction:** leave the interactive parent in place and transform a child surface or image. Style hover and focus from the parent so keyboard and pointer paths match.

**What it prevents:** hover flicker caused when the moving element escapes the pointer.

## 8. Design Motion From the Action

**Use when:** the same component enters and exits or changes state in more than one direction.

**Construction:** give the destination state an entrance transition and the default state an exit transition. Entrance can be generous; dismissal should usually be quicker. Preserve the state and focus behavior when motion is reduced.

**What it prevents:** mechanical symmetry where every action uses the same timing and direction.

## 9. Reveal Without Moving the Layout

**Use when:** text or media should appear to unfurl, rise, or emerge from a boundary.

**Construction:** animate `clip-path` and a small transform while the element keeps its final layout space. Use stagger only to clarify reading order.

**What it prevents:** surrounding content jumping while an entrance animation runs.

## 10. Build Depth From a Lighting Model

**Use when:** a surface needs tactile separation.

**Construction:** layer a small contact shadow, a medium elevation shadow, and a broad ambient shadow with one light direction. Use `filter: drop-shadow()` when the visible shape is not rectangular.

**What it prevents:** muddy single shadows and shadows that expose the rectangular box around a clipped or protruding shape.

## 11. Let Components Respond to Their Container

**Use when:** the same module can appear in a full-width section, sidebar, or embedded panel.

**Construction:** make the component a query container and change its internal composition at its own content dead zone.

**What it prevents:** page-wide media queries that know too much about where a reusable component happens to live.

## 12. Treat Mobile Gestures as Progressive Enhancement

**Use when:** a horizontal sequence benefits from thumb-driven browsing.

**Construction:** put scrolling and `scroll-snap-type` on the same container, define snap alignment on children, and allow a non-snapping fallback to remain usable.

**What it prevents:** forced carousels whose controls or JavaScript become a prerequisite for reaching content.

## Practice Standard

A technique is learned when it can be:

1. explained in terms of layout or interaction behavior;
2. implemented in an original composition;
3. adapted to different content and viewport constraints;
4. operated with keyboard, touch, and reduced motion;
5. removed when it does not improve the product.
