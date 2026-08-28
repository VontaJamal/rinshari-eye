# Language Exception Record

- language: CSS and HTML
- scope: The opt-in package under `kits/css-craft/`, including its behavior recipes and dependency-free consumer example.
- rationale: The owner explicitly requested that the learned CSS solution techniques become functional and reusable across repositories. Native CSS is the smallest portable artifact and avoids adding a JavaScript runtime or build dependency.
- validation_strategy: Package manifest inspection, local `npm pack` verification, CSS import-graph checks, browser rendering of the consumer example, narrow and wide layout assertions, keyboard and popover operation, horizontal overflow inspection, and reduced-motion emulation.
- risk_mitigation: Every selector uses the `rse-` prefix and zero-specificity `:where()` wrappers, the package ships no typography or product color system, recipes are opt-in, and local unlayered product CSS can override every default.
- review_date: 2026-08-28
