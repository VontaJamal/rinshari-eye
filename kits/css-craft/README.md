# Rinshari Eye CSS Craft

An opt-in local package of behavior recipes distilled from the promoted CSS craft lesson and proven in the Lumen craft lab. It packages construction ability, not an art direction.

## What It Includes

- `layout.css`: full-bleed page grids, constrained shells, flow rhythm, intrinsic grids, container-responsive sticky stories, deliberate media frames, and touch scroll snapping.
- `interaction.css`: stable parent targets with animated child surfaces and action-specific native popover transitions.
- `motion.css`: clipped entrance reveals with reduced-motion parity.
- `tokens.css`: overridable layout and motion variables with no product typography or color system.
- `index.css`: all modules for a prototype or a product that has established a need for every recipe.

All selectors are prefixed with `rse-`, wrapped in `:where()`, and placed in `rse.*` cascade layers. Product CSS outside those layers wins without specificity escalation.

## Consume Through the Existing Submodule

Every integrated repository already mounts Rinshari Eye at `design/rinshari-eye`. No registry publication is required.

For a JavaScript repository that wants package resolution:

    npm install --save ./design/rinshari-eye/kits/css-craft

Then import only the modules that close an established gap:

    @import "@rinshari-eye/css-craft/layout.css";
    @import "@rinshari-eye/css-craft/interaction.css";

A CSS toolchain that supports repository-relative imports may import the files directly from `design/rinshari-eye/kits/css-craft/css/` instead.

## Adoption Rule

1. Inspect the product and identify the exact layout or interaction failure.
2. Import the smallest relevant module.
3. Copy the semantic structure from the recipe example, not its visual styling.
4. Override custom properties and appearance in the local Site Soul.
5. Verify real content, narrow and wide containers, keyboard, touch, and reduced motion.
6. Remove the recipe if it does not improve the product outcome.

Do not automatically import `index.css` into every repository. Availability is universal; adoption remains evidence-based and product-specific.

## Recipe Markup

### Full-Bleed Page Grid

    <body class="rse-page-grid">
      <header class="rse-full-bleed">...</header>
      <main class="rse-content">...</main>
    </body>

### Container-Responsive Sticky Story

    <div class="rse-query">
      <section class="rse-sticky-story">
        <div class="rse-sticky-story__visual">...</div>
        <div>...</div>
      </section>
    </div>

The visual is normal document flow in narrow containers and becomes sticky only when its own container has room.

### Stable Action Surface

    <button class="rse-stable-action">
      <span class="rse-stable-action__surface">Continue</span>
    </button>

The button remains stationary while the child surface responds to hover, focus, and press.

### Native Popover

    <button popovertarget="details">Open details</button>
    <div class="rse-popover" id="details" popover>...</div>

The browser owns focus and dismissal. The package adds slower arrival, quicker exit, discrete-state transitions, and reduced-motion parity.

### Touch Scroll Strip

    <div class="rse-snap-strip">
      <article>...</article>
      <article>...</article>
    </div>

Scrolling remains usable if snapping is unsupported.

## Proof and References

- Functional package consumer: `examples/consumer.html`
- Complete original composition: `../../examples/lumen-craft-lab/`
- Technique explanations and failure modes: `../../patterns/css-solution-techniques.md`
- Governing principle: `../../principles/003-behavior-before-decoration.md`

The implementation is original. It does not contain course code, copied workshop solutions, or course assets.
