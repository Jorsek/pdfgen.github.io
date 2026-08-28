# File reference — what's in each file

### Root

| File | What's in it |
|---|---|
| `style.css` | This scenario's `:root` tokens (brand colors, spacing scale, border widths, font sizes), `@page` geometry, cover page, TOC container, and chapter-hero rules. The one file meant to be imported wholesale, then built on per-customer. |
| `style_ps2_imports.css` | The manifest — what's active, what's optional, and the GitHub URL for every module. Start here to find a specific element. |
| `xsl.xsl` | Controls document assembly: chapter body order, cover/back-cover/front-matter inclusion (each toggled by uncommenting a `call-template` line), cover metadata field extraction (subtitle, author, publisher, company, address, etc., with map vs. bookmap fallbacks), and the `get.map.title` fallback logic for the document title. |
| `cover-page.html` | Empty placeholder (`<span/>`) — this scenario uses the system-generated default cover rather than a custom HTML cover. Only needs content if you want to override that default. |

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
