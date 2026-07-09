#!/usr/bin/env bash
#
# Carbon plugin advisory hook: lightweight, high-confidence accessibility and
# IBM Carbon Design System checks on frontend files after they are written or
# edited.
#
# It NEVER blocks. It runs only on frontend file types, only flags issues with a
# low false-positive rate, and surfaces them to Claude as additional context so
# they can be fixed. A clean file produces no output. This is a nudge, not a
# substitute for `/carbon:audit` or the carbon-accessibility-auditor agent.
#
# Reads the PostToolUse payload as JSON on stdin.

set -u

# jq is required to parse the hook payload; if it's missing, do nothing.
command -v jq >/dev/null 2>&1 || exit 0

payload="$(cat)"
file_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // .tool_input.path // empty' 2>/dev/null)"

# Nothing to check, or file no longer present.
[ -n "$file_path" ] || exit 0
[ -f "$file_path" ] || exit 0

# Only inspect frontend template / component file types.
case "$file_path" in
  *.html|*.htm|*.jsx|*.tsx|*.js|*.ts|*.svelte|*.vue|*.astro|*.hbs|*.handlebars|*.erb|*.ejs|*.njk|*.php) ;;
  *) exit 0 ;;
esac

findings=""
add() { findings="${findings}$1"$'\n'; }

# --- WCAG: universal high-confidence checks ---------------------------------

# 1.1.1 Non-text Content: <img> without an alt attribute (alt="" is allowed for decorative images).
while IFS=: read -r ln _; do
  [ -n "$ln" ] && add "  - line ${ln}: <img> without an alt attribute (WCAG 1.1.1). Add descriptive alt text, or alt=\"\" if decorative."
done < <(grep -niE '<img\b' "$file_path" 2>/dev/null | grep -ivE 'alt[[:space:]]*=' | cut -d: -f1 | sed 's/$/:/')

# 3.1.1 Language of Page: <html> element with no lang attribute.
if grep -qiE '<html\b' "$file_path" 2>/dev/null && ! grep -iE '<html\b' "$file_path" 2>/dev/null | grep -qiE 'lang[[:space:]]*='; then
  add "  - <html> element has no lang attribute (WCAG 3.1.1). Add e.g. lang=\"en\"."
fi

# 2.4.3 / keyboard: positive tabindex disrupts natural focus order.
while IFS=: read -r ln _; do
  [ -n "$ln" ] && add "  - line ${ln}: positive tabindex (WCAG 2.4.3). Use only tabindex=\"0\" or \"-1\"; positive values break focus order."
done < <(grep -niE 'tabindex[[:space:]]*=[[:space:]]*["'\'']?\{?[1-9]' "$file_path" 2>/dev/null | cut -d: -f1 | sed 's/$/:/')

# 2.1.1 Keyboard: click handlers on non-interactive elements (div/span) are not keyboard-operable.
while IFS=: read -r ln _; do
  [ -n "$ln" ] && add "  - line ${ln}: onClick on a <div>/<span> (WCAG 2.1.1). Use Carbon <Button> (or a real <a> for navigation) so it is keyboard-operable."
done < <(grep -niE '<(div|span)\b[^>]*[[:space:]]on[cC]lick' "$file_path" 2>/dev/null | cut -d: -f1 | sed 's/$/:/')

# --- Carbon-specific nudges: use the Carbon component -----------------------

# Hand-rolled native <select> where Carbon has Dropdown / Select / ComboBox / MultiSelect.
while IFS=: read -r ln _; do
  [ -n "$ln" ] && add "  - line ${ln}: raw <select> element. Carbon provides Dropdown, Select, ComboBox and MultiSelect — prefer the Carbon component for consistent styling, theming and accessibility."
done < <(grep -niE '<select\b' "$file_path" 2>/dev/null | cut -d: -f1 | sed 's/$/:/')

# Hand-rolled native <table> where Carbon DataTable exists (advisory; a plain <table> is fine for static data).
while IFS=: read -r ln _; do
  [ -n "$ln" ] && add "  - line ${ln}: raw <table> element. If this is sortable / selectable / paginated data, use Carbon DataTable (it wires up header scope, keyboard and batch actions); a plain semantic table is fine for simple static data."
done < <(grep -niE '<table\b' "$file_path" 2>/dev/null | cut -d: -f1 | sed 's/$/:/')

# Icon-only Carbon Button without an accessible name (needs iconDescription / label).
while IFS=: read -r ln _; do
  [ -n "$ln" ] && add "  - line ${ln}: icon-only Carbon Button (hasIconOnly) without iconDescription (WCAG 4.1.2 / 1.1.1). An icon-only control needs an accessible name — add iconDescription."
done < <(grep -niE 'hasIconOnly' "$file_path" 2>/dev/null | grep -ivE 'iconDescription' | cut -d: -f1 | sed 's/$/:/')

# Carbon IconButton without a label (its accessible name).
while IFS=: read -r ln _; do
  [ -n "$ln" ] && add "  - line ${ln}: Carbon <IconButton> without a label prop (WCAG 4.1.2). Add label=\"…\" — it is both the tooltip and the accessible name."
done < <(grep -niE '<IconButton\b' "$file_path" 2>/dev/null | grep -ivE '[[:space:]]label[[:space:]]*=' | cut -d: -f1 | sed 's/$/:/')

[ -n "$findings" ] || exit 0

context="Carbon accessibility / design-system check flagged possible issues in $(basename "$file_path") — please review and fix where appropriate:
${findings}
This is an advisory, high-confidence subset only. For a full review run /carbon:audit or use the carbon-accessibility-auditor agent."

jq -n --arg ctx "$context" \
  '{hookSpecificOutput: {hookEventName: "PostToolUse", additionalContext: $ctx}}'
exit 0
