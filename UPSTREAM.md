# Původ převzatých souborů

Technická sazba vychází z veřejné šablony závěrečných prací FIT VUT, dostupné z [oficiální české stránky](https://www.fit.vut.cz/study/theses/master-theses/.cs). Přímý odkaz na archiv byl dne 24. 10. 2026 `https://www.fit.vut.cz/study/theses/sablona.zip`; archiv obsahoval adresář `sablona/sablona2026`.

## Ověřené soubory

| Soubor | Původní SHA-256 | Stav v tomto projektu |
| --- | --- | --- |
| `fitthesis.cls` | `ed1263359181cfddfba217d97fb92bff451add18296acb50a82a4f63b834ce88` | místně upraven jako `fpthesis.cls` |
| `bib-styles/Pysny/czplain.bst` | `a899bc8a7d80f70a1c2d9d9281897d545a612876c5381aa0210abf13eb50df64` | vychází z něj místní opravený `czplain.bst` |
| černobílý symbol VUT | `230ad3d504e8103a17761f532c6f35298a05af21f5219fd2f155508a0f16d396` | převzat beze změny |
| barevný symbol VUT | `f04dbfb326dec1935f2be8befaf76b560c77a5d6ba168daa203052acd5b4febb` | převzat beze změny |

Místní `czplain.bst` má SHA-256 `579bf80476b856c966571cdd65f56d7e0fe504ef3782de678cda7fccbc0f0eaa`. Zachovává hlavičku původních autorů. Veřejná verze již uváděla úpravu pro ISO 690:2022 z dubna 2024; místní varianta navíc zachovává pořadí prvního odkazu místo abecedního řazení, vypisuje dostupná celá křestní jména, používá označení `Online` a mění pořadí některých údajů pro články, konferenční příspěvky a webové záznamy.

Třída zachovává původní autorskou hlavičku, mění název na `fpthesis`, používá zděděnou podporu fakulty FP a při chybějícím `zadani.pdf` načítá veřejnou neutrální náhradní stránku. Prázdné nepovinné tituly nevytvářejí přebytečné čárky a prázdné poděkování se nesází. Odstavec citace vlastní práce má místně nastavenou rezervu pro zalomení řádků. Cesty k logům zůstávají v `template-fig/`.

Archiv neobsahoval samostatný soubor s licencí. Původ je doložen, ale licenční podmínky třídy, stylu a grafik zůstávají před případným veřejným vydáním k ověření. Tento projekt proto nepřidává vlastní licenci ani netvrdí, že je otázka dalšího šíření vyřešena.
