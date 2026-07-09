---
name: carbon-accessibility
description: Use when building, reviewing, testing, or advising on the accessibility of an enterprise or B2B web application — especially one built with IBM Carbon, where WCAG 2.2 AA is the baseline and buyers may require Section 508, EN 301 549, or a VPAT/ACR. Covers all 50 WCAG 2.2 Level A and AA success criteria, the enterprise accessibility standards landscape, the accessibility conformance report (VPAT/ACR), and how to test (automated with axe / IBM Equal Access Checker, manual, and assistive technology).
---

# Accessibility (WCAG 2.2 AA) for enterprise Carbon products

Help developers make enterprise and B2B applications accessible, and meet the accessibility expectations that procurement, legal, and buyers place on business software.

## What matters here (the short version)

- **WCAG 2.2 Level AA is the baseline** — every Level A and AA success criterion. Level AAA is not required.
- Enterprise buyers and regulators frequently require conformance against a **procurement standard**: **Section 508** (US federal, references WCAG 2.0/2.1 AA), **EN 301 549** (EU — underpins the **European Accessibility Act**, references WCAG), plus general duties under the **ADA** (US) and equivalents. All of these ultimately point at WCAG, so meeting WCAG 2.2 AA covers the substance.
- Buyers typically ask for an **accessibility conformance report** — a **VPAT® / ACR** stating Supports / Partially Supports / Does Not Support per criterion. Details and a structure are in `references/accessibility-statement.md`.
- **Carbon helps but does not guarantee.** Carbon components are engineered for accessibility and reduce risk substantially — but only when used unmodified and wired up correctly; the surrounding code can still fail.

## Bundled references — read the relevant one before answering in detail

| File | When to read it |
| --- | --- |
| `references/wcag-2.2.md` | Auditing or implementing against specific criteria. All 50 A/AA criteria grouped by POUR, each with a plain-English requirement and a how-to-meet tip. Flags the 6 new 2.2 criteria and the removal of 4.1.1 Parsing. |
| `references/accessibility-statement.md` | Writing or reviewing a VPAT/ACR or a public accessibility statement — the standards landscape (Section 508, EN 301 549, EAA, ADA), conformance levels, and a template. |
| `references/testing.md` | Planning or running accessibility testing — automated tools (axe, IBM Equal Access Accessibility Checker) and their limits, manual checks, assistive-technology pairings, multi-theme checks, and a pre-release checklist. |

Distilled from W3C WCAG 2.2 and public accessibility guidance (WCAG © W3C, used under the W3C Document Licence). For exact wording always confirm against <https://www.w3.org/TR/WCAG22/>.

## Working rules

- **Automated tools catch only ~30–40% of issues.** Never claim a product is accessible on the strength of axe/Lighthouse/IBM Equal Access alone. Always combine automated checks with keyboard-only testing, zoom/reflow, and a screen-reader pass. See `references/testing.md`.
- **Test in every theme you ship.** Carbon's White / g10 / g90 / g100 themes each have their own colour values — a contrast pass in one theme does not cover the others.
- **Don't assert "WCAG 2.2 AA compliant" loosely.** Tie any claim to specific criteria and test evidence; prefer "tested against…" / "Partially Supports with these exceptions" over blanket compliance unless an audit backs it. Never inflate a VPAT conformance level.
- Think in the four principles: is content **Perceivable** (text alternatives, contrast, structure), **Operable** (keyboard, focus, target size, no traps), **Understandable** (labels, errors, consistent help), and **Robust** (valid name/role/value, status messages)?
- Common high-impact fixes to check first: meaningful `alt` (and `alt=""` for decorative), icon-only button accessible names (`iconDescription`), every field labelled, visible focus, logical heading order, 4.5:1 text contrast in each theme, `lang` on `<html>`, errors/notifications announced and linked, `DataTable` header `scope`, and 24×24px minimum target sizes.
- Carbon components meet many criteria out of the box — but only if used correctly and not restyled. Pair with the `carbon-design-system` skill.

## Related

- `carbon-design-system` skill — accessible Carbon components that meet many of these criteria out of the box.
- Commands: `/carbon:audit`, `/carbon:accessibility-statement`, `/carbon:review`.
