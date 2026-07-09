---
description: Open or generate a static Carbon kitchen-sink preview page to see the design system rendered.
argument-hint: "[optional: components or a screen to focus the preview on]"
---

Show the user the IBM Carbon Design System rendered as a self-contained preview. Focus, if given: **$ARGUMENTS**

This plugin ships a static kitchen-sink at `preview/index.html` — a single self-contained HTML file (no build step, no network) that renders Carbon-styled core components (buttons, text inputs, dropdown, data table, tabs, tiles, structured list, notifications, tags, modal, etc.) in the browser. It is the baseline used by the create/describe-and-build flow, the review baseline, and the handover pack.

Do the following:

1. Locate the bundled preview at `${CLAUDE_PLUGIN_ROOT}/preview/index.html`. Tell the user its path and that it opens standalone from `file://` (e.g. `open preview/index.html` on macOS, or drag it into a browser). Do **not** deploy it or start a server unless asked.
2. If the user wants a preview **tailored to their product** (specific components or a specific screen from `$ARGUMENTS`):
   - Load the `carbon-design-system` skill; read `references/components.md`, `patterns.md`, and `styles.md`.
   - Generate a new self-contained static page modelled on the bundled `preview/index.html`: hand-rendered Carbon-styled markup with **inline** CSS driven by Carbon tokens (spacing scale, type set, and the g10/g100 theme colours) — no external stylesheet, font, script, or image, so it opens offline from `file://`.
   - Assemble it from real Carbon components and patterns for the requested screen; keep the token discipline and accessibility affordances (labels, `scope` on table headers, focus styles, `lang` on `<html>`).
3. Remind the user this is a **static visual reference**, not the production build — production should consume `@carbon/react` or `@carbon/web-components` with the real `@carbon/styles` (see `references/frontend-conventions.md`), which brings live theming, JS behaviour, and the maintained accessibility implementation.

If the user only wants to view what ships, step 1 is the whole answer — point them at `preview/index.html`.
