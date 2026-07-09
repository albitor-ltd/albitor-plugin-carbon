Source: IBM Carbon Design System (https://carbondesignsystem.com/developing/) and IBM Design Language. Apache-2.0. Distilled reference — verify against the live source for current detail.

# Carbon Frontend conventions: how to actually build it

Carbon ships several packages so you can build with the framework you already use. This file covers choosing an implementation, installing it, theming, initialising behaviour, and consuming Carbon from non-React stacks.

## The packages (pick your implementation)

| Package | What it is | Use when |
| --- | --- | --- |
| **`@carbon/react`** | The React component library (canonical, most complete) | You're on React — the default choice |
| **`@carbon/web-components`** | Framework-agnostic Web Components (`cds-*` custom elements) | Non-React or framework-agnostic (Angular, Vue, Svelte, plain HTML, micro-frontends) |
| **`@carbon/styles`** | The Sass styles + design tokens (no components) | You want Carbon's look/tokens with your own or class-based markup |
| **`@carbon/elements`** | Umbrella for the design assets: `@carbon/colors`, `@carbon/type`, `@carbon/grid`, `@carbon/layout`, `@carbon/motion`, `@carbon/themes`, `@carbon/icons` | You need the tokens/assets directly |
| **`@carbon/icons-react`** / **`@carbon/icons`** | Icon components / SVGs | Icons in React / any stack |
| **`@carbon/ibm-products`** | Higher-level patterns for **IBM products** | IBM-branded products only (see the brand table in SKILL.md) |

Community ports exist for other frameworks (`carbon-components-svelte`, `carbon-components-vue`, `carbon-components-angular`); they track core Carbon but may lag releases — treat the official React/Web Components as the source of truth.

## Installing (React)

```bash
npm install @carbon/react
```

Import components and the styles:

```jsx
import { Button, TextInput, DataTable } from '@carbon/react';
// Styles (Sass): import Carbon's styles once in your entry stylesheet
```

```scss
// app.scss — bring in Carbon styles and set the theme
@use '@carbon/react/scss/theme' with ($theme: 'g10');
@use '@carbon/react';
```

Icons:

```jsx
import { Add, TrashCan } from '@carbon/icons-react';
<Button renderIcon={Add}>Create</Button>
```

## Theming

- Choose a theme (`white` / `g10` / `g90` / `g100`) globally in Sass, or apply one to a subtree with the `Theme` component:

  ```jsx
  import { Theme } from '@carbon/react';
  <Theme theme="g100"><Header>…</Header></Theme>   // dark header on a light page
  ```

- Use **layer tokens** and the `Layer` component for nested surfaces so they stay legible in every theme:

  ```jsx
  import { Layer } from '@carbon/react';
  <Layer>            {/* $layer-01 */}
    <Tile>…</Tile>
    <Layer>          {/* $layer-02 — a card inside a card */}
      <Tile>…</Tile>
    </Layer>
  </Layer>
  ```

- Consume tokens in Sass via the token functions/variables (`$text-primary`, `$layer-01`, `spacing.$spacing-05`) — never hardcode hex/px.

## Behaviour and JavaScript

Carbon components manage their own behaviour (focus trapping in `Modal`, listbox keyboard handling in `Dropdown`/`ComboBox`, menu cycling in `OverflowMenu`, live-region announcements in `InlineLoading`/notifications). You don't wire this up by hand:

- **React (`@carbon/react`):** it's all in the components — pass props and controlled state. There is no separate `init` step.
- **Web Components (`@carbon/web-components`):** import the component definition; the custom element self-registers and manages its own behaviour once it's in the DOM. Use `cds-*` tags and set attributes/properties.

```html
<script type="module">
  import '@carbon/web-components/es/components/button/index.js';
</script>
<cds-button kind="primary">Create</cds-button>
```

## Accessibility comes with correct usage

Carbon's accessibility is built into the components, but it's **not automatic** — you keep it by using them correctly:

- Give every field a `labelText`; never a placeholder-as-label.
- Give icon-only buttons an accessible name (`iconDescription` / `IconButton label` / `aria-label`).
- Keep `DataTable`'s generated `scope`/selection ARIA — don't replace it with a raw `<table>`.
- Don't strip `aria-*`, roles, or focus styles; don't override tokens in ways that break contrast in dark themes.
- Verify in **every theme you ship** — a contrast pass in White does not cover g100.

Pair with the `carbon-accessibility` skill for the WCAG 2.2 AA criteria and testing method.

## Progressive enhancement and SSR

- Carbon works with server-side rendering (Next.js, Remix, and SSR for the Web Components). Prefer SSR/real navigation for content-heavy or transactional flows so the page works before hydration.
- Avoid making core functionality JS-only where a server-rendered equivalent is feasible; validate on the server as well as the client.

## Consuming Carbon from Vue / Svelte / Angular / plain HTML

Carbon's contract is its **markup structure + classes/attributes + tokens + behaviour** — not React. To use it elsewhere:

1. **Prefer `@carbon/web-components`.** The `cds-*` custom elements work in any framework (or none): import the component's module and use the tag. This gives you Carbon's real behaviour and accessibility without a React dependency.
2. **Or use a community port** (`carbon-components-svelte`, `carbon-components-vue`, `carbon-components-angular`) — idiomatic components for that framework; watch for version lag against core Carbon.
3. **Or class-based `@carbon/styles`** — apply Carbon's CSS classes to your own markup when you can't run components. You then hand-maintain the structure, ARIA, and any JS behaviour (focus trapping, listbox keys) — the highest-maintenance option; keep it in sync when Carbon updates.
4. **Always** import the Carbon styles/tokens so classes and theming resolve, self-host IBM Plex and the icons, and preserve the accessibility affordances (labels, ARIA, focus, `scope`).

## Versioning caveat

Carbon moves fast and had a significant **v10 → v11** shift (token renames, package moves to the `@carbon/*` scope, `@carbon/react` replacing `carbon-components-react`). Confirm the exact component API, prop names, and token names against the live docs for the version you're on — <https://carbondesignsystem.com/>.
