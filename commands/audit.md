---
description: Audit a page, component, or file against WCAG 2.2 AA and report prioritised findings.
argument-hint: "[file path, URL, component, or 'the current changes']"
---

Run a WCAG 2.2 AA accessibility audit of: **$ARGUMENTS** (if empty, audit the frontend files in the current changes / working directory).

Use the `carbon-accessibility-auditor` agent for a thorough pass, or do it inline for a small scope. Either way:

1. Load the `carbon-accessibility` skill; use `references/wcag-2.2.md` as the criteria checklist and `references/testing.md` for method (axe / IBM Equal Access Accessibility Checker plus manual and AT passes).
2. Determine the target: a local file (Read it), a described component, or the current diff. State clearly what you examined and acknowledge what you **cannot** verify statically (focus order in a real browser, screen-reader output, contrast of dynamically-set colours across the White / g10 / g90 / g100 themes) — recommend the manual/AT tests from `references/testing.md` for those.
3. Walk the four POUR principles. For each issue found, report:
   - **Criterion** (e.g. `1.1.1 Non-text Content`, Level A/AA)
   - **Severity** (Blocker / Major / Minor)
   - **Location** (`file:line`)
   - **What's wrong** and **the fix** (concrete code — name the Carbon component or token where relevant).
4. Prioritise: list Blockers and Majors first. Group the high-frequency checks (alt text, icon-only button `aria-label`, field labels, focus visibility, heading order, contrast, `lang`, announced errors/notifications, 24px target size, `DataTable` header `scope`).
5. End with a short summary: counts by severity, and which criteria you could and could not assess statically.

Do not declare the page "WCAG 2.2 AA compliant" — automated/static review alone cannot establish that. Frame the result as findings plus the remaining manual tests needed. Carbon's components are built to be accessible, but only when used unmodified and wired up correctly — a component can still fail if its labels, ARIA, or keyboard behaviour are broken by the surrounding code.
