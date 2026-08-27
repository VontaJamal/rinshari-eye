# Reference-First Design SOP

Use this playbook for material UI/UX changes and net-new visual builds. The goal is not to add more components. The goal is to make better design decisions by combining product evidence, the active local system, and high-quality working references.

## Required Sequence

### 1. Establish the outcome

Before browsing references, state:

- the user and product outcome;
- the current behavior or visual condition;
- the established gap;
- the Site Soul constraints;
- the assumption that would make the proposed change unnecessary.

If no material gap is established, keep the current solution.

### 2. Audit the active foundation

Inspect the repository before looking outside it:

- active entrypoints and rendered surfaces;
- existing components and composition patterns;
- design tokens, typography, spacing, color, iconography, and responsive rules;
- loading, empty, error, disabled, success, and permission states;
- animation libraries, keyframes, transitions, timing tokens, and reduced-motion handling;
- accessibility utilities and behavioral or visual tests.

Separate active implementation from leftovers. Record what can be kept unchanged and what can be modified before considering something new.

### 3. Build the reference brief

For each established gap, search the local foundation first. Then inspect suitable external sources through their official catalog index, registry, agent-readable inventory, source repository, and live preview where available. Do not install anything during discovery.

Capture this decision record:

| Need or gap | Local candidate | External candidate and source | Useful difference | Site Soul fit | License and provenance | Dependencies / security / performance | Accessibility and motion risk | Decision |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| _Describe the user-facing gap_ | _Keep or modify option_ | _Component plus canonical URL_ | _What becomes possible or better_ | _Native, adaptable, or conflicting_ | _Terms, attribution, version or commit_ | _New cost and risk_ | _What must be independently verified_ | _Keep, adapt, build, or reject_ |

Use enough candidates to test whether the local solution remains best and whether a materially better fit exists. Stop when the inspected evidence establishes a winner; catalog size is not a reason to keep browsing indefinitely.

### 4. Use the starter source map appropriately

These are discovery starting points, not mandatory dependencies or a complete approved list. Availability, pricing, terms, source code, and quality can change; recheck them at adoption time.

| Source | Best use | Current constraint |
| --- | --- | --- |
| The active product repository | Existing primitives, product-specific patterns, and proven behavior | Always inspect first; confirm the code is active. |
| [shadcn/ui](https://ui.shadcn.com/) | Accessible open-code foundations and common interface primitives | MIT-licensed upstream; still adapt tokens, states, and behavior to the product. |
| [Beautiful UI](https://beautifului.dev/) | AI-native interaction and agent-state references | Use as inspiration unless the exact component's source and license are clear. |
| [beUI](https://beui.dev/) | Copy-owned React motion components and product interactions | The public catalog is MIT; Pro material has separate access and licensing. |
| [Rare UI](https://rareui.com/) | Distinctive animated React components when the product genuinely needs a signature interaction | The public repository is MIT and claims reduced-motion support; verify the selected component in the product. |
| [Transitions.dev](https://transitions.dev/) | Focused CSS/React transition recipes and motion-token references | Product use is allowed under its current terms; free and Pro access differ, and redistribution as a competing library is restricted. |

License review here is a provenance gate, not legal advice. If terms are missing, ambiguous, incompatible, or unavailable, do not copy the code. Use the visual behavior only as inspiration and implement an original solution if the outcome still requires it.

### 5. Make the decision

Run every candidate through these tests:

- **Difference:** What concrete, useful difference does this make from the active solution?
- **Outcome:** Does that difference improve the defined user or product outcome?
- **Reuse:** Can the active solution close the gap unchanged or with a smaller modification?
- **Assumption:** Which fact would make this candidate the wrong choice?
- **Component:** Does this module pass on its own, independent of the overall visual direction?

Choose the smallest viable decision:

- **Keep** the active solution.
- **Adapt** one internal or licensed external module.
- **Build** a new module because inspected options fail documented constraints.
- **Reject or defer** the change because evidence does not establish a useful difference.

### 6. Integrate in product order

When adaptation or new construction is required:

1. Preserve semantics, keyboard behavior, focus, and state logic.
2. Normalize the module to local tokens, typography, spacing, radii, iconography, and copy.
3. Fit it into the existing layout and responsive system.
4. Cover loading, empty, error, disabled, success, and permission states that apply.
5. Align motion with local timing and easing; remove movement that lacks purpose.
6. Remove unused source code and dependencies.
7. Record the canonical source URL, accessed version or commit, license, attribution requirement, and meaningful adaptations near the repository's existing provenance mechanism.

Do not preserve source branding or demo copy unless the product explicitly requires it.

### 7. Verify the result

Acceptance uses the integrated product, not the source demo:

- behavior tests for the user outcome;
- keyboard, focus, semantic, and screen-reader checks;
- reduced-motion and non-motion parity;
- responsive checks at narrow, standard, and wide layouts;
- pointer and touch behavior where applicable;
- loading, empty, error, disabled, success, and permission states;
- contrast, zoom, reflow, and target-size checks;
- dependency, bundle, render, and animation performance appropriate to the surface;
- screenshots or short video proof from the final branch when the behavior is visible.

## Required Handoff

Every task or pull request must report:

- established gap and intended outcome;
- local foundation inspected;
- reference sources and catalog/index surfaces inspected;
- candidates considered and keep/adapt/build/reject decisions;
- selected source provenance, license, attribution, dependencies, and access status;
- Site Soul changes made to the selected module;
- accessibility, reduced-motion, responsive, state, and performance verification;
- required work, experiments with metrics, and unnecessary work rejected.

If no external component was adopted, say so. A reference scan that proves the current design is best is a successful result.
