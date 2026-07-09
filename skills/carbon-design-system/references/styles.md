Source: IBM Carbon Design System (https://carbondesignsystem.com/) and IBM Design Language. Apache-2.0. Distilled reference — verify against the live source for current detail (token names and values changed between Carbon v10 and v11).

# IBM Carbon Design System styles

Covers colour and theme tokens, the four themes, IBM Plex typography, the 2x Grid, the spacing scale, motion, and focus states.

Golden rule: **consume everything through tokens, never hardcoded values.** Colour comes from theme tokens, space from the spacing scale, type from the type set. Hardcoding hex or px breaks theming (dark mode, layering) and drifts from the system when Carbon updates. Do not assign new meanings to colours, do not recolour `Button` kinds, and do not override token values.

## Colour and theming

### Themes
Carbon ships **four themes**, two light and two dark:

| Theme | Name | Page background | Typical use |
| --- | --- | --- | --- |
| **White** | `white` | `#ffffff` | Default light |
| **Gray 10** | `g10` | `#f4f4f4` | Light, slightly softer |
| **Gray 90** | `g90` | `#262626` | Dark |
| **Gray 100** | `g100` | `#161616` | Darkest |

You pick a theme (or offer a toggle) and the tokens resolve to that theme's values. Apply a theme to a subtree with the `Theme` component / `cds-theme`, or via the Sass theme mixin. **Never** hardcode a theme's hex — a value that looks right in White will be invisible in g100.

### Token layers
Carbon uses **layering tokens** so nested surfaces stay legible in every theme. Rather than picking greys by hand, wrap nested surfaces in `Layer` and use the layer tokens:
- `$background` — the page background.
- `$layer-01` / `$layer-02` / `$layer-03` — progressively raised surfaces (a card on the page, a field in the card). `Layer` steps these automatically.
- `$field-01` / `$field-02` — form field backgrounds per layer.
- `$border-subtle-*`, `$border-strong-*` — borders per layer.

### Core semantic tokens (resolve per theme — use the token, not the hex)
| Role | Token | White-theme value (reference only) |
| --- | --- | --- |
| Primary text | `$text-primary` | `#161616` |
| Secondary text | `$text-secondary` | `#525252` |
| Helper/placeholder text | `$text-helper` / `$text-placeholder` | `#6f6f6f` / `#a8a8a8` |
| Text on colour | `$text-on-color` | `#ffffff` |
| Link | `$link-primary` | `#0f62fe` |
| Interactive / primary action | `$interactive` / `$button-primary` | `#0f62fe` |
| Focus ring | `$focus` | `#0f62fe` |
| Error | `$support-error` | `#da1e28` |
| Success | `$support-success` | `#24a148` |
| Warning | `$support-warning` | `#f1c21b` |
| Info | `$support-info` | `#0043ce` |
| Danger button | `$button-danger-primary` | `#da1e28` |
| Layer background | `$layer-01` | `#f4f4f4` |
| Subtle border | `$border-subtle-01` | `#e0e0e0` |

The full palette is the **IBM Design Language colour palette** — families Blue, Cyan, Teal, Green, Gray, Cool/Warm Gray, Purple, Magenta, Red, Orange, Yellow — each with 10 steps (10–100). Semantic tokens map onto these steps per theme.

### Contrast
Meet WCAG 2.2 AA 1.4.3: text ≥ 4.5:1 (≥ 3:1 for large text ≥ 18.66px bold / 24px regular), and 1.4.11: UI components and meaningful graphics ≥ 3:1. Carbon's tokens are designed to pass in each theme — but you must verify contrast **in every theme you ship**, especially for any custom colour. Never use colour as the only signal (1.4.1) — pair with text/icons.

## Typography — IBM Plex

**IBM Plex** is Carbon's typeface: **Plex Sans** (UI/body), **Plex Serif**, **Plex Mono** (code), and **Plex Sans Condensed**. Unlike some brand fonts, **IBM Plex is open source (SIL Open Font License) and free to use anywhere** — including non-IBM products — so you keep the full type system off-brand. Self-host it or pull it from `@ibm/plex`; don't substitute a different font unless you have a reason.

### Type sets and tokens
Carbon defines two type sets applied via tokens/mixins, not raw font-size:
- **Productive** — dense, functional UI text (forms, tables, labels). Tokens: `body-compact-01/02`, `label-01/02`, `helper-text-01/02`, `heading-compact-01/02`, `code-01/02`.
- **Expressive** — larger, editorial headings for marketing/landing surfaces. Tokens: `body-01/02`, `heading-01`…`heading-07`, `fluid-heading-*`, `display-01`…`display-04`.

Apply with the type token / Sass mixin (`@include type-style('heading-03')`) or the utility classes — not hardcoded px. Sizes are in `rem` for zoom/magnification, and the **fluid** heading tokens scale with the viewport. Body default is `body-01`/`body-compact-01` (14px). Keep a single logical `<h1>` and correct heading order — `Section`/`Heading` can manage levels automatically.

## Layout — the 2x Grid

Carbon's layout is the **2x Grid**: a **16-column** responsive grid built on a base-2 rhythm, with a fixed set of breakpoints and gutters.

### Breakpoints
| Name | Min width | Columns |
| --- | --- | --- |
| `sm` | 320px | 4 |
| `md` | 672px | 8 |
| `lg` | 1056px | 16 |
| `xlg` | 1312px | 16 |
| `max` | 1584px | 16 |

### Grid usage
- `Grid` + `Column` (CSS Grid) or `FlexGrid` (flexbox) for layout — set spans per breakpoint (`<Column sm={4} md={4} lg={8}>`).
- Gutters and margins come from the grid; don't add ad-hoc margins to fake columns.
- Modes: **wide** (default 32px gutters), **narrow**, **condensed** (dense, 1px gutters — good for data-heavy layouts), and **full-width**.
- Nest columns for sub-grids; keep content on the grid rather than absolute positioning.

## Spacing

A single **spacing scale** of tokens, used for margin, padding, and gaps — never hardcode px:

| Token | Value |
| --- | --- |
| `$spacing-01` | 2px |
| `$spacing-02` | 4px |
| `$spacing-03` | 8px |
| `$spacing-04` | 12px |
| `$spacing-05` | 16px |
| `$spacing-06` | 24px |
| `$spacing-07` | 32px |
| `$spacing-08` | 40px |
| `$spacing-09` | 48px |
| `$spacing-10` | 64px |
| `$spacing-11` | 80px |
| `$spacing-12` | 96px |
| `$spacing-13` | 160px |

There are also **layout tokens** (`$size-*` / container sizes) for larger structural spacing. Use `Stack` (React) with a `gap` token to space children consistently instead of margins.

## Motion

Carbon defines motion tokens so animation is consistent and purposeful:
- **Easing:** `productive` (fast, functional — most UI) and `expressive` (more character — larger/hero moments), each with `standard`/`entrance`/`exit` curves.
- **Duration tokens:** `$duration-fast-01/02`, `$duration-moderate-01/02`, `$duration-slow-01/02` (roughly 70ms → 700ms).
- Respect `prefers-reduced-motion`: reduce or remove non-essential motion (2.3.3 is AAA, but reduced-motion support is expected). Nothing may flash more than 3×/sec (2.3.1).

## Focus and interaction states

- **Focus:** Carbon draws a visible focus ring using the `$focus` token (a 2px outline/border) on every interactive element. Never remove focus (`outline: none`) without an equally visible replacement — the focus indicator is required for 2.4.7, and must not be obscured by sticky `Header`/`SideNav` (2.4.11). Rely on the components' built-in focus styling.
- **States:** components define `hover`, `active`, `focus`, `disabled`, `read-only`, `selected` and `invalid` states via tokens — use the props/states, don't restyle them.
- **Target size:** interactive targets should meet 24×24px minimum (2.5.8); Carbon's default control sizes clear this — don't shrink them below it for density.

## Icons and images

- **Carbon icons** (`@carbon/icons`, `@carbon/icons-react`) and **pictograms** are Apache-2.0. Use them at the standard sizes (16/20/24/32). An icon-only control needs an accessible name (`iconDescription`/`aria-label`). Decorative icons should be hidden from assistive tech (`aria-hidden`).
- Give meaningful images real `alt` text; decorative images get `alt=""`. Prefer real text over images of text (1.4.5). Keep images responsive and don't embed essential info only in an image.
