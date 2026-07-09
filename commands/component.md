---
description: Look up or scaffold an IBM Carbon Design System component (markup, React/Web Component, accessibility notes).
argument-hint: "[component name or what you're trying to build]"
---

The user wants help with an IBM Carbon Design System component: **$ARGUMENTS**

Do the following:

1. Load the `carbon-design-system` skill and read `references/components.md` (and `references/patterns.md` if the request describes a flow or screen — dashboard, form, notifications, empty state — rather than a single element).
2. Identify the right component(s). If the request is vague (e.g. "let users pick from a long list"), recommend the correct component and say why (`Dropdown` vs `ComboBox` vs `MultiSelect` vs `Search`); mention any component they should *not* use (e.g. a raw `<select>` where `Dropdown` exists, or a bespoke `<table>` where `DataTable` is warranted).
3. Provide:
   - The **React** form (`@carbon/react`, e.g. `<Button>`, `<TextInput>`, `<DataTable>`) with realistic props, **and**
   - The equivalent **Web Component / plain-markup** form (`@carbon/web-components`, `cds-button` etc., or the `@carbon/styles` class-based HTML) for non-React stacks.
4. Call out the **accessibility requirements** for that component: labels/`labelText`, `aria-label` on icon-only buttons, `invalid` + `invalidText` for errors, `scope` on `DataTable` headers, focus management for `Modal`/`OverflowMenu`, live-region announcements for `InlineLoading`/notifications, and any "when not to use" guidance.
5. Respect **token discipline**: don't hardcode hex colours or px — use Carbon theme tokens (`$text-primary`, `$layer-01`, `$support-error`, `$focus`) and spacing tokens (`$spacing-05`). Use the component unmodified; don't recolour `Button` kinds or repurpose `support-error` red.
6. Match the surrounding codebase: detect whether the project uses `@carbon/react`, `@carbon/web-components`, Vue/Svelte community ports, or class-based `@carbon/styles`, and tailor the snippet to it.

If no argument was given, ask what they're building and list the component categories from the reference (actions, forms & inputs, data display incl. `DataTable`, navigation & UI Shell, notifications & status, containers & disclosure).
