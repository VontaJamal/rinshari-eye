# Language Exception Record

- language: HTML and CSS
- scope: Dependency-free visual technique lab under `examples/lumen-craft-lab/`
- rationale: The owner explicitly requested practical mastery of CSS solution techniques. A no-JavaScript HTML/CSS artifact is the smallest executable proof and does not introduce a runtime application boundary.
- validation_strategy: HTML structure inspection, CSS syntax and diff checks, Chromium rendering at desktop and mobile sizes, keyboard focus, native popover behavior, horizontal overflow inspection, and reduced-motion emulation.
- risk_mitigation: The example is isolated from production, has no data flow or external runtime dependency, and uses native semantic controls. It is never treated as a downstream product template.
- review_date: 2026-08-28
