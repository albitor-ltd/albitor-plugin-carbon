---
name: carbon-design-system
description: Use when building, reviewing, or discussing an enterprise, data-heavy or B2B frontend — any React/Web Component/HTML UI that should follow the IBM Carbon Design System. Covers the Carbon component library (data tables, forms, UI Shell, notifications, tiles), dashboard and form patterns, the IBM Design Language styles (2x Grid, IBM Plex type, theme tokens, spacing scale, motion), and how to consume Carbon (@carbon/react, @carbon/web-components, @carbon/styles) with correct theming and token discipline.
metadata:
  capability: design-system
---

# IBM Carbon Design System

Help developers build enterprise interfaces that follow the **IBM Carbon Design System** so they look and behave like a consistent, accessible, data-dense product — the archetype Carbon is built for: dashboards, admin consoles, data tables, and B2B/internal tools.

Carbon is **open source** (Apache-2.0) and free for anyone to use — this is unlike a government design system where the branding is licence-restricted. What is restricted is the **IBM brand**, not Carbon itself (see the table below).

## First: is this an IBM product? (decides the brand and which flavour of Carbon you may use)

Carbon has two layers. The **open-source Carbon Design System** (`@carbon/react`, `@carbon/web-components`, `@carbon/styles`) is for **everyone**. **Carbon for IBM Products** (`@carbon/ibm-products`) and the IBM brand assets are for **IBM products only**.

| | **Any product** (not IBM-branded) | **IBM products only** |
| --- | --- | --- |
| Carbon components, patterns, 2x Grid, spacing & type scale, theme tokens | ✅ Use them all (Apache-2.0) | ✅ Use them all |
| IBM Plex typeface (Sans, Serif, Mono, Condensed) | ✅ Use it — it is open source (SIL Open Font License) | ✅ Use it |
| Carbon icons and pictograms | ✅ Use them (Apache-2.0) | ✅ Use them |
| **IBM logo / IBM 8-bar mark / "IBM" wordmark / IBM Plex brand lockups** | ❌ **Never** — IBM trademarks; don't imply you are IBM or an IBM product | ✅ Per IBM brand guidelines |
| **Carbon for IBM Products** (`@carbon/ibm-products`) app frames, IBM.com themes, IBM-specific patterns | ⚠️ Available open-source but styled/positioned for IBM products — prefer core Carbon for a non-IBM product | ✅ Intended use |

Unlike GDS Transport, **IBM Plex is genuinely free to use anywhere** — so an off-brand Carbon build keeps the full type system. The only hard line is the **IBM logo and "IBM" name**. If you do not know whether the product is IBM-branded, **do not** add any IBM logo, wordmark, or IBM.com framing — ask first. Sources: [Carbon Design System](https://carbondesignsystem.com/), [IBM Design Language](https://www.ibm.com/design/language/), [IBM Plex](https://www.ibm.com/plex/).

## Core principles (apply these first)

1. **Use a Carbon component if one exists.** Carbon has a vetted, accessible, themeable component for almost every enterprise need — most importantly `DataTable`, forms, `Modal`, notifications, and the UI Shell (`Header`/`SideNav`). Reach for it before inventing markup. The full catalogue is in `references/components.md`.
2. **Do not restyle components or override token values.** Keep Carbon's kinds and token meanings. Don't recolour `Button` kinds, repurpose the `support-error` red for emphasis, or hardcode hex/px — consume the theme tokens and spacing scale so the UI tracks theme changes and stays consistent.
3. **Theme with tokens, not fixed colours.** Every colour comes from a token (`$background`, `$layer-01`, `$text-primary`, `$link-primary`, `$support-error`, `$focus`) resolved by the active theme (**White, Gray 10 (g10), Gray 90 (g90), Gray 100 (g100)**). Hardcoding light-mode hex breaks dark themes and layering. See `references/styles.md`.
4. **Compose with patterns, not just components.** A dashboard, a form, a notification hierarchy (inline vs toast vs actionable), and empty/loading/error states are *patterns* — tested arrangements of components. See `references/patterns.md`.
5. **Accessibility is built in but not automatic.** Carbon components are engineered for accessibility, but only when used unmodified and wired up correctly (labels, `aria-label` on icon-only buttons, `scope` on table headers). Pair this with the `carbon-accessibility` skill when auditing.

## Bundled references — read the relevant one before answering in detail

| File | When to read it |
| --- | --- |
| `references/components.md` | Choosing/implementing any UI element. The Carbon component inventory (the conformance list for the "0 ad-hoc components" gate): React and Web Component names, whether they need JS, when (not) to use them, and accessibility gotchas. |
| `references/patterns.md` | Designing a screen or a flow — dashboards, forms, notifications, tables, empty/loading/error states, navigation with the UI Shell. |
| `references/styles.md` | The 2x Grid, IBM Plex type set, theme tokens and the four themes, the spacing scale, motion, focus, and colour/contrast. |
| `references/frontend-conventions.md` | Installing/using Carbon: `@carbon/react` vs `@carbon/web-components` vs class-based `@carbon/styles`, theming setup, and consuming Carbon from Vue/Svelte/other stacks. |

These are distilled from the live Carbon Design System and IBM Design Language (Apache-2.0). They are a fast index — for exact, current detail always confirm against <https://carbondesignsystem.com/>, especially token values and component APIs, which change across major versions (Carbon v10 → v11 renamed many tokens).

## Working rules

- **Don't hardcode hex or px.** Use theme tokens for colour and the spacing tokens (`$spacing-01`…`$spacing-13`) / layout tokens for space. See `references/styles.md`.
- **Prefer the maintained implementation.** In React, use `@carbon/react`; for framework-agnostic or non-React stacks, use `@carbon/web-components` (the `cds-*` custom elements). Both track the same design and accessibility work. Class-based `@carbon/styles` HTML is the fallback when you can't run either — you then hand-maintain the markup and behaviour.
- **Forms:** every input needs a `labelText` (or an associated `<label>`); never use placeholder text as the label. On error, set `invalid` + `invalidText` on the field and surface a form-level summary; validate server-side too.
- **Data tables are the centre of gravity.** For enterprise data, reach for `DataTable` with its toolbar, sorting, selection, batch actions, expansion and pagination rather than a bespoke table — it carries the accessibility and keyboard wiring.
- **UI Shell for chrome:** use `Header`, `HeaderNavigation`, `SideNav` and `HeaderGlobalBar` for app navigation rather than hand-rolling a top bar and sidebar.

## Related

- `carbon-accessibility` skill — WCAG 2.2 AA and the enterprise accessibility landscape (Section 508, EN 301 549, VPAT/ACR) these components help you meet.
- Commands: `/carbon:component`, `/carbon:review`, `/carbon:preview`.
