## --Bindy v EMACSU--

## UKLÁDÁNÍ & OTEVŘENÍ
- Ctrl + X, Ctrl + S -> uloží aktuální soubor (save-buffer)
- Ctrl + X, Ctrl + F -> otevřít soubor
- Ctrl + G -> zrušit aktuální příkaz (escape)

- Při přepnutí bufferu se soubor automaticky uloží, pokud byl změněný
- Ctrl + X, E -> vygeneruje / refreshne TAGS soubor pro aktuální projekt

-------------------------------------------------------------------------

## BUFFERY & OKNA
- Ctrl + X, Ctrl + B -> seznam bufferů
- Ctrl + X, 1 -> ponechat jen aktuální okno
- Ctrl + X, 0 -> zavřít aktuální okno
- Ctrl + X, O / Ctrl + Tab -> přejít do jiného okna
- Ctrl + Shift + Tab -> přejít do předchozího okna
- Ctrl + X, k -> zavřít aktuální okno bez jeho bufferu
- Ctrl + X, K -> zavřít aktuální okno s jeho bufferem

-------------------------------------------------------------------------

## VÝBĚR & SCHRÁNKA
- Ctrl + Mezerník -> začni označovat oblast, pak hýbej kurzorem
- Shift + šipky -> označení textu za pochodu
- Alt + W -> kopírovat (do kill-ringu)
- Ctrl + W -> vyjmout (cut)
- Ctrl + Y -> vložit (yank)
- Ctrl + A -> označit celý buffer
- Alt + H -> označit paragraf
- Alt + K -> smazat paragraf

- Delete -> smaže znak, nebo označený region bez uložení do kill-ringu
- Backspace -> smaže znak zpět, nebo označený region bez uložení do kill-ringu
- Ctrl + K -> smaže od kurzoru do konce řádku bez uložení do kill-ringu

-------------------------------------------------------------------------

## NAVIGACE V TEXTU
- Alt + F -> o slovo vpřed
- Alt + B -> o slovo zpět
- Ctrl + S -> hledání dopředu (incremental search)
- Ctrl + R -> hledání dozadu

- Pokud je něco označené, Ctrl + S / Ctrl + R hledá rovnou označený text

- Ctrl + V -> o obrazovku dopředu
- Alt + V -> o obrazovku dozadu

-------------------------------------------------------------------------

## HELM / RYCHLÉ HLEDÁNÍ A OTEVŘENÍ
- Ctrl + C, H, F -> hledá soubory podle vzoru (regex) v aktuálním podstromu
- Ctrl + C, H, D -> procházení složek / souborů (Helm „find files“)
- Ctrl + C, H, R -> naposledy otevřené soubory (recent)
- Ctrl + C, H, S -> hledá podle obsahu souborů (ripgrep)
- Ctrl + C, D -> duplikuje aktuální řádek nebo označený region

- Ctrl + C, H, T -> helm-projectile
- Ctrl + C, H, G, G -> helm-git-grep
- Ctrl + C, H, G, L -> helm-ls-git-ls
- Ctrl + C, H, A -> helm-org-agenda-files-headings

- V Helm find files:
  - Šipka vlevo -> o adresář výš
  - Šipka vpravo -> otevřít / persistent action

-------------------------------------------------------------------------

## PŘEPÍNÁNÍ MEZI BUFFERY
- Ctrl + X, Levá šipka -> předchozí buffer (v historii)
- Ctrl + X, Pravá šipka -> následující buffer

-------------------------------------------------------------------------

## MULTIPLE CURSORS
- Ctrl + . -> přidej kurzor na další shodu
- Ctrl + , -> přidej kurzor na předchozí shodu
- Ctrl + Alt + . / , -> přeskoč aktuální shodu a pokračuj
- Ctrl + C, Ctrl + , -> označ všechny shody
- Ctrl + Shift + šipka dolů / nahoru -> přidá další kurzor o řádek níž / výš
- Ctrl + Shift + C, Ctrl + Shift + C -> editace více řádků najednou

-------------------------------------------------------------------------

## ÚPRAVY ŘÁDKŮ
- Ctrl + Shift + Backspace -> smazat celý řádek
- Ctrl + Q, ) -> vloží doslova znak „)“ (quoted insert; funguje analogicky i pro jiné znaky)
- Alt + p -> posune aktuální řádek nahoru
- Alt + n -> posune aktuální řádek dolů

- Tab -> když je označený text, odsadí celý region doprava
- Shift + Tab -> když je označený text, odsadí celý region doleva

-------------------------------------------------------------------------

## UNDO / REDO
- Ctrl + ů -> Undo
- Ctrl + § -> Redo

-------------------------------------------------------------------------

## DIRED (INTERAKTIVNÍ PROCHÁZENÍ SOUBORŮ)
- Ctrl + X, D -> otevře interaktivně soubory a složky (Dired)

- Ctrl + X, Ctrl + Q -> přepne okno do writable režimu a může přejmenovávat složky/soubory
  - Ctrl + C, Ctrl + C -> potvrďit
  - Ctrl + C, Ctrl + K -> zrušit

- Ctrl + X, Ctrl + F -> najdu si soubor o kterém vím kde přesně se nachází

- R -> rename
- D -> delete (můžu i víckrát a potom potvrdit)
- Shift + U -> panic, zruší co chci vymazat
- X -> potvrdit

- g -> refresh diredu
- Alt gr + A -> ~

- Šipka vlevo -> o adresář výš
- Šipka vpravo -> otevřít soubor / vstoupit do složky

-------------------------------------------------------------------------

## IDO
- Šipka vlevo -> o adresář výš
- Šipka vpravo -> potvrdit výběr
- IDO už automaticky neslučuje podsložky

-------------------------------------------------------------------------

## COMMANDY
- Ctrl + X, T -> otevře nové vertikální okno a v něm nový terminál
- Ctrl + X, t -> otevře dole vterm, pokud existuje tak použije existující
- Ctrl + J -> Pokud nechci doporučenou nabídku (tu zvýrazněnou)
- Ctrl + C, p -> Zapne markdown livestream v druhém okně
- Ctrl + C, c -> vypnuté, nepoužívá se pro org-capture

- M-x -> smex, lepší nabídka commandů
- Ctrl + C, Ctrl + C, M-x -> normální execute-extended-command

-------------------------------------------------------------------------

## VTERM
- Ctrl + X, t -> otevře dole vterm, pokud existuje tak použije existující
- Ctrl + X, T -> otevře dole nový vterm s unikátním jménem
- Alt + W -> ve vtermu zkopíruje označený text
- Alt + W -> když není nic označené, zapne vterm-copy-mode

-------------------------------------------------------------------------

## EMACS LISP
- Ctrl + C, Ctrl + J -> eval-print-last-sexp

-------------------------------------------------------------------------

## PROGRAMOVÁNÍ
- Číslování řádků je globálně zapnuté
- Ve vtermu, diredu a termu se číslování řádků vypíná
- Python:
  - používá 4 mezery
  - Tab nedělá žádnou chytrou magii
  - Enter neautoindentuje
- C/C++:
  - odsazení 4 mezery
  - styl bsd
- Automaticky se maže trailing whitespace při uložení ve většině code modů
- Markdown nemaže dvě mezery na konci řádku, aby šly používat hard breaky

-------------------------------------------------------------------------

## MARKDOWN
- Ctrl + C, p -> markdown-live-preview-mode
- README.md se otevírá jako gfm-mode
- Markdown preview používá pandoc

-------------------------------------------------------------------------

## COQ / PROOF GENERAL
- Ctrl + C, Ctrl + Q, Ctrl + N -> proof-assert-until-point-interactive

-------------------------------------------------------------------------

## TAGS
- Ctrl + X, E -> vytvoří / refreshne TAGS v aktuálním projektu
- bere soubory:
  - *.c
  - *.h
  - *.cpp
  - *.py
  - *.el

<br>
<br>

> ## --GIT (Magit v Emacsu)--

### Základní pojmy:
- origin/main -> serverová verze
- main        -> lokální verze
- origin/test -> serverová verze větve test
- test        -> lokální verze větve test

--------------------------------------------------

### Inicializace a remote:
1. vytvořit složku repa
2. Alt + X magit-init
3. soubory...
4. Ctrl+c, m, s -> magit-status
5. stage soubor (***s***) -> commit (***c c***)
6. přidat remote: ***M*** -> ***a*** -> jméno "origin" -> SSH URL
7. ***P u*** -> nastaví upstream na origin/main

--------------------------------------------------

### Propojení lokálního repa s githubem:
1. magit status (Ctrl + c, m, s)
2. ***M*** (velké M)
3. ***a*** -> jméno, např "origin", vložit SSH URL // Nastavený remote
4. ***P u***
5. potvrdit že to má nastavit jako origin/main

--------------------------------------------------

### Magit otevření:
- Ctrl + C, m, s -> magit-status
- Ctrl + C, m, l -> magit-log

--------------------------------------------------

### Stage/commit:
- ***s***   -> stage soubor
- ***S***   -> stage všechny
- ***u***   -> unstage
- ***U***   -> unstage vše

- ***c c*** -> nový commit
- ***c a*** -> amend (přidat staged změny k poslednímu commitu)
- ***c w*** -> reword (změnit jen zprávu posledního commitu)
- ***c f*** -> fixup commit
- ***v***   -> revert (vrátí commit vytvořením nového commitu)

--------------------------------------------------

### Branching:
- ***b b*** -> přepnout branch
- ***b c*** -> vytvořit novou branch
- ***b u*** -> nastavit upstream

--------------------------------------------------

### Push/pull/fetch:
- ***P u***  -> push do upstreamu
- ***P -f*** -> push --force-with-lease (jen když se remote nezměnil)
- ***f***    -> fetch
- ***F***    -> pull (fetch + merge/rebase)

--------------------------------------------------

### Rebase/merge:
- ***r u*** -> rebase na upstream
- ***r m*** -> rebase na konkrétní branch
- ***r i*** -> interactive rebase (squash/fixup)
- ***r r*** -> continue (po konfliktu)
- ***r a*** -> abort

- ***m m*** -> merge
- ***m s*** -> squash merge (ze všech commitů udělá jeden commit)

--------------------------------------------------

### Reset:
- ***X h*** -> reset (hard) na jiný commit (lokálně, zahazuje změny)

--------------------------------------------------

### Stash:
- ***z z*** -> uložit stash
- ***z a*** -> apply poslední stash
- ***z p*** -> pop (apply + smazat stash)
- ***z l*** -> list stashů

--------------------------------------------------

### Konflikty (rebase/merge):
- ***E m*** -> Ediff Merge na soubor v Unmerged
- ***e*** -> v magit-status na souboru otevře soubor a spustí smerge-ediff
- ***a***/***b*** -> vyber verzi
- ***X c*** -> manuálně edituj
- ***q***   -> ukončit Ediff
- (***s***) -> stage opravený soubor
- ***r r*** -> rebase continue

--------------------------------------------------

### Blame:
- M-x magit-blame (v otevřeném souboru)
- ***n***/***p*** -> další/předchozí hunk
- ***RET*** -> skočí na commit v logu
- ***TAB*** -> detail řádku

--------------------------------------------------

### Zbytek:
- ***l l*** -> strom commitů
- v magit-status ***Ctrl+Shift+Tab*** -> magit-section-cycle
- M-x + smerge-ediff -> pustí pořádný ediff na otevřeném diff souboru

--------------------------------------------------

### Rebase:
```text
r u -> 1.) vezmi commity z nějaké větve a vlož je do aktuální větve
       2.) ediffni konflikty
       3.) r r
       4.) dělat to dokud nezmizí konflikty
       5.) potom tam zůstane okno "Unmerged into main (1)" dokud to nemergnu (nemusím hned)

// pokud nemergnu, můžu pracovat dále jak chci
// potom přejít na main, dát (m m)
// přípádně potom v (l l) přejít na první commit našich všech případných commitů,
// a potom všechny spodní přepnout na "squash" pomocí (s)
```

- ***c w*** -> změní zprávu posledního commitu  
- ***r a*** -> abort celého rebase  

--------------------------------------------------

### Squash commitů v interactive rebase:
```text
r i -> rebase commitů, spojí dohromady commity, nejčastěji fix/rebase commit.
       najet v (l l) na commit který chci rebasnout, tak aby TODO vypadal takto:
pick  1b886da "main message"
fixup a218acd "fix commit po (c f)"
// tedy aby byl fixup dole
```

--------------------------------------------------

### Rozdíl mezi merge a rebase je, že merge vytváří "bublinu" a rebase ne:

**MERGE:**
```text
před:  main:    A---B----C
                     \
       feature:       D--E
             ...
po:    main:    A---B----C--M
                     \     /
       feature:       D--E
```

___________________________________________

**REBASE:**
```text
před:  main:    A---B----C
                     \
       feature:       D--E
             ...
po:    main:    A---B----C
                          \
       feature:            D'--E'
```

___________________________________________

**FF MERGE:**  
- lze použít jen pokud je main předek feature (feature není pozadu)  
- git se o to snaží vždy, pokud to chceš vynutit, tak při mergi zapnout ***--ff-only***  

```text
před:  main:    A---B---C
                          \
       feature:            D'--E'
             ...
po:    main:    A---B---C--D'--E'

       feature:                E'
```
