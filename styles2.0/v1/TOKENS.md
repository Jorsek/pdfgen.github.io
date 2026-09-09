# Token Reference — `style.css`

Every custom property (`--token-name`) defined in `style.css`'s `:root` block, what it controls, and its default value. This is the single place to look up "what do I change for X" — for which *file* controls a given element instead, see `readme.md`.

**How to override:** copy the token into your own scenario's CSS (or edit `style.css` directly if this scenario is yours to edit), after the `@import` of `style_styles2.0_imports.css`, and give it a new value. Because everything downstream reads through `var()`, one token change updates every place that token is used — no need to hunt through `dita/`, `styling/`, or `layout/` files.

**Types you'll see:** color (hex or `rgba()`), length (`pt`/`px`/`in`), font stack, string (quoted text — used directly as CSS `content`), and keyword (a fixed set of valid values, noted where relevant). A token whose value is `var(--other-token)` inherits from that token until overridden directly.

---

## Global Logic

| Token | Default | Controls |
|---|---|---|
| `--page-break-logic` | `right` | Whether a new chapter/section starts on the next right-hand/odd page (`right`, standard duplex-print convention) or the next available page (`auto`). |
| `--back-cover-break` | `right` | Same break behavior, applied specifically before the back cover. |
| `--frontmatter-page-numbering` | `lower-roman` | Numbering style for front matter and TOC pages. `lower-roman` = i, ii, iii; `decimal` = 1, 2, 3. |

## Branding Palette

| Token | Default | Controls |
|---|---|---|
| `--brand-primary` | `#005A9C` | Cover background, page headers, TOC links/text, chapter title color, table header background and note-border color (via the bridge block below). |
| `--brand-secondary` | `#4A5568` | Footer text color; table header hover/heading accent color (via `--color-primary-dark`). |
| `--brand-accent` | `#CCCCCC` | Title underline rule color; table and definition-list border color (via `--color-border`); step-number badge background (via `--color-bg-step`). |

## Copyright

| Token | Default | Controls |
|---|---|---|
| `--copyright-notice` | `"REPLACE WITH YOUR ORGANIZATION"` | Full copyright-holder text, shown after the © symbol on the front cover (`.cover-copyright::before`). DITA builds instead pull this from `<copyrholder>` via XSL on the back cover — this token is the static-HTML-build / CSS-driven fallback. |

## Typography

| Token | Default | Controls |
|---|---|---|
| `--font-family-main` | `'Helvetica Neue', Helvetica, Arial, sans-serif` | Base font for the cover, chapter titles, body heading rules, and back cover text. |
| `--font-family-header` | `"Arial", sans-serif` | Running header font at the top of body and TOC pages. |
| `--font-family-footer` | `"Arial", sans-serif` | Running footer font at the bottom of body, TOC, and front-matter pages. |
| `--title-size` | `32pt` | Font size of chapter titles, the cover title, and the TOC heading. |
| `--title-weight` | `300` | Font weight of the same three. |
| `--title-line-height` | `1.1` | Line height of the same three. |
| `--subtitle-size` | `14pt` | Font size of the subtitle line shown right after a chapter title or shortdesc. |
| `--subtitle-color` | `var(--brand-primary)` | Color of that subtitle line. |

## Cover Metadata — Shared Block Settings

| Token | Default | Controls |
|---|---|---|
| `--cover-meta-font-size` | `12pt` | Base font size for the whole metadata block; most individual fields default to this via `var(--cover-meta-font-size, 9pt)`. |
| `--cover-meta-line-height` | `1.8` | Line spacing between metadata fields. |
| `--cover-meta-color` | `var(--text-main)` | Base text color for metadata fields — dark, because the block sits in the white band below the cover hero image. |

## Cover Metadata — Per-Field Size / Color / Weight

Eleven optional fields can appear in the metadata block (enabled/disabled per document in `xsl.xsl`, or per line in a static `cover-page.html`). Each has its own size, color, and weight token, defaulting to the shared block settings above.

| Field | Size token | Color token | Weight token |
|---|---|---|---|
| Subtitle | `--cover-subtitle-size` (`14pt`) | `--cover-subtitle-color` (`rgba(255,255,255,0.80)`) | `--cover-subtitle-weight` (`normal`) |
| Product name | `--cover-prodname-size` | `--cover-prodname-color` | `--cover-prodname-weight` (`normal`) |
| Version | `--cover-version-size` | `--cover-version-color` | `--cover-version-weight` (`normal`) |
| Platform | `--cover-platform-size` | `--cover-platform-color` | `--cover-platform-weight` (`normal`) |
| Part number | `--cover-partno-size` | `--cover-partno-color` | `--cover-partno-weight` (`normal`) |
| Doc revision | `--cover-doc-revision-size` | `--cover-doc-revision-color` | `--cover-doc-revision-weight` (`normal`) |
| Audience | `--cover-audience-size` | `--cover-audience-color` | `--cover-audience-weight` (`normal`) |
| Author | `--cover-author-size` | `--cover-author-color` | `--cover-author-weight` (`normal`) |
| Publisher | `--cover-publisher-size` | `--cover-publisher-color` | `--cover-publisher-weight` (`normal`) |
| Created date | `--cover-created-size` | `--cover-created-color` | `--cover-created-weight` (`normal`) |
| Revised date | `--cover-revised-size` | `--cover-revised-color` | `--cover-revised-weight` (`normal`) |
| Copyright | `--cover-copyright-size` | `--cover-copyright-color` | `--cover-copyright-weight` (`normal`) |

All color/size fields other than subtitle default via `var(--cover-meta-font-size, 9pt)` / `var(--cover-meta-color, rgba(255,255,255,0.90))`.

Additional subtitle-only token: **`--cover-subtitle-margin-top`** (`10pt`) — space above the subtitle line.

## Cover Metadata — Field Labels

Each token below is text prepended to its field via `::before`. Default is an empty string (no visible label) unless noted.

| Token | Default |
|---|---|
| `--cover-subtitle-label` | `""` |
| `--cover-prodname-label` | `""` |
| `--cover-version-label` | `"Version: "` |
| `--cover-platform-label` | `""` |
| `--cover-partno-label` | `""` |
| `--cover-doc-revision-label` | `"Rev. "` |
| `--cover-audience-label` | `""` |
| `--cover-author-label` | `""` |
| `--cover-publisher-label` | `""` |
| `--cover-created-label` | `""` |
| `--cover-revised-label` | `""` |
| `--cover-copyright-label` | `"\A9 "` (© symbol — full text comes from `--copyright-notice`) |

## Text & Body Colors

| Token | Default | Controls |
|---|---|---|
| `--text-main` | `#333333` | Body copy color; base color for the cover metadata block. |
| `--text-muted` | `#666666` | Secondary text — TOC level-2/3 entries, captions. |

## Running Headers & Footers

| Token | Default | Controls |
|---|---|---|
| `--running-head-size` | `11pt` | Font size of the running header (chapter/TOC title at top of page). |
| `--footer-font-size` | `10pt` | Font size of the running footer. |
| `--footer-font-weight` | `normal` | Font weight of the running footer. |
| `--footer-text-color` | `var(--brand-secondary)` | Color of the running footer text. |

## Rule & Border Settings

| Token | Default | Controls |
|---|---|---|
| `--title-rule-weight` | `0` | Thickness of the underline rule below chapter/TOC titles. `0` = no visible rule. |
| `--title-rule-color` | `var(--brand-accent)` | Color of that rule. |
| `--running-rule-weight` | `.5pt` | Thickness of the header/footer divider rules on every page. |
| `--header-rule-color` | `var(--brand-primary)` | Color of the header divider rule. |
| `--footer-rule-color` | `var(--brand-primary)` | Color of the footer divider rule. |

## Page Margins & Gaps

| Token | Default | Controls |
|---|---|---|
| `--top-margin` | `.85in` | Top page margin (body/TOC/front-matter pages, excluding cover). |
| `--bottom-margin` | `.65in` | Bottom page margin. |
| `--standard-margin` | `0.75in` | Outer-edge margin on left/right (non-gutter) pages. |
| `--gutter-margin` | `.75in` | Binding-side margin on left/right (duplex) pages — see `--page-break-logic` and the web/print note below. |
| `--header-gap` | `15pt` | Space between the header rule and the page content that follows. |
| `--footer-padding` | `6pt` | Space between the footer rule and the footer text above it. |

> **Note for the print/web unification work:** `--gutter-margin` (distinct from `--standard-margin`) and `--frontmatter-page-numbering: lower-roman` are both duplex-print conventions with no on-screen equivalent — flagged here as the tokens a future `--pdf-mode` toggle would need to override. See the gap-analysis doc, Section 7.

## Title & Hero Spacing

| Token | Default | Controls |
|---|---|---|
| `--title-margin-top` | `0.5in` | Space above chapter/TOC/cover titles. |
| `--title-margin-bot` | `50pt` | Space below chapter/TOC/cover titles. |
| `--title-padding-bot` | `25pt` | Padding below the title, above its underline rule. |

## TOC Styling

| Token | Default | Controls |
|---|---|---|
| `--toc-text` | `"Contents"` | The TOC heading text itself, and the running-header label on TOC pages. |
| `--toc-level1-size` | `13pt` | Font size of top-level TOC entries. |
| `--toc-level2-size` | `11pt` | Font size of second-level TOC entries. |
| `--toc-level3-size` | `10pt` | Font size of third-level TOC entries. |
| `--toc-link-color` | `var(--brand-primary)` | Color of TOC entry text/links. |
| `--toc-indent-step` | `15pt` | Left-indent applied per nested TOC level. |
| `--toc-dot-color` | `var(--brand-primary)` | Color of the leader dots between an entry and its page number. |
| `--toc-text-color` | `var(--brand-primary)` | Reserved general TOC text color (currently unused directly — `--toc-link-color` and per-level rules cover the visible text; kept for future use). |

## Configurable Labels — DITA Section & Note Captions

Added 2026-09-09 to close the "labels tokenized inconsistently" gap — these follow the exact same pattern as `--toc-text` above. Each value is the full caption text, including any trailing `": "` that's part of the default.

| Token | Default | Consumed by |
|---|---|---|
| `--label-prereq` | `"Before you begin"` | `dita/cause_condition_..._stepsection.css` → `.prereq::before` |
| `--label-postreq` | `"Next steps"` | same file → `.postreq::before` |
| `--label-steps-process` | `"Process"` | same file → `.steps::before` when the topic has `outputclass="process"` |
| `--label-steps-procedure` | `"Procedure"` | same file → `.steps::before`, default (non-process) case |
| `--label-context` | `"Context"` | same file → `.context::before` |
| `--label-condition` | `"Condition"` | same file → `.condition::before` |
| `--label-cause` | `"Cause"` | same file → `.cause::before` |
| `--label-remedy` | `"Remedy"` | same file → `.remedy::before` |
| `--label-example` | `"Example"` | same file → `.example::before` |
| `--label-result` | `"Result"` | same file → `.result::before` |
| `--label-info` | `"Info: "` | `dita/choices_info_..._troublesolution.css` → `.info::before` — **rule is commented out by default**; token is wired through so enabling it doesn't reintroduce a hardcoded string. |
| `--label-stepxmp-example` | `"Example: "` | same file → `.stepxmp::before` |
| `--label-stepresult-result` | `"Result: "` | same file → `.stepresult::before` |
| `--label-troubleshooting` | `"Troubleshooting: "` | same file → `.steptroubleshooting::before` |

Not tokenized, and out of scope for this set: the `": "` separator in `.cause > .title::after` / `.remedy > .title::after` — that's punctuation joining a title to body text, not a standalone caption.

## Cover & Back Cover Geometry

| Token | Default | Controls |
|---|---|---|
| `--cover-bg-color` | `var(--brand-primary)` | Background color of the front cover's hero band. |
| `--cover-text-color` | `#FFFFFF` | Text color on the front cover and the entire back cover. |
| `--cover-hero-height` | `8.25in` | Height of the colored hero band on the front cover (page is 11in tall). |
| `--cover-inset` | `1in` | Inset of the logo and text block from the cover edges. |
| `--cover-logo-width` | `2.33in` | Front cover logo width. |
| `--cover-logo-height` | `1in` | Front cover logo height. |
| `--back-logo-width` | `3.24in` | Back cover logo width. |
| `--back-logo-height` | `2in` | Back cover logo height. |
| `--back-footer-bottom` | `0.75in` | Distance from the bottom of the page to the back cover's company-details block. |

## Footer Content Logic

| Token | Default | Controls |
|---|---|---|
| `--toc-footer-outside` | `counter(page, lower-roman)` | What renders in the outside-edge footer slot on TOC pages (page number, roman). |
| `--toc-footer-inside` | `string(map-title)` | What renders in the inside-edge footer slot on TOC pages (document title). |
| `--footer-outside-content` | `counter(page)` | What renders in the outside-edge footer slot on body pages (page number, decimal). |
| `--footer-inside-content` | `string(map-title)` | What renders in the inside-edge footer slot on body pages (document title). |

## Logo Assets

| Token | Default | Controls |
|---|---|---|
| `--logo-front` | Base64-encoded placeholder SVG (dark box, "REPLACE LOGO") | Front cover logo image. Accepts a Base64 `data:image/svg+xml` URI or a plain `url()`. |
| `--logo-back` | Base64-encoded placeholder SVG (outlined box, "COMPANY LOGO") | Back cover logo image. Typically a simplified or all-white version of the front logo. |

## Styles2.0 Module Token Bridge

These map the shared library's internal token names to this scenario's brand tokens, so the GitHub-hosted `dita/`/`styling/` modules inherit branding automatically. **Don't rename these** — the module files consume them by name; change the *source* tokens above instead.

| Token | Default | Controls |
|---|---|---|
| `--color-primary` | `var(--brand-primary)` | Table header background, note left-border color, xref/link color. |
| `--color-primary-dark` | `var(--brand-secondary)` | Table header hover state, heading accent color. |
| `--color-body` | `var(--text-main)` | Paragraph text color in all element modules. |
| `--color-body-light` | `#ffffff` | Text color on dark backgrounds (e.g. table header text). |
| `--color-border` | `var(--brand-accent)` | Table borders, definition-list rule color. |
| `--color-bg-subtle` | `#f4f4f4` | Alternating table row background, code block background. |
| `--color-bg-step` | `var(--brand-accent)` | Step-number badge background. |
| `--font-body` | `var(--font-family-main)` | Body text font in paragraphs, lists, tables. |
| `--font-heading` | `var(--font-family-header)` | Section title and table caption font. |
| `--font-mono` | `"DejaVu Sans Mono", Monaco, Consolas, monospace` | Codeblock, codeph, and filepath font. |
| `--font-size-base` | `11pt` | Default body text size in element modules. |
| `--font-size-small` | `9pt` | Captions, footnotes, table cell text size. |
| `--font-size-xs` | `8pt` | Fine print, metadata label size. |

### Note Type Colors

| Token | Default | Controls |
|---|---|---|
| `--color-note-note` | `var(--brand-primary)` | Left border on `<note type="note">`. |
| `--color-note-note-bg` | `#005A9C1A` | Background tint on `<note type="note">`. |
| `--color-note-tip` | `#3f6c51` | Left border on `<note type="tip">`. |
| `--color-note-tip-bg` | `#3f6c512c` | Background tint on `<note type="tip">`. |
| `--color-note-warning` | `#d95700` | Left border on `<note type="warning">`. |
| `--color-note-warning-bg` | `#d9570027` | Background tint on `<note type="warning">`. |
| `--color-note-important` | `#ffa600` | Left border on `<note type="important">`. |
| `--color-note-important-bg` | `#ffc25131` | Background tint on `<note type="important">`. |

## Spacing Scale

| Token | Default | Controls |
|---|---|---|
| `--space-1` | `5px` | Paragraph gaps, small list margins. |
| `--space-2` | `10px` | Content padding: notes, tables, code, definition lists. |
| `--space-3` | `15px` | Medium gaps: related links, step sections. |
| `--space-4` | `20px` | Indent: definition-list children, step children. |
| `--space-5` | `25px` | Title margins, larger spacing. |
| `--space-chapter` | `50px` | Breathing room above/below `h1` chapter titles. |

## Border Widths

| Token | Default | Controls |
|---|---|---|
| `--border-width-accent` | `5px` | Left border on notes, code, cite blocks, definition lists. |
| `--border-width-subtle` | `2px` | Lighter divider on step children, suggestions. |
| `--border-width-fine` | `1px` | Thinnest rule (footnote separator). |

## Heading Font Sizes

| Token | Default | Controls |
|---|---|---|
| `--font-size-h1` | `var(--title-size)` | `topictitle1` heading size (mirrors the chapter-title size above). |
| `--font-size-h2` | `18pt` | `topictitle2` heading size. |
| `--font-size-h3` | `14pt` | `topictitle3` heading size. |
| `--font-size-h4` | `12pt` | `topictitle4`+ / section title heading size. |
| `--line-height-base` | `1.4` | Default line height used by the DITA title module. |

---

**Total: 159 tokens.** All defined once, in `style.css`'s `:root` — in both `Default_2.0/style.css` (the live scenario) and the `styles2.0/v1/style.css` starter copy new scenarios are built from. Keep the two in sync when either changes.
