# Preview page — common comparison spec

Every Albitor design-system plugin ships a self-contained `preview/index.html`
that renders the SAME screen in its own design system, so the four previews can
be compared side by side. This file is the contract: the ordered sections, and
the exact demo content and sample data every preview must use verbatim.

Tracking issue: [#345](https://github.com/albitor-ltd/albitor/issues/345).

## Ground rules

- **Self-contained and offline.** Opens from `file://` with no build step, no
  network requests, no external fonts/scripts/CDNs. All CSS/JS inline or vendored.
- **DS-native rendering.** Each preview uses its own components, tokens, and
  look. Adapt component *names* to the DS (badge / chip / tag; card / tile /
  panel), but keep the *content* below byte-identical across all four repos.
- **Same order.** Render the sections in the numbered order below.
- The `gds` preview stays **crownless**: no Crown logo, no "GOV.UK" logotype, no
  GDS Transport typeface, no Open Government Licence / Crown-copyright text.

## Ordered sections

### 1. Page header / title bar
The DS's own header / app bar / UI-shell, with the product name **Northwind**.
Main heading: **Component preview**. Where the DS supports light/dark, keep its
theme toggle in the header.

### 2. Buttons
Primary, secondary, destructive, and a disabled button. Exact labels:
- Primary — **Save changes**
- Secondary — **Cancel**
- Destructive — **Delete account**
- Disabled — **Submitting…**

### 3. Form fields
A text input, a select, a checkbox group and a radio group, with one field in an
error / validation state.
- Text input — label **Full name**, placeholder **Ada Lovelace**
- Email input — label **Email address**, value **ada@**, **error state**, message
  (identical across all four): **Enter a valid email address, for example name@example.com**
- Select — label **Country**, options **United Kingdom**, **France**, **Germany** (United Kingdom selected)
- Checkbox group — legend **Notifications**: **Email** (checked), **SMS**, **Push**
- Radio group — legend **Plan**: **Free**, **Pro** (selected), **Enterprise**

### 4. Data table
The DS's data table with these three rows verbatim. Caption **Recent orders**;
columns **Order**, **Customer**, **Status**, **Amount** (Amount right-aligned).
Status renders as the DS's tag/badge/chip.

| Order    | Customer      | Status  | Amount     |
| -------- | ------------- | ------- | ---------- |
| ORD-1001 | Northwind Ltd | Paid    | £1,240.00  |
| ORD-1002 | Acme Co       | Pending | £530.50    |
| ORD-1003 | Globex        | Overdue | £98.00     |

Paid → success/green, Pending → neutral/amber, Overdue → error/red.

### 5. Tabs
Three tabs: **Overview**, **Activity**, **Settings**. Panel copy:
- Overview — **Overview content. Tabs switch between equivalent views of the same screen.**
- Activity — **Activity content.**
- Settings — **Settings content.**

### 6. Card / tile / panel
The DS's card / tile / panel primitive. Title **Project Atlas**, body
**A short supporting description that sits inside the card content region.**,
and an action **View details**.

### 7. Dialog / modal (static example)
A static (always-visible) example of the DS's dialog / modal surface.
Title **Delete account?**, body
**This permanently removes your account and all associated data. This action cannot be undone.**,
actions **Cancel** and **Delete account**.

### 8. Notification / alert set
Info, success, and error, in that order. Exact messages:
- Info — **A new version is available.**
- Success — **Your changes have been saved.**
- Error — **Could not connect to the server.**

### 9. Empty state
Heading **No orders yet**, body
**When you create your first order, it will appear here.**, and a primary action
**Create order**.

### 10. Tags / badges / chips
Four, with these labels and semantics:
- **Active** — info / blue
- **Complete** — success / green
- **Pending** — neutral / amber
- **Failed** — error / red
</content>
</invoke>
