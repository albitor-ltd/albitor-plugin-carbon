# Testing for accessibility

> **Sources:** [W3C WAI: Easy Checks and Evaluation](https://www.w3.org/WAI/test-evaluate/), the [Deque axe](https://www.deque.com/axe/) and [IBM Equal Access Accessibility Checker](https://www.ibm.com/able/toolkit/) tooling docs, and industry consensus on automated coverage (Deque, WebAIM).
> WCAG 2.2 © W3C, used under the W3C Document Licence. Distilled reference — verify against the live source for current detail.

## The headline rule

**Automated testing alone is not enough.** Automated tools reliably detect only about **30–40%** of WCAG issues (estimates range ~20–40%). The remaining 60–70% — meaningful alt text, logical reading/focus order, sensible headings, understandable error messages, keyboard operability of custom widgets, multi-theme contrast — need **manual** and **assistive-technology** testing, and ultimately testing **with disabled users**.

A complete approach combines four layers: **automated → manual → assistive tech → real users.** Test continuously from the first iteration onward, not just before release. For a Carbon product, also test **in every theme you ship** — White / g10 / g90 / g100 have different colour values, so a pass in one is not a pass in all.

## 1. Automated tools

| Tool | Form | Good for |
| --- | --- | --- |
| **axe** (axe-core / axe DevTools) | Browser extension + CI library | Fast, low false-positive rule checks; integrates into unit/E2E tests. The de-facto engine (also used by Carbon's own testing). |
| **IBM Equal Access Accessibility Checker** | Browser extension + CI (`accessibility-checker`) | IBM's own checker (the one Carbon is tested with); rule set mapped to WCAG + IBM requirements; good for Carbon projects. |
| **Lighthouse** | Chrome DevTools / CI | Quick page-level accessibility score (uses axe rules) alongside performance. |
| **WAVE** | Browser extension | Visual overlay of errors, contrast, structure and ARIA on the page. |
| **pa11y** | CLI / CI | Scriptable command-line scanning across many URLs; good for pipelines. |

**What they catch:** missing `alt`, missing form labels, low colour contrast, missing `lang`, duplicate IDs, some ARIA misuse, empty links/buttons.

**What they miss:** whether alt text is *meaningful*, whether reading/focus order makes sense, whether content is understandable, whether custom widgets actually work by keyboard or screen reader, and most context-dependent criteria.

> Build axe (or the IBM Equal Access checker) into CI so regressions are caught automatically — but never treat a green automated run as "accessible". Run the scan in each Carbon theme.

## 2. Manual checks (no special software needed)

- **Keyboard-only navigation** — unplug the mouse. Tab/Shift+Tab through everything: every interactive element must be reachable, operable, and have a **visible focus indicator** (2.4.7); focus order must be logical (2.4.3); no keyboard traps (2.1.2 — check Carbon `Modal` releases focus on close); focus must not be hidden behind the sticky `Header`/`SideNav` (2.4.11). Check skip links work (2.4.1).
- **Zoom to 400%** — at 1280px width zoomed to 400% (≈320px CSS), content must **reflow** without horizontal scrolling or clipping (1.4.10, 1.4.4). Wide data tables should scroll within their own container, not force the page to scroll.
- **Text spacing** — apply a bookmarklet that increases line/letter/word/paragraph spacing; nothing should be cut off (1.4.12).
- **Colour contrast, in every theme** — check text (4.5:1, or 3:1 large) and UI/graphics (3:1) with a contrast checker (1.4.3, 1.4.11) in White, g10, g90 and g100. Check information isn't conveyed by colour alone (1.4.1 — status tags/notifications carry text/icons).
- **Content structure / headings** — verify a single logical `<h1>` and a correct heading hierarchy (Carbon `Section`/`Heading` helps); check landmarks (`<nav>`, `<main>`); confirm lists, tables and form labels use real semantic markup (1.3.1, 2.4.6).
- **Forms** — every field has a persistent `labelText`, errors are described in text (`invalidText`) and suggest a fix, and there's a review step for important submissions (3.3.1–3.3.4).
- **Data tables** — header cells are real `<th scope>` (DataTable does this), sort controls and row actions are keyboard-operable, and row reordering has a non-drag alternative (2.5.7).
- **Reduced motion / autoplay** — moving content can be paused (2.2.2); auto-refreshing dashboards respect `prefers-reduced-motion`; nothing flashes more than 3×/sec (2.3.1).
- **Target size** — pointer targets are at least 24×24px (2.5.8); keep Carbon's default sizes.
- **Link text** — links make sense out of context; replace "click here"/"read more" (2.4.4).

## 3. Testing with assistive technology

Test with the combinations real users actually use. Recommended pairings:

| Assistive tech | Recommended browser | Platform |
| --- | --- | --- |
| **NVDA** (free) | **Firefox** (or Chrome) | Windows |
| **JAWS** | **Chrome** (or Edge) | Windows |
| **VoiceOver** | **Safari** | macOS / iOS |
| **TalkBack** | Chrome | Android |
| **Voice control** (Dragon, Voice Control, Voice Access) | — | Test that spoken labels match visible labels (2.5.3) |
| **Screen magnifier** (ZoomText, OS magnifier) | — | Check layout and focus tracking at high magnification |

When screen-reader testing, confirm: images announce sensible alternatives; icon-only buttons announce their `iconDescription`; headings and landmarks let you navigate; form fields announce their label, role and error state; `DataTable` announces column headers and selection; dynamic updates are announced via live regions (4.1.3 — Carbon notifications/`InlineLoading`); custom widgets announce correct name/role/value (4.1.2).

> NVDA + Firefox and VoiceOver + Safari are the most common free starting points. JAWS + Chrome covers the dominant commercial screen reader in enterprise environments.

## 4. Testing with disabled users and a formal audit

- **Test with disabled and older users** as part of user research — it surfaces issues no tool or checklist will.
- **Get a formal accessibility audit** before a major release or when a buyer requires one. A third-party audit against WCAG 2.2 AA (and Section 508 / EN 301 549 if required) produces the evidence behind a **VPAT/ACR** (see `accessibility-statement.md`) and a remediation plan.

## Pre-release checklist

- [ ] Automated scan (axe / IBM Equal Access / Lighthouse / pa11y) passes with no outstanding errors, **and** is wired into CI, **and** run in every theme.
- [ ] Full keyboard-only pass: everything reachable, operable, visible focus, logical order, no traps, focus never obscured by the shell.
- [ ] Skip link present and working; landmarks in place.
- [ ] Reflows cleanly at 400% zoom / 320px; wide tables scroll in-container; survives increased text spacing.
- [ ] Text contrast ≥ 4.5:1 (3:1 large); UI/graphic contrast ≥ 3:1 — verified in White, g10, g90, g100; no colour-only information.
- [ ] One logical `<h1>`, correct heading hierarchy, semantic markup throughout.
- [ ] Every form field labelled; errors identified, described and suggest a fix; review step for key submissions.
- [ ] `DataTable` header `scope` intact; row actions keyboard-operable; drag actions have a non-drag alternative.
- [ ] Pointer targets ≥ 24×24px; gesture alternatives exist.
- [ ] Screen-reader pass with NVDA+Firefox and VoiceOver+Safari (ideally JAWS+Chrome too).
- [ ] Dynamic updates announced (live regions); custom widgets expose correct name/role/value.
- [ ] Page titles unique and descriptive; `lang` set on `<html>`.
- [ ] Tested with disabled users; formal audit completed where required by release stage or buyer.
- [ ] Accessibility conformance report (VPAT/ACR) or accessibility statement prepared, accurate, and listing known issues with fix dates.
