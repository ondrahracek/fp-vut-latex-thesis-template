# Repository instructions

- Source files live in the repository root, `chapters/`, `appendices/`, `figures/`, and `tests/`. Generated files belong only in `build/`.
- Keep student documentation, examples, placeholders, and new student-facing comments in Czech. Keep paths short, ASCII, and English.
- Preserve the single `settings.tex` switch for BP/DP, the FP default, and working numeric citations.
- Preserve upstream attribution. Do not add personal thesis content, invented bibliography, or invented academic claims.
- After typesetting changes, run `latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build main.tex` from the root and inspect the affected PDF pages.
- After citation-style or test changes, also run `perl tests/check-citations.pl` and inspect its `.bbl`. This fixture checks the style; it does not validate the student's bibliography.
- Do not migrate away from pdfLaTeX, BibTeX, or the inherited type system without an explicit task requiring it.
