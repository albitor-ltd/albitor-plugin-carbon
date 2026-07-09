Source: IBM Carbon Design System (https://carbondesignsystem.com/) and IBM Design Language. Apache-2.0. Distilled reference — verify against the live source for current detail (component APIs change across major versions; Carbon v11 renamed many tokens and props from v10).

# IBM Carbon Design System components

This is the **Carbon component inventory** — the canonical list of vetted, accessible, themeable components. It doubles as the conformance list for the "0 ad-hoc components" gate: if a need is met by a component here, use it rather than hand-rolling markup.

Each component ships in **React** (`@carbon/react`, e.g. `<Button>`) and as a **Web Component** (`@carbon/web-components`, the `cds-*` custom elements, e.g. `<cds-button>`), backed by the same styles (`@carbon/styles`) and the same accessibility work. Names below give the React component; the Web Component is the kebab-cased `cds-*` equivalent unless noted.

General rules that apply to nearly all components:

- Use the component's own props/classes and **theme tokens**; do not restyle (no recolouring `Button` kinds, no overriding token values, no repurposing the `support-error` red for emphasis).
- Form components must have a programmatically associated label — `labelText` (React) or a wired `<label for>` (markup). Never rely on placeholder text as the label.
- Interactive components manage their own keyboard behaviour and ARIA; keep the wiring intact and don't strip `aria-*`/roles.
- Error states use the field's `invalid` + `invalidText` props (and a form-level summary for multi-field forms).
- Colour is resolved by the active **theme** (White / g10 / g90 / g100) — build inside a `Theme`/`Layer` context and use `$layer` tokens so components work in dark themes.

## Quick reference table

| Component | React | Has JS behaviour? | One-line purpose |
| --- | --- | --- | --- |
| Accordion | `Accordion` | Yes | Show/hide vertically stacked sections |
| Breadcrumb | `Breadcrumb` | No | Show location in a hierarchy |
| Button | `Button` | Yes (ripple/disabled) | Trigger an action; kinds: primary/secondary/tertiary/ghost/danger |
| Icon button | `IconButton` | Yes (tooltip) | Icon-only action with an accessible `label` |
| Button set | `ButtonSet` | No | Group related buttons |
| Checkbox | `Checkbox` | Yes | Select zero or more options |
| Code snippet | `CodeSnippet` | Yes (copy) | Show/copy code (inline, single, multiline) |
| Combo box | `ComboBox` | Yes | Filterable single-select from a long list |
| Combo button | `ComboButton` | Yes | Primary action + menu of related actions |
| Contained list | `ContainedList` | No | List of items within a bordered container |
| Content switcher | `ContentSwitcher` | Yes | Toggle between related views (segmented control) |
| Data table | `DataTable` | Yes | Sortable/selectable/expandable/paginated tabular data |
| Date picker | `DatePicker` | Yes (calendar) | Pick a single date or range |
| Dropdown | `Dropdown` | Yes | Single-select from a list (no filtering) |
| File uploader | `FileUploader` | Yes | Upload one or more files (button or drop zone) |
| Form | `Form` / `FormGroup` / `Stack` | No | Group and space form controls |
| Fluid form | `FluidForm` | No | Denser form style with label inside the field |
| Grid | `Grid` / `Column` | No | 2x responsive layout grid (16 columns) |
| UI Shell — header | `Header` (+ `HeaderNavigation`, `HeaderMenu`, `HeaderGlobalBar`, `HeaderMenuButton`) | Yes | App top bar and product navigation |
| UI Shell — side nav | `SideNav` (+ `SideNavItems`, `SideNavLink`, `SideNavMenu`) | Yes | Collapsible left navigation |
| UI Shell — panels | `HeaderPanel` / `SwitcherHeaderPanel` | Yes | Slide-out header panels (switcher, notifications) |
| Inline loading | `InlineLoading` | Yes (live region) | Inline progress + success/error status |
| Link | `Link` | No | Navigate to another page/resource |
| Loading | `Loading` | Yes | Full/overlay spinner for indeterminate waits |
| Menu / Menu button | `Menu` / `MenuButton` / `MenuItem` | Yes | Menu of actions triggered by a button |
| Modal | `Modal` / `ComposedModal` | Yes (focus trap) | Dialog for a focused task or confirmation |
| Multiselect | `MultiSelect` (+ `FilterableMultiSelect`) | Yes | Select several options from a list |
| Notification | `ToastNotification` / `InlineNotification` / `ActionableNotification` | Yes (live region) | Communicate status; toast/inline/actionable |
| Number input | `NumberInput` | Yes (steppers) | Numeric entry with up/down steppers |
| Overflow menu | `OverflowMenu` (+ `OverflowMenuItem`) | Yes | "…" menu of secondary actions |
| Pagination | `Pagination` / `PaginationNav` | Yes | Page through long lists/tables |
| Popover | `Popover` | Yes | Anchored container of interactive content |
| Progress bar | `ProgressBar` | Yes (live region) | Determinate/indeterminate progress |
| Progress indicator | `ProgressIndicator` (+ `ProgressStep`) | Yes | Multi-step process status (stepper) |
| Radio button | `RadioButton` / `RadioButtonGroup` | Yes | Select exactly one option |
| Search | `Search` (+ `ExpandableSearch`) | Yes | Filter/find within content |
| Select | `Select` / `SelectItem` | No | Native styled dropdown |
| Slider | `Slider` | Yes | Choose a value along a range |
| Structured list | `StructuredList` | No (selectable variant Yes) | Read-only rows of related data |
| Tabs | `Tabs` / `TabList` / `Tab` / `TabPanel` | Yes | Switch between equivalent sections |
| Tag | `Tag` (+ `DismissibleTag`, `SelectableTag`, `OperationalTag`) | Some (dismiss/select) | Categorise, label, or filter with a keyword |
| Text input | `TextInput` | No | Single-line text field |
| Password input | `TextInput.PasswordInput` | Yes (show/hide) | Masked field with a visibility toggle |
| Text area | `TextArea` | No | Multi-line text field |
| Tile | `Tile` (+ `ClickableTile`, `ExpandableTile`, `SelectableTile`, `RadioTile`, `TileGroup`) | Some | Group content; optionally clickable/selectable |
| Time picker | `TimePicker` (+ `TimePickerSelect`) | No | Enter a time (+ timezone/period selects) |
| Toggle | `Toggle` | Yes | Immediate on/off switch |
| Tooltip | `Tooltip` / `Toggletip` / `DefinitionTooltip` | Yes | Contextual help/definition on hover/focus |
| Tree view | `TreeView` (+ `TreeNode`) | Yes | Hierarchical, expandable list |
| Lists | `UnorderedList` / `OrderedList` / `ListItem` | No | Ordered/unordered content lists |
| Layer | `Layer` | No | Step the background token for nested surfaces |
| Theme | `Theme` | No | Apply a Carbon theme to a subtree |
| AI label / Slug | `AILabel` (formerly `Slug`) | Yes | Mark AI-generated content, with an explainer |

## Actions

### Button — `Button`
The primary action control. **Kinds** carry meaning and hierarchy: `primary` (main action, one per view), `secondary`, `tertiary`, `ghost` (lowest emphasis), and `danger` / `danger--tertiary` / `danger--ghost` (destructive). Don't recolour a kind to fake another — use the right kind. Sizes: `sm`/`md`/`lg`/`xl`. Can carry a `renderIcon`. For an **icon-only** button, set `hasIconOnly` **and** `iconDescription` (its accessible name and tooltip) — a bare icon with no name fails 4.1.2/1.1.1.

### Icon button — `IconButton`
An icon-only action with a required `label` prop that is both the tooltip and the accessible name. Prefer this (or `Button hasIconOnly`) over a bare clickable icon.

### Button set / Combo button — `ButtonSet` / `ComboButton`
`ButtonSet` groups related buttons with correct spacing. `ComboButton` is a primary action plus a menu of related secondary actions (a split button); the menu is keyboard-operable.

### Menu button / Overflow menu — `MenuButton` / `OverflowMenu`
`MenuButton` opens a `Menu` of actions from a labelled button. `OverflowMenu` is the "…" affordance for secondary/row-level actions (common in `DataTable` rows and toolbars). Both trap and cycle focus within the open menu and close on Esc; keep the `aria-label` on an icon-triggered overflow menu.

## Inputs and forms

All fields sit in a `Form`/`FormGroup`/`Stack` for consistent spacing. Give every field a `labelText`; add `helperText` for format hints and `invalid` + `invalidText` on error. Use `FluidForm` for dense forms where the label sits inside the field.

### Text input — `TextInput`
Single-line text. Set `type`, `autoComplete`, `inputMode` appropriately. Provide `labelText` and `helperText`. Read-only and disabled states are props, not restyles.

### Password input — `TextInput.PasswordInput`
Masked field with a built-in show/hide toggle and accessible status. Set `autoComplete="current-password"`/`"new-password"`. Don't disable paste (WCAG 3.3.8).

### Text area — `TextArea`
Multi-line text. Set `rows`. For a live character count, add a counter and an ARIA live region.

### Number input — `NumberInput`
Numeric entry with up/down steppers, `min`/`max`/`step`. Steppers must not be the only way to reach a value — typing must work too.

### Select — `Select` / `SelectItem`
A native `<select>` styled by Carbon. Simple and robust, but for long lists prefer `ComboBox` (filterable) and for a handful of options `RadioButtonGroup` is often more accessible. Always give a `labelText` and a sensible first option.

### Dropdown — `Dropdown`
Single-select from a list, **without** filtering (a styled listbox, not a native select). Use for short-to-medium option sets where custom item rendering helps. For filtering a long list, use `ComboBox`.

### Combo box — `ComboBox`
Single-select with **type-to-filter**. Use for long option lists (countries, users). Fully keyboard-operable listbox with ARIA; keep the `titleText`/label.

### Multiselect — `MultiSelect` / `FilterableMultiSelect`
Select several options from a list; shows a count and supports "select all". `FilterableMultiSelect` adds type-to-filter for long lists.

### Radio button — `RadioButton` / `RadioButtonGroup`
Choose exactly one option from a small visible set. Wrap in `RadioButtonGroup` with a group `legend`. Prefer over a `Select` when there are only a few options and they should all be visible. For yes/no use two radios, not a single checkbox.

### Checkbox — `Checkbox`
Select zero or more options, or a single binary consent ("I agree"). Group related checkboxes under a `FormGroup` `legend`. Support an indeterminate state for "some selected".

### Toggle — `Toggle`
An **immediate** on/off switch (applies instantly, no submit). Use for settings that take effect at once; use a checkbox where the choice is submitted with a form. Provide `labelText` and on/off text.

### Slider — `Slider`
Choose a value (or range) along a track, with a paired number input for precise entry. Keyboard-operable; keep the paired input so exact values are reachable.

### Date picker / Time picker — `DatePicker` / `TimePicker`
`DatePicker` (`simple`/`single`/`range`) provides a calendar with keyboard support; give each input a label and a format hint. `TimePicker` is a text time entry with optional `TimePickerSelect` for AM/PM and timezone. For a memorable date you may prefer three plain inputs, but Carbon's calendar is fine for lookups/scheduling.

### File uploader — `FileUploader`
Upload one or more files as a button (`FileUploader`) or a drop zone (`FileUploaderDropContainer`). State accepted types and max size; validate server-side and surface errors on each file item.

### Search — `Search` / `ExpandableSearch`
Filter or find within content/tables. `ExpandableSearch` collapses to an icon until activated. Provide a `labelText`; announce result counts via a live region.

## Data display

### Data table — `DataTable`
The centre of gravity for enterprise UIs. A composable table with sorting, row selection (checkbox / radio), **batch actions** (`TableBatchActions`), a **toolbar** (`TableToolbar` with search, filter, overflow), row **expansion**, sticky header, `size` density, and pagination (pair with `Pagination`). It wires up `scope` on header cells, keyboard interaction, and selection ARIA — use it instead of a hand-rolled `<table>` for any interactive data. A plain semantic `<table>` is acceptable only for small, static, non-interactive data.

### Structured list — `StructuredList`
Read-only rows of related data (key facts, plan comparison). A selectable variant exists (radio-style). Use for display, not for heavy interactive data (that's `DataTable`).

### Contained list — `ContainedList`
A list of items inside a bordered container, optionally with actions per item. Good for compact side panels and "recent items".

### Tile — `Tile` and variants
`Tile` groups content in a surface. `ClickableTile` (whole tile is a link/button), `SelectableTile` and `RadioTile` (selection cards, grouped by `TileGroup`), and `ExpandableTile` (reveals more). Use tiles for dashboards and choose-one-card layouts; keep the accessible role right (link vs button vs input).

### Lists — `UnorderedList` / `OrderedList` / `ListItem`
Styled semantic lists. Use real list markup for enumerations.

### Code snippet — `CodeSnippet`
Show code as `inline`, `single`-line, or `multi`-line with a copy button and accessible copy feedback. Use for commands, config, and API examples.

### Tree view — `TreeView` / `TreeNode`
Hierarchical, expandable list (file trees, nested navigation). Full keyboard tree interaction and ARIA `tree`/`treeitem` roles — don't rebuild this by hand.

## Navigation and UI Shell

### UI Shell header — `Header` and family
The product top bar: `Header` with `HeaderName` (product name), `HeaderNavigation` + `HeaderMenuItem`/`HeaderMenu` (primary nav), `HeaderGlobalBar` with `HeaderGlobalAction` (icons: search, notifications, account), and `HeaderMenuButton` to toggle the side nav on small screens. Use it instead of a bespoke top bar. Do **not** place the IBM logo/wordmark here unless the product is IBM-branded.

### UI Shell side nav — `SideNav`
Collapsible left navigation: `SideNavItems` with `SideNavLink` and nested `SideNavMenu`/`SideNavMenuItem`. Pairs with the header menu button. Keyboard-operable and announces expanded/collapsed state.

### UI Shell panels — `HeaderPanel` / `SwitcherHeaderPanel`
Slide-out right-hand panels from the global bar (product switcher, notifications). Manage focus into and out of the panel.

### Breadcrumb — `Breadcrumb`
Shows where the page sits in a hierarchy and lets users move up levels. Use on hierarchical/browsable structures; the current page is not a link.

### Tabs — `Tabs` / `TabList` / `Tab` / `TabPanel`
Switch between equivalent sections of content. `contained` and line variants. Follows the ARIA tabs pattern (arrow-key navigation, `tabpanel` association) — keep panels associated to tabs.

### Content switcher — `ContentSwitcher`
A segmented control to toggle between related views/modes (e.g. "Chart | Table"). Single-select; for many options or filtering use tabs or a dropdown instead.

### Pagination — `Pagination` / `PaginationNav`
`Pagination` pages through table/list data with a page-size select and range text. `PaginationNav` is numbered previous/next navigation. Keep the controls labelled.

### Progress indicator — `ProgressIndicator` / `ProgressStep`
A horizontal or vertical **stepper** showing where the user is in a multi-step process (complete / current / incomplete / invalid). Status is conveyed by text + icon, not colour alone.

### Link — `Link`
Navigate to a page or resource. Use a real `<a href>`; `inline` and `visited` variants exist, plus an icon slot for "opens in new tab" / external. Don't use a `Button` for navigation or a `Link` for an in-page action.

## Notifications and status

Carbon distinguishes **three** notification types — pick by urgency and whether an action is required:

### Inline notification — `InlineNotification`
Contextual message tied to a section or form (info/success/warning/error). Non-modal, stays until dismissed or the state changes. Use for validation summaries and page-level status.

### Toast notification — `ToastNotification`
Transient, corner-of-screen confirmation of a background result (e.g. "Report exported"). Auto-dismiss with care; ensure it's announced via a live region and long enough to read.

### Actionable notification — `ActionableNotification`
An inline or toast notification that **includes an action** (button/link) and takes focus like an alert dialog when it needs a response. Use when the user must do something.

### Loading / Inline loading — `Loading` / `InlineLoading`
`Loading` is a full-page/overlay spinner for indeterminate waits. `InlineLoading` shows inline "active → finished/error" status next to the thing loading, with an accessible live-region announcement (4.1.3). Prefer inline status for in-context operations.

### Progress bar — `ProgressBar`
Determinate or indeterminate progress with a label and status; announces value changes. Use for known-duration operations (uploads, imports).

### Tag — `Tag`
A short keyword label to categorise or show status; colour variants exist but **text/icon must carry the meaning**, not colour alone. `DismissibleTag` (removable filter), `SelectableTag` (toggle filter), `OperationalTag` (opens more) support interactive filtering. Keep tag text short.

### Tooltip / Toggletip / Definition tooltip — `Tooltip` / `Toggletip` / `DefinitionTooltip`
`Tooltip` shows a short label on hover/focus (non-interactive content). `Toggletip` is click-triggered and can hold interactive content. `DefinitionTooltip` explains a term inline. Content must be dismissible, hoverable and persistent (1.4.13) — the components handle this; don't replace them with title attributes.

### AI label — `AILabel` (formerly `Slug`)
Marks AI-generated or AI-assisted content and opens an explainer (what the AI did, confidence, sources). Use wherever generated content is shown, so it's transparent to the user.

## Containers, disclosure and layout

### Modal — `Modal` / `ComposedModal`
A dialog for a focused task or confirmation. `Modal` is the simple prop-driven form; `ComposedModal` (`ModalHeader`/`ModalBody`/`ModalFooter`) is composable for richer content. Both **trap focus** while open, return focus to the trigger on close, close on Esc, and label the dialog. Use `danger` for destructive confirmations. Don't stack modals or put long forms in a small modal.

### Popover — `Popover`
An anchored floating container for interactive content (filters, small forms) that isn't a full modal. Manage focus and dismissal (Esc / click-away).

### Accordion — `Accordion` / `AccordionItem`
Vertically stacked, independently expandable sections. Use for long pages of largely independent content the user won't all need. Don't hide content users must read in sequence.

### Tile group / Selectable tiles — `TileGroup`
Card-style choose-one/choose-many selection built from `RadioTile`/`SelectableTile`. Keep the underlying input semantics.

### Grid and layout — `Grid` / `Column` / `FlexGrid`
The **2x Grid**: a 16-column responsive grid with Carbon's breakpoints and gutters. Use `Grid`/`Column` (CSS Grid) or `FlexGrid` (flexbox) for page layout instead of ad-hoc margins. See `references/styles.md`.

### Layer / Theme — `Layer` / `Theme`
`Layer` steps the background token up one level so nested surfaces (a card on a page, a field in a card) stay legible in every theme — use it instead of hardcoding a slightly different grey. `Theme` applies a named theme (White/g10/g90/g100) to a subtree, e.g. a dark header on a light page.

### Heading / Section — `Heading` / `Section`
`Section` + `Heading` produce correctly-levelled headings automatically as you nest, so heading order stays valid without hand-counting `<h1>`–`<h6>`.
