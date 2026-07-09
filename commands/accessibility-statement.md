---
description: Draft an accessibility conformance statement / VPAT-style report for an enterprise Carbon product.
argument-hint: "[product name / details, or leave blank to be prompted]"
---

Help the user produce an **accessibility conformance statement** for an enterprise product — the artefact procurement, security, and legal teams ask for (an ITI VPAT® / Accessibility Conformance Report, or a public accessibility statement). Context provided: **$ARGUMENTS**

1. Load the `carbon-accessibility` skill and read `references/accessibility-statement.md` (the conformance-statement / VPAT structure and the standards landscape) and `references/testing.md` (how the evidence behind the claims is produced).
2. Gather the facts you need — ask concisely for anything missing:
   - Product/application name and version, and the responsible organisation and contact.
   - Which standard(s) the report is against: **WCAG 2.2 AA** (baseline here), and any procurement standard the buyer requires — **Section 508** (US federal), **EN 301 549** (EU, incl. the European Accessibility Act), or a public **accessibility statement**.
   - Conformance level per criterion: **Supports / Partially Supports / Does Not Support / Not Applicable**, with a short remark each (the VPAT convention) — offer to run `/carbon:audit` first if this is unknown.
   - Known non-conforming areas and the failing criteria, plus target remediation dates.
   - How it was tested (self-assessment, automated axe / IBM Equal Access Checker, manual + assistive-technology, or third-party audit) and when.
3. Produce the statement. For a **VPAT/ACR**, use the standard table shape (Criteria | Conformance Level | Remarks and Explanations) grouped by WCAG 2.2 A and AA (and the Section 508 / EN 301 549 chapters if requested). For a **public accessibility statement**, produce a clean prose page: what the product supports, known issues with fix dates, how to report a problem and request an alternative, and how/when it was tested.
4. Flag anything asserted but unverified (e.g. "Supports" with no test evidence) and recommend the testing needed to back it. Never inflate a conformance level — "Partially Supports" with an honest remark is more useful, and more defensible, than an unearned "Supports".

Output the finished statement as clean Markdown the user can publish or hand to a buyer, plus a short note of what still needs confirming.

> Note: **VPAT®** is a registered trademark of the Information Technology Industry Council (ITI). Use the official ITI template wording and version where a formal VPAT is required; this command drafts the content, it does not replace the official form.
