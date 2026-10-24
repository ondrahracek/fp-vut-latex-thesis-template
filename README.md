# LaTeX šablona závěrečné práce FP VUT

Neoficiální LaTeX šablona pro bakalářské a diplomové práce na Fakultě podnikatelské VUT v Brně.

## Překlad

Potřebujete pdfLaTeX, BibTeX a latexmk. Třída používá běžné balíčky distribuce TeX Live, mimo jiné český `babel`, `hyperref`, `pdfpages`, Open Sans, `amsmath`, `booktabs`, `listings` a `appendix`; nejjednodušší je plná instalace TeX Live. Na macOS ji poskytuje [MacTeX](https://www.tug.org/mactex/), na Windows lze použít [TeX Live](https://www.tug.org/texlive/) nebo [MiKTeX](https://miktex.org/) s Perlem potřebným pro latexmk.

Z kořene projektu spusťte:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build main.tex
```

Výsledkem je `build/main.pdf`. Pomocné soubory odstraní `latexmk -c -outdir=build main.tex`; varianta `-C` odstraní i PDF. Po prvním přidání nebo výměně `zadani.pdf` použijte navíc přepínač `-g`, protože latexmk nemusí změnu dříve chybějícího souboru rozpoznat. Latexmk může načíst systémové nebo uživatelské nastavení; při hledání rozdílů je lze diagnosticky vypnout pomocí `-norc`.

Šablona byla sestavena na macOS. Běh na Linuxu a Windows zatím nebyl ověřen.

## Údaje a obsah práce

Všechny základní údaje vyplňte v `settings.tex`. Hodnota `project={DP}` volí diplomovou a `project={BP}` bakalářskou práci; `faculty={FP}` je výchozí nastavení fakulty. Doplňte oficiální názvy ústavu, názvy práce, jména, tituly, rok, abstrakty, klíčová slova a znění prohlášení podle aktuálních požadavků.

Text kapitol je v `chapters/`. Další kapitolu připojte v `main.tex` jediným `\input{chapters/nazev}`. Obrázky ukládejte do `figures/`, přílohy do `appendices/` a bibliografické záznamy do `references.bib`. Technické příklady v `chapters/examples.tex` a ukázkovou přílohu před odevzdáním nahraďte nebo odstraňte.

Oficiální zadání z IS VUT uložte jako `zadani.pdf` do kořene. Dokud chybí, výsledné PDF obsahuje výraznou náhradní stránku. Před veřejným sdílením konkrétní práce zkontrolujte osobní údaje v zadání i ostatních souborech.

## Struktura

```text
main.tex                   vstup dokumentu
settings.tex               údaje a přepnutí BP/DP
chapters/                  kapitoly práce
appendices/                přílohy
figures/                   vlastní obrázky
references.bib             bibliografie
fpthesis.cls, czplain.bst  převzatá technická sazba
tests/                     testy citačního stylu
build/                     generované výstupy
```

Číselné citace obsahují úpravy podle veřejného výkladu ČSN ISO 690:2022. Konkrétní pole, příklady, omezení a test citačního stylu jsou v [docs/CITATIONS.md](docs/CITATIONS.md). Původ převzatých souborů a místní odchylky popisuje [UPSTREAM.md](UPSTREAM.md).

Vzhled vychází z oficiálně zveřejněné [šablony FIT VUT](https://www.fit.vut.cz/study/theses/master-theses/.cs), upravené pro použití na FP. Nejde o schválenou šablonu Fakulty podnikatelské. Před odevzdáním ověřte aktuální požadavky v [předpisech FP VUT](https://www.fp.vut.cz/cs/pro-studenty/studijni-predpisy) a u vedoucího práce.
