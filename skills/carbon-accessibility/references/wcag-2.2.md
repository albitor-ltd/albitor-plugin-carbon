# WCAG 2.2 Success Criteria (Level A and AA)

> **Sources:** [WCAG 2.2 (W3C Recommendation)](https://www.w3.org/TR/WCAG22/) and [How to Meet WCAG 2.2 Quick Reference](https://www.w3.org/WAI/WCAG22/quickref/).
> WCAG 2.2 © W3C, used under the [W3C Document Licence](https://www.w3.org/copyright/document-license/). Distilled reference — verify against the live source for current detail. "How to meet it" tips reference IBM Carbon where a component/token makes the fix concrete.

## What you need to know

WCAG 2.2 organises requirements under **four principles (POUR)** — Perceivable, Operable, Understandable, Robust — each broken into **guidelines** containing **success criteria** graded **A** (minimum), **AA**, or **AAA**.

**The enterprise baseline is every Level A and Level AA criterion.** Level AAA is not required and is not listed here. Procurement standards (Section 508, EN 301 549) reference WCAG at AA, so meeting A + AA covers them.

This page covers **all 50 Level A and AA success criteria** (31 at Level A, 19 at Level AA).

### New in WCAG 2.2

| Criterion | Name | Level |
| --- | --- | --- |
| 2.4.11 | Focus Not Obscured (Minimum) | AA |
| 2.5.7 | Dragging Movements | AA |
| 2.5.8 | Target Size (Minimum) | AA |
| 3.2.6 | Consistent Help | A |
| 3.3.7 | Redundant Entry | A |
| 3.3.8 | Accessible Authentication (Minimum) | AA |

(2.4.12 Focus Not Obscured (Enhanced), 2.4.13 Focus Appearance, and 3.3.9 Accessible Authentication (Enhanced) are also new but are AAA and not required.)

**Removed in WCAG 2.2:** **4.1.1 Parsing** was removed entirely — it is obsolete because modern browsers and assistive tech handle markup parsing reliably. Do not test against it.

---

## 1. Perceivable

Information and UI components must be presentable to users in ways they can perceive.

### Guideline 1.1 Text Alternatives

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 1.1.1 | Non-text Content | A | All non-text content (images, icons, charts) has a text alternative serving the equivalent purpose; decorative items are hidden from assistive tech. | Give meaningful images an `alt` describing their purpose; use `alt=""` for decorative images; give icon-only Carbon `Button`/`IconButton` an `iconDescription`/`label`; hide decorative Carbon icons with `aria-hidden`. |

### Guideline 1.2 Time-based Media

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 1.2.1 | Audio-only and Video-only (Prerecorded) | A | Prerecorded audio-only has a text transcript; prerecorded video-only has a transcript or audio track. | Publish a full transcript next to audio; describe silent video in text or an audio narration. |
| 1.2.2 | Captions (Prerecorded) | A | Synchronised media (video with audio) has captions. | Add accurate, synchronised closed captions to all prerecorded video. |
| 1.2.3 | Audio Description or Media Alternative (Prerecorded) | A | Prerecorded video has audio description or a full text alternative. | Provide a transcript that includes descriptions of important visual detail, or an audio-described track. |
| 1.2.4 | Captions (Live) | AA | Live synchronised media has captions. | Arrange live (real-time) captioning for webcasts and live streams. |
| 1.2.5 | Audio Description (Prerecorded) | AA | All prerecorded video in synchronised media has an audio description. | Add an audio-description track narrating key visual information during natural pauses. |

### Guideline 1.3 Adaptable

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 1.3.1 | Info and Relationships | A | Structure and relationships conveyed visually are also available programmatically. | Use semantic HTML: real `<h1>`–`<h6>` (or Carbon `Section`/`Heading`), `DataTable`/`<table>` with `<th scope>`, lists, `labelText` tied to inputs, `FormGroup`/`legend`. |
| 1.3.2 | Meaningful Sequence | A | The reading/navigation order is programmatically correct where order affects meaning. | Make the DOM order match the logical reading order; don't rely on CSS/grid positioning to set sequence. |
| 1.3.3 | Sensory Characteristics | A | Instructions don't rely solely on shape, size, location, orientation or sound. | Write "select Save" not "click the button on the right". |
| 1.3.4 | Orientation | AA | Content isn't locked to one orientation unless essential. | Don't force portrait or landscape; let the 2x Grid reflow in both. |
| 1.3.5 | Identify Input Purpose | AA | The purpose of common input fields is programmatically determinable. | Set HTML `autocomplete` tokens (`email`, `name`, `tel`) on Carbon inputs collecting user data. |

### Guideline 1.4 Distinguishable

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 1.4.1 | Use of Color | A | Colour is not the only means of conveying information or distinguishing elements. | Pair colour with text/icon: a Carbon status `Tag` or notification must carry text/an icon, not colour alone. |
| 1.4.2 | Audio Control | A | Audio that plays automatically for >3s can be paused, stopped or muted. | Avoid autoplay audio; if unavoidable, provide a visible pause/stop/volume control. |
| 1.4.3 | Contrast (Minimum) | AA | Text contrast ≥ 4.5:1 (≥ 3:1 for large text, 18.66px bold / 24px regular). | Use Carbon theme tokens (`$text-primary` on `$background`/`$layer-*`) and verify contrast **in every theme** (White/g10/g90/g100). |
| 1.4.4 | Resize Text | AA | Text can scale to 200% without loss of content or function. | Use `rem`/`em` (Carbon's type tokens do); avoid fixed pixel heights that clip text. |
| 1.4.5 | Images of Text | AA | Use real text, not images of text, except logos or where essential. | Style text with CSS/IBM Plex instead of rendering it into an image. |
| 1.4.10 | Reflow | AA | Content reflows to a 320px-wide viewport (400% zoom) without two-dimensional scrolling. | Use the responsive 2x Grid and relative units; make wide `DataTable`s scroll within their own container, not the page. |
| 1.4.11 | Non-text Contrast | AA | UI components and meaningful graphics have ≥ 3:1 contrast against adjacent colours. | Ensure form borders, button edges, icons and the `$focus` ring meet 3:1 in every theme. |
| 1.4.12 | Text Spacing | AA | No loss of content when users override line height, paragraph, letter and word spacing. | Don't fix container heights around text; allow text to grow when spacing is increased. |
| 1.4.13 | Content on Hover or Focus | AA | Hover/focus-triggered content is dismissible, hoverable and persistent. | Use Carbon `Tooltip`/`Toggletip`/`Popover` (they handle this) rather than `title`; allow Esc to dismiss. |

---

## 2. Operable

UI components and navigation must be operable.

### Guideline 2.1 Keyboard Accessible

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 2.1.1 | Keyboard | A | All functionality is operable by keyboard. | Use native/Carbon interactive elements (`Button`, `Link`, `Dropdown`); for custom widgets add keyboard handlers and focusability. |
| 2.1.2 | No Keyboard Trap | A | Keyboard focus can always move away from a component. | Carbon `Modal`/`ComposedModal` traps focus only while open and releases it on close — verify custom overlays do the same. |
| 2.1.4 | Character Key Shortcuts | A | Single-character shortcuts can be turned off, remapped, or are focus-only. | Avoid lone-letter shortcuts, or make them active only when a component has focus / offer a way to disable them. |

### Guideline 2.2 Enough Time

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 2.2.1 | Timing Adjustable | A | Time limits can be turned off, adjusted or extended (with exceptions). | Warn before a session times out and offer "extend"; avoid arbitrary limits. |
| 2.2.2 | Pause, Stop, Hide | A | Moving/blinking/auto-updating content lasting >5s can be paused, stopped or hidden. | Add pause controls to carousels, tickers and auto-refreshing dashboards; respect `prefers-reduced-motion`. |

### Guideline 2.3 Seizures and Physical Reactions

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 2.3.1 | Three Flashes or Below Threshold | A | Nothing flashes more than three times per second. | Avoid rapid flashing; keep any flashing below the general and red flash thresholds. |

### Guideline 2.4 Navigable

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 2.4.1 | Bypass Blocks | A | A way exists to skip blocks repeated across pages. | Add a "Skip to main content" link and use landmarks (`<nav>`, `<main>`; Carbon UI Shell provides structure). |
| 2.4.2 | Page Titled | A | Pages have descriptive titles. | Set a unique, meaningful `<title>` per page (page-specific first, then product name). |
| 2.4.3 | Focus Order | A | Focus moves in an order that preserves meaning and operability. | Keep DOM order logical; avoid positive `tabindex`. |
| 2.4.4 | Link Purpose (In Context) | A | A link's purpose is clear from its text or surrounding context. | Write descriptive `Link` text ("View invoice 4821"), not "click here". |
| 2.4.5 | Multiple Ways | AA | More than one way to find a page exists (except within a process). | Provide navigation plus search, a sitemap, or related links. |
| 2.4.6 | Headings and Labels | AA | Headings and labels describe topic or purpose. | Write clear, specific headings and field `labelText`. |
| 2.4.7 | Focus Visible | AA | The keyboard focus indicator is visible. | Keep Carbon's `$focus` outline; never `outline: none` without an equally visible replacement. |
| 2.4.11 | Focus Not Obscured (Minimum) **[NEW 2.2]** | AA | A focused element is not *entirely* hidden by author content. | Use `scroll-padding` and manage z-index so the sticky `Header`/`SideNav` and notifications don't fully cover the focused control. |

### Guideline 2.5 Input Modalities

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 2.5.1 | Pointer Gestures | A | Multipoint/path gestures have a single-pointer alternative (unless essential). | Provide buttons/taps as alternatives to swipe, pinch or drag-path gestures. |
| 2.5.2 | Pointer Cancellation | A | Single-pointer actions complete on up-event, or can be aborted/undone. | Trigger actions on `click`/up-event, not `mousedown`; allow moving off the target to cancel. |
| 2.5.3 | Label in Name | A | A control's accessible name contains its visible label text. | Ensure `aria-label`/`iconDescription` includes the visible text (so voice-control users can say it). |
| 2.5.4 | Motion Actuation | A | Functions triggered by device motion have a UI alternative and can be disabled. | Provide a button for any "shake to…" action and let users turn motion control off. |
| 2.5.7 | Dragging Movements **[NEW 2.2]** | AA | Drag operations have a single-pointer non-drag alternative. | Offer tap/click alternatives to drag-and-drop (e.g. up/down buttons or a reorder menu for `DataTable` row reordering). |
| 2.5.8 | Target Size (Minimum) **[NEW 2.2]** | AA | Pointer targets are ≥ 24×24 CSS px, or have adequate spacing (exceptions: inline links, UA-default sizing). | Keep Carbon's default control sizes (they clear 24×24px); don't shrink controls below it for density. |

---

## 3. Understandable

Information and operation of the UI must be understandable.

### Guideline 3.1 Readable

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 3.1.1 | Language of Page | A | The default human language of the page is programmatically set. | Add `lang` to the `<html>` element (e.g. `<html lang="en">`). |
| 3.1.2 | Language of Parts | AA | Language changes within content are marked up. | Wrap foreign-language phrases in an element with the correct `lang` attribute. |

### Guideline 3.2 Predictable

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 3.2.1 | On Focus | A | Receiving focus doesn't cause an unexpected change of context. | Don't auto-submit, navigate or open popups simply because an element is focused. |
| 3.2.2 | On Input | A | Changing a setting doesn't auto-change context unless the user is warned. | Don't auto-submit a form when a `Dropdown`/`Select` option changes; require an explicit action or warn first. |
| 3.2.3 | Consistent Navigation | AA | Repeated navigation appears in the same relative order across pages. | Keep the UI Shell `Header`/`SideNav` order consistent across the product. |
| 3.2.4 | Consistent Identification | AA | Components with the same function are identified consistently. | Use the same label/icon for the same action everywhere (e.g. "Export" always labelled and iconed the same). |
| 3.2.6 | Consistent Help **[NEW 2.2]** | A | Help mechanisms appear in the same relative order across pages. | Place help links / contact / chat in a consistent location on every page. |

### Guideline 3.3 Input Assistance

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 3.3.1 | Error Identification | A | Input errors are identified and described in text. | Set Carbon `invalid` + `invalidText` (text, not colour alone) and surface a form-level summary. |
| 3.3.2 | Labels or Instructions | A | Labels/instructions are provided for user input. | Give every field a persistent `labelText`; add `helperText` for format requirements. |
| 3.3.3 | Error Suggestion | A | If an error is detected and a fix is known, suggest it. | Tell users how to fix it ("Enter a date as DD/MM/YYYY") in `invalidText`. |
| 3.3.4 | Error Prevention (Legal, Financial, Data) | A | Legal/financial/data submissions are reversible, checked, or confirmed. | Add a review/confirm step (or a `danger` `Modal`) before final submission. |
| 3.3.7 | Redundant Entry **[NEW 2.2]** | A | Information already entered isn't requested again in the same process (with exceptions). | Pre-fill or carry forward previously entered data across steps; offer "same as above". |
| 3.3.8 | Accessible Authentication (Minimum) **[NEW 2.2]** | AA | Authentication doesn't require a cognitive function test without an alternative. | Allow password managers/paste on the Carbon `PasswordInput`; offer email/magic-link instead of CAPTCHAs or recall puzzles. |

---

## 4. Robust

Content must be robust enough to be interpreted reliably by user agents and assistive technologies.

### Guideline 4.1 Compatible

> **Note:** 4.1.1 Parsing was **removed** in WCAG 2.2.

| # | Name | Level | What it requires | How to meet it |
| --- | --- | --- | --- | --- |
| 4.1.2 | Name, Role, Value | A | All UI components expose a name, role, state and value to assistive tech. | Prefer Carbon/native controls; for custom widgets use correct ARIA roles/states and keep them updated. |
| 4.1.3 | Status Messages | A | Status messages are exposed to assistive tech without moving focus. | Use Carbon `InlineLoading`/`ToastNotification`/`InlineNotification` (they use live regions) or `aria-live` for dynamic updates like "3 results" or "Saved". |

---

## Quick reference: counts

- **Level A:** 31 criteria
- **Level AA:** 19 criteria
- **Total baseline (A + AA):** 50 criteria
