**Looking for a specific `--token`, not a file?** See `TOKENS.md` — the full reference of every token (in `style.css`'s `:root` and `palettes/default.css`), its default, and what it controls.

# Customizing this scenario

## Architecture

```
style.css                      ← YOU ARE HERE — :root tokens (layout/structure
                                  only), @page layout for cover/front-matter/
                                  back-cover, TOC visual formatting, chapter hero
  ├─ palettes/default.css             (brand identity: colors, fonts, logos,
  │                                     note colors — swap this file for a theme)
  └─ style_styles2.0_imports.css      (element module manifest)
       ├─ dita/*.css            (DITA element reference — tables, lists, notes…)
       ├─ styling/*.css         (optional formatting toggles)
       └─ layout/*.css          (page-break control; toc_flow.css / body_flow.css
                                  own TOC- and body-page pagination mechanics)
```
Add your own overrides in **your own scenario's CSS tab**, after importing `style.css` — there is no shared `custom.css`; see Overrides in `style_styles2.0_imports.css`'s header for why.

## Common customizations

| To change | Edit |
|---|---|
| Web PDF vs. print PDF | The **WEB / PRINT MODE** block at the top of `style.css`'s `:root` — comment out the active block, uncomment the other. See `TOKENS.md`. |
| Theme / brand identity | Swap the `palettes/default.css` import in `style.css` for another `palettes/*.css` file (colors, fonts, logos, note colors) — see "Adding a theme" below. |
| Brand colors | `--brand-primary`, `--brand-secondary` in `palettes/default.css` |
| Page margins | `--standard-margin`, `--top-margin`, `--bottom-margin` |
| Cover background | `--cover-bg-color`, `--cover-hero-height` |
| Running footer text | `--footer-inside-content`, `--footer-outside-content` |
| TOC heading label | `--toc-text` |
| A DITA section/note caption | `--label-*` (e.g. `--label-prereq`, `--label-remedy` — full list in `TOKENS.md`) |
| A metadata field's label | `--cover-*-label` (e.g. `--cover-version-label: "Ver. "`) |
| The logo | `--logo-front` / `--logo-back` (Base64 SVG or `url()`) in `palettes/default.css` |
| A DITA element's style | Open `style_styles2.0_imports.css`, find the section, edit that file |

## Adding a theme

`palettes/default.css` holds every brand-identity token (colors, fonts, logos, note-type colors) in one place, kept separate from `style.css`'s layout/structure tokens on purpose. To ship a second visual theme:

1. Copy `palettes/default.css`, rename it (e.g. `palettes/blue.css`), change the values — keep every token name identical, since `style.css` and the DITA/styling modules consume them by name (see the "STYLES2.0 MODULE TOKEN BRIDGE" in `style.css`).
2. Host the new file (same GitHub Pages pattern as everything else in `styles2.0/v1/`).
3. In `style.css` — or in your own scenario's CSS tab, after importing `style.css` — swap the `@import` to point at your file instead of `palettes/default.css`.

Full token list and what each one controls: `TOKENS.md`.

## Where to make a change

| Safe to edit directly | Edit elsewhere instead |
|---|---|
| Brand colors, fonts, logos, note colors → `palettes/default.css` (or your own `palettes/*.css`) | Cover structure / content order → `xsl.xsl` |
| Spacing, margins, cover geometry → `style.css`'s `:root` | Section on/off (cover, TOC, etc.) → `xsl.xsl` |
| TOC label and formatting → `style.css`'s `:root` + `nav` rules | Metadata sources → ditamap `topicmeta` |
| Metadata field appearance → `.cover-*` rules in `style.css` | DITA element styles → `style_styles2.0_imports.css` → `dita/` or `styling/` |

**Change carefully:** `@page` rules (margins, headers, footers), `string-set` declarations (feed running headers — see the comment on each), and `prince-page-group`/`break-before` (control section page sequencing). These are documented in place in `style.css` and `layout/toc_flow.css`/`body_flow.css` because changing them affects page-flow structure, not just a value.

---

# File reference — what's in each file

### Root

| File | What's in it |
|---|---|
| `style.css` | This scenario's layout/structure `:root` tokens (spacing scale, border widths, font sizes, page geometry), cover/front-matter/back-cover `@page` geometry and markup, TOC visual formatting, and chapter-hero rules. The one file meant to be imported wholesale, then built on per-customer. TOC- and body-page pagination mechanics (margins, running headers/footers) live in `layout/toc_flow.css` and `layout/body_flow.css` instead — see below. Brand-identity tokens (colors, fonts, logos, note colors) live in `palettes/default.css`, imported here — see below. |
| `style_styles2.0_imports.css` | The manifest — what's active, what's optional, and the GitHub URL for every module. Start here to find a specific element. |
| `xsl.xsl` | Controls document assembly: chapter body order, cover/back-cover/front-matter inclusion (each toggled by uncommenting a `call-template` line), cover metadata field extraction (subtitle, author, publisher, company, address, etc., with map vs. bookmap fallbacks), and the `get.map.title` fallback logic for the document title. |
| `cover-page.html` | The default static cover, populated out of the box with the same fields as `xsl.xsl`'s `front.cover` template (product name, version, platform, doc revision, author, created date; part number/audience/publisher/revised available but off by default). Edit the placeholder values directly. To use the system-generated cover instead (metadata pulled automatically from the ditamap/bookmap, no per-document edits), delete the contents and leave only `<span/>` — `xsl.xsl` then generates the cover from document metadata. |

### dita/ — one file per DITA element family

| File | What's in it |
|---|---|
| `paragraph.css` | Paragraph margins; makes the first paragraph inline inside note-like containers (info, result, example, stepresult, table cells); drops paragraph margins around block children (notes, code, figures, quotes, tables, lists). |
| `abstract_shortdesc.css` | Base color for abstract/shortdesc; paragraph-like top margin on shortdesc. |
| `description.css` | Margins for figure and table descriptions (figdesc, tabledesc). |
| `section.css` | Section and section-title margins; tightens spacing after remedy titles. |
| `title.css` | Base styling for every title element (topic titles, table/figure caption labels): font, color, weight, spacing. |
| `choicetable_table.css` | Full-width tables, borders removed except a top/bottom rule (suppressed if a `thead` is present), cell padding. |
| `ordered_list_unordered_list_step_substep_choice.css` | Base list styling — bullet style, list/item margins, step/substep/choice indentation. |
| `choices_steps_substeps_numbering.css` | The circular numbered badges before steps/substeps/choices and the counters driving them (decimal steps, lower-alpha substeps, square-bullet unordered steps). *Requires `typography.css` + `ordered_list_unordered_list_step_substep_choice.css`.* |
| `choices_info_stepresult_stepexample_solution_substeps_troublesolution.css` | Spacing for step-result, step-example, info, and solution/troubleSolution blocks in tasks and troubleshooting topics; the troubleSolution left-border rule. |
| `cause_condition_context_example_postreq_prereq_remedy_result_steps_stepsection.css` | The bold generated captions and spacing for task/troubleshooting "parts": prereq, postreq, context, cause, remedy, condition, result, example, stepsection. |
| `note.css` | All note types (note, tip, important, remember, restriction, warning, caution, danger, attention, trouble, fastpath): icon font, per-type colored border/background/label. |
| `codeblock_codeph.css` | Code block and inline code: monospace font, background, left-border accent on codeblock, bordered screen blocks. |
| `figure_image.css` | Figure/image margins and overflow handling; smaller margins inside task-topic children; inline sizing for images used in commands. |
| `xref_related_links.css` | Inline cross-reference/link color; generates "step N"/"substep N" text for links into steps; related-links section spacing and bold captions. |
| `filepath_sysoutput_userinput_varname.css` | Monospace styling for systemoutput, varname, filepath, userinput; wraps varname in angle brackets. |
| `uicontrol_wintitle_shortcut_menucascade.css` | Bold uicontrol/wintitle, small-caps shortcut keys, arrow (→) separator for menucascade. |
| `cite_long_quote_quote.css` | Cite element color; long-quote left border, size, and margins. |
| `definition_list.css` | Definition-list term/description spacing, left-border accent, bold terms; keeps term and description on the same page. |
| `footnote.css` | Footnote marker and footnote text at the page bottom via Prince's `@footnotes` margin box; smaller font, strips inherited formatting. |

### styling/ — active by default

| File | What's in it |
|---|---|
| `formatting.css` | `@outputclass`-driven text utilities: justify/left/right alignment, smaller/small text sizes. |
| `hide_empty_elements.css` | Hides empty task/troubleshooting containers (prereq, postreq, steps, cause, condition, context, result, example, info) so empty DITA elements don't leave visible gaps. |
| `image_borders.css` | Solid border around images/SVGs by default; `@outputclass="no_borders"` removes it. |
| `suggestions.css` | Colors DITA change-tracking marks (insert/delete/split) red with strikethrough or underline, for showing suggested edits. |
| `typography.css` | Imports the Roboto web font, sets it as the base body font, and sizes/line-height for body text. |

### styling/ — optional (commented out by default)

| File | What's in it |
|---|---|
| `page_flow.css` | Raises the orphan/widow minimum to 3 lines; marks long elements (tables, code, xrefs) as free to break and structural elements (notes, figures, titles) as not to break mid-element. Recommended for print. |
| `chapter_numbering.css` | Adds "Chapter N." numbering to both the TOC entries and the actual chapter titles, through 5 heading levels. |
| `figure_no_numbering.css` | Hides the auto-generated figure-title numbering label. |
| `table_no_numbering.css` | Hides the auto-generated table-title numbering label. |
| `image_shadows.css` | Drop shadow on images/SVGs; `@outputclass="no_shadows"` removes it. |
| `round_corners.css` | Rounded corners on notes, tables, code, images, and troubleSolution blocks, sized by the `--radius` token. |
| `link_page_number.css` | Appends " on page N" after cross-reference links, except glossary, external, and step/substep links. |
| `table_of_contents.css` | Hides the redundant map title above the TOC, adds a "Contents" heading, sets the leader-dot "title .... page#" TOC formatting. |
| `table_of_contents_page_numbering.css` | ⚠️ **Not currently functional** — its own header says "use with `header_footer.css`," which isn't present in this folder. Adds upper-roman page numbers to TOC pages and resets page-1 counters at the cover/TOC/body boundaries, but has no page context to attach to without it. |
| `table_of_contents_page_numbering_alternate.css` | ⚠️ Same issue — depends on `header_footer_alternate.css`, also not present. |

### layout/

| File | What's in it |
|---|---|
| `breaks.css` | Chapter break-before rules; heading/content bonds (don't strand a heading at the bottom of a page); step-procedure and task-label bonds; definition-list and figure integrity; the `break_topics` outputclass; and `.break_before/_after/_avoid/_inside` utility classes. |
| `toc_flow.css` | `@page toc-flow` geometry: margins, running headers/footers, and blank-page suppression for TOC pages (`:first`/`:left`/`:right`/`:blank`). Pagination mechanics only — the TOC's visual formatting (nav, links, "Contents" heading) is in `style.css`. Moved out of `style.css` 2026-09-09 — see that file's "TOC & BODY PAGE FLOW" note. |
| `body_flow.css` | `body > article`'s page assignment plus `@page body-flow` geometry: margins, running headers/footers, and blank-page suppression for body pages (`:first`/`:left`/`:right`/`:blank`). Pagination mechanics only — the chapter-hero title styling is in `style.css`. Moved out of `style.css` 2026-09-09, same note. |

### palettes/

| File | What's in it |
|---|---|
| `default.css` | Brand identity: `--brand-*` colors, `--copyright-notice`, `--font-family-*`, `--text-main`/`-muted`, `--color-note-*`, `--logo-front`/`-back`. Imported by `style.css`. Moved out of `style.css` 2026-09-09 so a different brand/theme is "swap this one file" — see "Adding a theme" above. |
