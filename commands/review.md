---
description: Review frontend changes against both the IBM Carbon Design System and WCAG 2.2 AA.
argument-hint: "[file/dir path, or leave blank for the current changes]"
---

Review the Carbon frontend in scope: **$ARGUMENTS** (if empty, review the current uncommitted changes; fall back to recently edited frontend files).

Load **both** skills: `carbon-design-system` and `carbon-accessibility`. Then review on two axes:

1. **Carbon conformance** (`references/components.md`, `patterns.md`, `styles.md`):
   - Are vetted Carbon components used where one exists, instead of bespoke markup? (A hand-rolled dropdown, a raw `<table>` instead of `DataTable`, a custom modal instead of `Modal`/`ComposedModal` are the usual offenders.)
   - Are components used **unmodified** — classes/props intact, kinds and colour meanings not repurposed, `support-error` red not reused for emphasis?
   - Are the right patterns applied (dashboard layout on the 2x Grid, form structure, notification hierarchy — inline vs toast vs actionable, empty/loading/error states)?
   - Hardcoded hex colours or px instead of Carbon **tokens** (`$text-primary`, `$layer-01`, `$support-error`, `$focus`, `$spacing-05`) and the type set? Overridden token values that break theme switching (White / g10 / g90 / g100)?
   - Correct **theming**: content sits inside a `Theme`/layer context and uses `$layer` tokens so it works in dark themes, not fixed light colours.

2. **Accessibility** (`references/wcag-2.2.md`): run the WCAG 2.2 AA checks — alt text, icon-only button `aria-label`, field labels, focus visibility, heading order, contrast (in each theme), `lang`, announced + linked errors and notifications, target size, keyboard operability, `DataTable` header `scope`.

Report findings grouped by axis, each with `file:line`, severity (Blocker/Major/Minor), the problem, and a concrete fix (name the Carbon component or token). Note any issue that needs a real-browser, multi-theme, or assistive-tech check rather than static review. Finish with a prioritised to-do list. Be specific and code-level; don't restate the standards in the abstract.
