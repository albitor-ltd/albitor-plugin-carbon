Source: IBM Carbon Design System (https://carbondesignsystem.com/patterns/) and IBM Design Language. Apache-2.0. Distilled reference — verify against the live source for current detail.

# IBM Carbon Design System patterns

Patterns are reusable solutions to recurring enterprise design problems, built from components. Carbon documents them under **interaction** patterns (dialogs, notifications, loading, disclosure), **content** patterns (forms, tables, empty/error states), and **navigation** patterns (the UI Shell). Below they are organised as layout, form, data, feedback, and navigation patterns — the building blocks of dashboards, admin consoles, and B2B tools.

Overarching rules:
- **Use a component/pattern that exists** before inventing markup.
- **Theme with tokens** so every pattern works across the four themes (White / g10 / g90 / g100) and in nested layers.
- **Progressive disclosure:** show the most important data first; reveal detail on demand (expansion, side panels, modals).
- **Density with restraint:** enterprise UIs are dense, but keep whitespace from the spacing scale, clear hierarchy, and never sacrifice target size (24×24px min) or contrast for density.
- **State completeness:** every data view needs designed **empty, loading, error, and populated** states — don't ship only the happy path.

## Layout patterns

### Dashboards
A dashboard is a scannable overview built on the **2x Grid** from tiles, data tables, and (optional) visualisations. Structure:
- App chrome from the **UI Shell** (`Header` + `SideNav`), content in a `Grid`.
- A row of summary **tiles** (KPIs / status) at the top, then denser tables/lists below.
- Group related metrics; lead with the most important. Use `Layer` so cards on the page background stay legible in dark themes.
- Do: keep a consistent column rhythm; make tiles clickable through to detail; show timestamps/refresh state. Don't: cram unrelated widgets; rely on colour alone for status (pair with text/icons/tags).

### Page header and app frame
Every screen sits inside the UI Shell: a `Header` (product name, primary nav, global actions) and optionally a collapsible `SideNav`. Keep the frame consistent across the product (3.2.3 Consistent Navigation). Put a page title (`Heading`) and any page-level actions/breadcrumb at the top of the content area.

### Two-panel / master-detail
List or table on the left/top, detail on the right/bottom (or in a side panel/modal). Selecting a row updates the detail. Preserve the user's place in the list when they return from detail.

## Form patterns

### Form structure
Group controls in a `Form` with `FormGroup`/`Stack` for consistent spacing. One clear task per form; logical grouping with `FormGroup` legends. Every field has a `labelText` and, where useful, `helperText`. A single primary `Button` for submit, secondary/ghost for cancel. Use `FluidForm` for dense, data-entry-heavy forms.
- Do: label every field; state format expectations in helper text; validate server-side as well as client-side; keep entered data on error.
- Don't: use placeholder text as a label; auto-submit on change; scatter unrelated questions across one giant form.

### Validation and errors
Validate on submit (and optionally on blur). On error:
- Set `invalid` + `invalidText` on each failing field (text, not colour alone — 1.4.1/3.3.1).
- Surface a **form-level summary** with an `InlineNotification` (error) at the top listing what went wrong, focused/announced so screen-reader and keyboard users find it (4.1.3).
- Write errors in plain language that say what's wrong and how to fix it (3.3.3). Don't clear the form.

### Long / multi-step forms
For a process spanning several steps, use the `ProgressIndicator` stepper to show position, let users move back without losing data (3.3.7 Redundant Entry — carry data forward), and add a review step before a legal/financial/data submission (3.3.4).

## Data patterns

### Data tables
The core enterprise pattern. Use `DataTable` with:
- A **toolbar** (`TableToolbar`) for table-wide search, filter, and primary actions.
- **Sorting** on sortable columns; **selection** (checkbox) with **batch actions** (`TableBatchActions`) for operating on many rows; **row expansion** for detail; **pagination** (`Pagination`) for large sets.
- Right-align numeric columns; use consistent density (`size`); keep header cells as real `<th scope>` (DataTable does this).
- Do: paginate or virtualise large sets; make row actions reachable by keyboard (overflow menu); show an empty state when there are no rows. Don't: hand-roll a `<table>` for interactive data; hide critical actions behind hover only.

### Filtering and search
Provide table/list filtering via the toolbar: `Search` for text, `Dropdown`/`MultiSelect`/`SelectableTag` for facets. Reflect active filters visibly (dismissible tags) and announce result counts.

### Empty states
When there's no data, show a designed empty state: a short heading, a sentence explaining why it's empty, and a primary action to populate it (or a link to learn more). Distinguish "no data yet" (first use) from "no results" (filter too narrow — offer to clear filters).

## Feedback patterns

### Notifications hierarchy
Choose by urgency and whether an action is needed:
- **Inline notification** — contextual, non-blocking status tied to a section/form (validation summary, page status).
- **Toast notification** — transient confirmation of a background result; announced, readable, auto-dismiss with care.
- **Actionable notification** — carries an action and takes focus when a response is required.
Reserve error styling for genuine errors; don't over-notify or users tune it out.

### Loading and progress
- **Skeleton states** (Carbon skeleton components) for initial page/table loads — show layout while data arrives.
- `InlineLoading` for in-context operations (saving a row) with an accessible active→success/error announcement.
- `Loading` overlay for blocking waits; `ProgressBar` for known-duration operations (uploads, imports).

### Dialogs and confirmation
Use `Modal`/`ComposedModal` for a focused task or a confirmation. Destructive actions use a `danger` modal that names the consequence and the object ("Delete 4 users?"). Keep focus trapped while open and return it on close. Don't use a modal for long forms or non-urgent info.

### Status indicators
Communicate state with `Tag`, status icons, `InlineLoading`, or `ProgressIndicator` — always pairing colour with text and/or an icon so status is not colour-only (1.4.1). Keep the same indicator for the same meaning across the product (3.2.4).

## Navigation patterns

### App navigation (UI Shell)
Consistent product navigation: `Header` for the top bar and primary nav, `SideNav` for section navigation, `HeaderGlobalBar` for global actions (search, notifications, account), `HeaderPanel` for slide-out switcher/notification panels. Keep the shell identical across pages (3.2.3). Use `Breadcrumb` for hierarchical location, not for linear steps.

### Disclosure
Reveal detail progressively: `Accordion` for stacked independent sections, `ExpandableTile`/row expansion for "more detail", `Popover`/`Toggletip` for contextual help, `Tabs`/`ContentSwitcher` for equivalent views. Don't hide content users always need behind a disclosure.

### Onboarding and help
Provide help consistently (3.2.6 Consistent Help): a persistent help/contact affordance in the same place on every page, contextual `Tooltip`/`DefinitionTooltip` for terms, and `AILabel` wherever AI-generated content appears so it's transparent.
