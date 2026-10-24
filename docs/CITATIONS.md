# Citace a bibliografie

Šablona používá klasický BibTeX, příkaz `\cite` a místní styl `czplain.bst`. Výsledkem jsou číselné odkazy a soupis v pořadí prvního odkazu v textu. Jde o konkrétní úpravy podle veřejného výkladu ČSN ISO 690:2022, nikoli o certifikaci úplného souladu pro každý druh dokumentu.

Veřejné podklady: [záznam ČSN ISO 690:2022 u České agentury pro standardizaci](https://csnonline.agentura-cas.cz/Detailnormy.aspx?k=515901) a [veřejný výklad Citace.com](https://www.citace.com/CSN-ISO-690/vyklad). Plné znění normy ani cizí výklad nejsou součástí repozitáře.

## Zápis zdrojů

- `author` a `editor` zapisujte ve formátu BibTeXu s jednotlivými osobami oddělenými slovem `and`. Korporativního autora uzavřete do dvojitých složených závorek, například `author = {{The LaTeX Project}}`.
- Pro elektronický zdroj použijte `howpublished = {Online}` a `cited = {RRRR-MM-DD}`. U typů `article`, `inproceedings` a `misc` lze použít `doi` místo `url`; styl vytvoří adresu `https://doi.org/…`. U online knihy (`book`) je nutné `url`, například `url = {https://doi.org/10.…}`: tato převzatá větev pole `doi` samostatně nezpracovává.
- Kniha běžně používá `title`, `edition`, `address`, `publisher`, `year` a `isbn`.
- Článek používá `journal`, `year`, `volume`, `number` a `pages`; konferenční příspěvek navíc `booktitle` a podle skutečných metadat `editor`. Převzatý styl doplňuje k čistě číselným hodnotám `volume` a `number` české zkratky. U cizojazyčného zdroje proto zapište označení výslovně, například `volume = {vol. 27}` a `number = {no. 2}`.
- Vyplňujte jen ověřené údaje. Nepřidávejte fiktivní vydání, ISBN ani datum jen kvůli umlčení varování staršího stylu.

Soubor `references.bib` obsahuje reálné ukázky knihy, článku, konferenčního příspěvku a webové dokumentace. Všechny jsou citovány v `chapters/examples.tex`, včetně opakované a vícenásobné citace.

## Test citačního stylu

`tests/citations.bib` obsahuje výslovně syntetická testovací data. Automatickou kontrolu spusťte z kořene:

```sh
perl tests/check-citations.pl
```

Skript používá pouze moduly dodávané s Perlem, spustí latexmk a zkontroluje výsledné `.bbl`, `.aux` a přesnou sadu známých varování v `.blg`. Kontroluje syntetickou testovací sadu, nikoli bibliografii vaší práce. Samotný překlad testovací sady lze spustit také přímo:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/tests tests/citations.tex
```

Očekávané pořadí položek v `build/tests/citations.bbl` i PDF je:

1. `zeta-book`,
2. `alpha-article`,
3. `corporate-web`,
4. `conference-editors`,
5. `many-authors`,
6. `online-book`,
7. `dated-web`.

Test ověřuje pořadí prvního výskytu proti abecednímu řazení, opakovanou citaci, vícenásobný `\cite`, plná jména, korporativního autora, zkrácení seznamu více než pěti autorů pomocí `et al.`, editory, typy `book`, `article`, `inproceedings` a `misc`, označení `Online`, DOI, URL a datum citování. Vygenerovaný soubor musí obsahovat zejména tyto rozlišitelné výsledky:

- `zeta-book`: `Zkušební, Zuzana` a `Druhý, Bohumil`;
- `alpha-article`: `Example, Alice`, `Pokusný, Bedřich`, dále název, `Online`, časopis, rok, DOI a datum citování v tomto pořadí;
- `corporate-web`: jediného autora `Korporace pro testování stylu` a pořadí název, `Online`, `In: Testovací web`, URL a datum citování;
- `conference-editors`: autora `Konferenční, Cyril`, editory `První, Edita` a `Druhý, Emil` a pořadí název, `Online`, sborník, rok, DOI a datum citování;
- `many-authors`: prvních pět plných jmen a `et al.`, bez šestého jména `Františka Šestá`.
- `online-book`: název, `Online`, rok, resolver z pole `url` a datum citování;
- `dated-web`: název, `Online`, hostitelský web, publikační datum `3. února 2024`, URL a datum citování.

Známá varování jsou věcným omezením převzatého BST: vyžaduje `edition` také u článku, požaduje ISBN nebo ISSN u konferenčního příspěvku a u nedatované online položky hlásí chybějící rok či revizi. Testovací překlad má přesně tato čtyři varování:

```text
Warning--empty edition in alpha-article
Warning--empty year in corporate-web
Warning--empty year and revised in corporate-web
Warning--empty isbn and issn in conference-editors
```

Výchozí ukázková bibliografie má ze stejných důvodů přesně tato čtyři varování:

```text
Warning--empty year in latex-docs
Warning--empty year and revised in latex-docs
Warning--empty edition in knuth1984
Warning--empty isbn and issn in grobid2009
```

U ukázky `grobid2009` je záměrně uveden DOI konkrétního příspěvku místo ISBN celého sborníku; ISBN je dostupné, nejde o chybějící údaj ve zdroji. Převzatý styl přesto ISBN nebo ISSN vyžaduje. U vaší bibliografie se počet a povaha varování mohou lišit. Ostatní varování je třeba posoudit, ne plošně ignorovat.
