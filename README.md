# IBM Carbon standards plugin (`carbon`)

A [Claude Code plugin](https://code.claude.com/docs/en/plugins) that helps you build and audit **enterprise, data-heavy, B2B** interfaces with the **IBM Carbon Design System**. It packages Carbon's components (React and Web Components), patterns, IBM Design Language styles/tokens, and **WCAG 2.2 AA accessibility** into skills, commands, an audit agent, an advisory hook, and a self-contained preview page.

It is one of the design-system plugins Albitor makes available to its users — the enterprise / internal-tool / data-dashboard archetype (dashboards, admin consoles, data tables, forms). The standards content is distilled from the live Carbon and W3C sources and bundled so the assistant has authoritative reference material to hand (see [Licensing](#licensing)).

## What's inside

### Skills (load automatically when relevant)

| Skill | Triggers on | Bundled references |
| --- | --- | --- |
| `carbon:carbon-design-system` | Building/reviewing an enterprise or B2B frontend with Carbon | The Carbon component inventory, dashboard/form/table/notification patterns, IBM Design Language styles (2x Grid, IBM Plex, theme tokens, spacing, motion), and how to consume `@carbon/react` / `@carbon/web-components` / `@carbon/styles` |
| `carbon:carbon-accessibility` | Building/testing/advising on accessibility | All 50 WCAG 2.2 A/AA criteria, the enterprise standards landscape (Section 508, EN 301 549, EAA, ADA), the VPAT/ACR conformance report, and how to test (axe / IBM Equal Access, manual, AT) |

### Commands

| Command | Does |
| --- | --- |
| `/carbon:component [name or need]` | Look up or scaffold a Carbon component — React **and** Web Component/markup, with accessibility notes and token discipline. |
| `/carbon:audit [target]` | WCAG 2.2 AA audit of a file, component, or the current changes; prioritised findings. |
| `/carbon:review [target]` | Review frontend changes against **both** Carbon conformance and WCAG 2.2 AA. |
| `/carbon:accessibility-statement [details]` | Draft an accessibility conformance statement (VPAT/ACR) or a public accessibility statement. |
| `/carbon:preview [focus]` | Open the bundled static Carbon kitchen-sink, or generate a tailored self-contained preview. |

### Agent

- `carbon-accessibility-auditor` — a read-heavy subagent for a thorough WCAG 2.2 AA + Carbon-conformance audit without polluting the main context. Used by `/carbon:audit`, or invoke directly.

### Hook

- A non-blocking `PostToolUse` hook (`hooks/check-frontend.sh`) that runs after edits to frontend files (`.html`, `.jsx`, `.tsx`, `.svelte`, `.vue`, and more). It flags a **high-confidence** subset of issues — missing `alt`, missing `lang`, positive `tabindex`, click handlers on `<div>`/`<span>`, plus Carbon-specific nudges (a raw `<select>`/`<table>` where a Carbon component exists, and icon-only Carbon buttons missing an accessible name) — and surfaces them to Claude to fix. It never blocks and stays silent on clean files. It is a nudge, not a substitute for `/carbon:audit`. Requires `jq`.

### Preview page

- `preview/index.html` — a **self-contained** static kitchen-sink (no build step, no network) that renders Carbon-styled core components (buttons, inputs, dropdown, data table, tabs, tiles, structured list, notifications, tags, modal, and more). It opens standalone from `file://` and is used by the create/describe-and-build flow, as a review baseline, and in the handover pack.

## Installing

Add the marketplace that lists this plugin, then install:

```bash
claude plugin marketplace add albitor-ltd/albitor-plugins
claude plugin install carbon@albitor-plugins
```

Or load it directly for one session during development:

```bash
claude --plugin-dir /path/to/albitor-plugin-carbon
```

Validate the plugin structure:

```bash
claude plugin validate /path/to/albitor-plugin-carbon
```

## Keeping it current

The bundled references are a distilled snapshot, not a live mirror. Carbon moves fast (the v10 → v11 shift renamed many tokens and moved packages to the `@carbon/*` scope), so the skills always tell the assistant to confirm exact, current detail against the live sources:

- IBM Carbon Design System — <https://carbondesignsystem.com/>
- IBM Design Language — <https://www.ibm.com/design/language/>
- IBM Plex — <https://www.ibm.com/plex/>
- WCAG 2.2 — <https://www.w3.org/TR/WCAG22/>
- IBM accessibility toolkit / Equal Access — <https://www.ibm.com/able/>

To refresh the references, re-distil from those sources into `skills/*/references/` and bump the `version` in `.claude-plugin/plugin.json`.

## A note on the IBM brand

Carbon itself is **open source and free to use anywhere** (Apache-2.0), and **IBM Plex** is open (SIL Open Font License) — so a non-IBM product keeps the full design and type system. What is **not** free is the **IBM brand**: the IBM logo, the 8-bar mark, the "IBM" wordmark, and the IBM-branded **Carbon for IBM Products** framing are IBM trademarks and must not be used on a non-IBM product. The skills enforce this distinction; the audit agent flags misuse.

## Licensing

- **Plugin code** (manifest, skills wiring, commands, agent, hook script, preview page): Apache-2.0 — see [`LICENCE`](LICENCE) and [`NOTICE`](NOTICE).
- **Bundled reference content** under `skills/*/references/`: distilled from the IBM Carbon Design System and IBM Design Language (Apache-2.0) and from WCAG 2.2 (© W3C, W3C Document Licence). See [`NOTICE`](NOTICE) for attribution. IBM, the IBM logo, Carbon, and IBM Plex are trademarks of International Business Machines Corporation; this plugin is not affiliated with or endorsed by IBM.
