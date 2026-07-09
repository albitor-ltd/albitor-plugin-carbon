# Accessibility conformance statements (VPAT / ACR) and public accessibility statements

> **Sources:** [ITI VPAT®](https://www.itic.org/policy/accessibility/vpat), [Section 508](https://www.section508.gov/), [EN 301 549](https://www.etsi.org/standards) / the [European Accessibility Act](https://ec.europa.eu/social/main.jsp?catId=1202), and [W3C WCAG 2.2](https://www.w3.org/TR/WCAG22/).
> WCAG 2.2 © W3C, used under the W3C Document Licence. Distilled reference — verify against the live source for current detail. VPAT® is a registered trademark of the Information Technology Industry Council (ITI).

Enterprise buyers, public-sector procurement, and legal/security teams ask software vendors to **document** their accessibility. There are two related deliverables:

- an **Accessibility Conformance Report (ACR)**, usually produced on the **VPAT®** template — a per-criterion Supports / Partially Supports / Does Not Support report used in procurement; and
- a public **accessibility statement** — a plain-language page saying what the product supports, known issues, and how to get help.

Which one you need depends on the buyer and jurisdiction.

## The standards landscape (what buyers reference)

All of these ultimately point at **WCAG** — meeting **WCAG 2.2 AA** covers the substance of each:

| Standard | Where it applies | What it references |
| --- | --- | --- |
| **WCAG 2.2 AA** | Global technical baseline | The success criteria themselves (this plugin's `wcag-2.2.md`). |
| **Section 508** | US federal government procurement | Incorporates WCAG 2.0 Level AA (the "508 refresh"); often satisfied by demonstrating WCAG 2.1/2.2 AA. |
| **EN 301 549** | EU (and the **European Accessibility Act**, applying to many private-sector products from June 2025) | Incorporates WCAG (2.1 AA and rising); the harmonised EU standard. |
| **ADA** (US) | General non-discrimination duty (private + public) | No fixed technical standard, but courts/settlements treat WCAG AA as the benchmark. |
| **Public sector accessibility regulations** (UK/EU member states) | Government websites/apps | WCAG AA + a published accessibility statement. |

Because they converge on WCAG AA, the practical route is: **conform to WCAG 2.2 AA, test it, and report it** in whichever format the buyer needs.

## The VPAT® / ACR

### The four VPAT editions
The VPAT template has editions you pick by target market:
- **WCAG** edition — WCAG 2.x only.
- **508** edition — Revised Section 508 (US).
- **EU** edition — EN 301 549.
- **INT** (International) edition — all of the above combined (most common for products sold globally).

Use the current ITI template and version for a formal VPAT.

### Conformance levels (the core of the report)
For **every** applicable success criterion, state one level and a supporting remark:

| Level | Meaning |
| --- | --- |
| **Supports** | The functionality meets the criterion (with no or only minor exceptions). |
| **Partially Supports** | Some functionality meets it; there are known exceptions (list them). |
| **Does Not Support** | The majority does not meet the criterion. |
| **Not Applicable** | The criterion does not apply to the product (e.g. no audio/video). |

Never inflate a level. An honest **"Partially Supports"** with a specific remark and a remediation date is more useful — and more defensible — than an unearned "Supports". Every claim should be backed by test evidence (see `testing.md`).

### ACR structure
An Accessibility Conformance Report on the VPAT template typically contains:
1. **Product/version** and evaluation date; **contact** for accessibility.
2. **Evaluation methods used** — automated (axe / IBM Equal Access), manual, assistive technology, and any third-party audit.
3. **Applicable standards/guidelines** — the editions covered (WCAG 2.2 AA, and 508 / EN 301 549 if included).
4. **Tables** per standard: **Criteria | Conformance Level | Remarks and Explanations**, grouped by WCAG A then AA (and the 508 / EN 301 549 chapters if included).
5. Notes on known issues and planned remediation.

## Public accessibility statement (prose page)

For a customer-facing statement (rather than a procurement VPAT), publish a clean page linked from the footer. Cover:
1. **Commitment** — a sentence on the organisation's accessibility commitment and the standard targeted (WCAG 2.2 AA).
2. **What the product supports** — e.g. resize to 400%, keyboard operation, screen-reader support, high-contrast/dark themes (Carbon's g90/g100).
3. **Known issues** — parts that don't yet fully conform, the criteria they fail, and target fix dates.
4. **Feedback and contact** — how to report a problem and request an accessible alternative, with a response-time commitment.
5. **How and when it was tested** — self-assessment / automated / manual + AT / third-party audit, and the date; review at least annually and on material change.

---

## Fill-in-the-blanks template (public accessibility statement)

Copy this and replace the `[bracketed]` text.

```markdown
# Accessibility statement for [product name]

[Organisation name] is committed to making [product name] accessible to as many
people as possible, in line with the Web Content Accessibility Guidelines
(WCAG) 2.2 level AA.

## What we support

We aim to let you:
- resize text up to 400% without loss of content or function
- operate the product using a keyboard alone
- use the product with a screen reader (recent JAWS, NVDA and VoiceOver)
- choose a light or dark theme for comfortable contrast

## How accessible this product is

[Choose ONE and adapt:]
[We believe [product name] conforms to WCAG 2.2 AA.]
[We know some parts are not yet fully accessible — see below.]

## Known issues

[List known non-conformances, the WCAG 2.2 criteria they fail, and a target fix date, e.g.:]
- Some data tables do not yet announce sort direction to screen readers. This
  fails WCAG 2.2 criterion 4.1.2 (name, role, value). We plan to fix this by [date].

## Feedback and getting help

If you find an accessibility problem, or need information in a different format:
- email [email address]
- call [phone number]
We aim to respond within [number] working days.

## How we tested this product

[Product name] version [x.y] was last tested on [date] by
[your team / third-party auditor]. We tested using [automated checks
(axe / IBM Equal Access), manual keyboard and screen-reader testing, and/or a
third-party audit] against WCAG 2.2 AA[, and Section 508 / EN 301 549 where noted].

This statement was prepared on [date] and is reviewed at least annually.
```

### Notes for developers filling this in

- Tie every "supports" claim to **test evidence** — don't assert what you haven't tested.
- For each known issue, cite the **WCAG 2.2 success criterion** and, ideally, a target fix date.
- For a formal procurement **VPAT**, use the current official ITI template and the right edition (INT if selling globally); this plugin drafts the content, it does not replace the official form.
- Keep it honest and specific — buyers' accessibility teams re-test against the actual product.
