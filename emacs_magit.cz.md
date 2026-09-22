## --Bindy v EMACSU--

## UKLÁDÁNÍ & OTEVŘENÍ
- Ctrl + x, Ctrl + s -> uloží aktuální soubor (save-buffer)
- Ctrl + x, Ctrl + f -> otevřít soubor
- Ctrl + g -> zrušit aktuální příkaz (escape)

- Při přepnutí bufferu se soubor automaticky uloží, pokud byl změněný

-------------------------------------------------------------------------

## BUFFERY & OKNA
- Ctrl + x, Ctrl + b -> seznam bufferů
- Ctrl + x, 1 -> ponechat jen aktuální okno
- Ctrl + x, 0 -> zavřít aktuální okno
- Ctrl + x, O / Ctrl + Tab -> přejít do jiného okna
- Ctrl + Shift + Tab -> přejít do předchozího okna
- Ctrl + x, k -> zavřít aktuální okno bez jeho bufferu
- Ctrl + x, K -> zavřít aktuální okno s jeho bufferem

-------------------------------------------------------------------------

### Pohyb a správa oken
- Ctrl + c, šipka vlevo -> přejít do okna vlevo
- Ctrl + c, šipka vpravo -> přejít do okna vpravo
- Ctrl + c, šipka nahoru -> přejít do okna nahoře
- Ctrl + c, šipka dolů -> přejít do okna dole

- Ctrl + c, w, šipka -> prohodí obsah aktuálního okna se sousedním oknem v daném směru
- Ctrl + c, w, d, šipka -> smaže sousední okno v daném směru
- Ctrl + c, w, m -> maximalizuje aktuální okno na celou plochu / dalším stiskem obnoví původní rozložení
- Ctrl + c, w, u -> vrátí předchozí rozložení oken (winner-undo)
- Ctrl + c, w, r -> znovu provede vrácenou změnu rozložení (winner-redo)
- Ctrl + c, w, = -> vyrovná velikosti všech oken

- Směrové příkazy fungují obecně pro libovolný počet a rozložení oken, nemusí jít o pravidelnou mřížku.
- Pokud v daném směru žádné okno není, směrový pohyb zůstane v aktuálním okně.
- Smazání okna nezabije jeho buffer, pouze ho přestane zobrazovat.

-------------------------------------------------------------------------

## VÝBĚR & SCHRÁNKA
- Ctrl + Mezerník -> začni označovat oblast, pak hýbej kurzorem
- Shift + šipky -> označení textu za pochodu
- Alt + w -> kopírovat (do kill-ringu)
- Ctrl + w -> vyjmout (cut)
- Ctrl + y -> vložit (yank)
- Ctrl + a -> označit celý buffer
- Alt + h -> označit paragraf
- Alt + k -> smazat paragraf

- Delete -> smaže znak, nebo označený region bez uložení do kill-ringu
- Backspace -> smaže znak zpět, nebo označený region bez uložení do kill-ringu
- Ctrl + k -> smaže od kurzoru do konce řádku bez uložení do kill-ringu

-------------------------------------------------------------------------

## NAVIGACE V TEXTU
- Alt + f -> o slovo vpřed
- Alt + b -> o slovo zpět
- Ctrl + s -> hledání dopředu (incremental search)
- Ctrl + r -> hledání dozadu

- Pokud je něco označené, Ctrl + s / Ctrl + r hledá rovnou označený text

- Ctrl + v -> o obrazovku dopředu
- Alt + v -> o obrazovku dozadu

-------------------------------------------------------------------------

## HELM / RYCHLÉ HLEDÁNÍ A OTEVŘENÍ
- Ctrl + c, h, f -> hledá soubory podle vzoru (regex) v aktuálním podstromu
- Ctrl + c, h, d -> procházení složek / souborů (Helm „find files“)
- Ctrl + c, h, r -> naposledy otevřené soubory (recent)
- Ctrl + c, h, s -> hledá podle obsahu souborů (ripgrep)
- Ctrl + c, d -> duplikuje aktuální řádek nebo označený region

- Ctrl + c, h, t -> helm-projectile
- Ctrl + c, h, g, g -> helm-git-grep
- Ctrl + c, h, g, l -> helm-ls-git-ls
- Ctrl + c, h, a -> helm-org-agenda-files-headings

- V Helm find files:
  - Šipka vlevo -> o adresář výš
  - Šipka vpravo -> otevřít / persistent action

-------------------------------------------------------------------------

## PŘEPÍNÁNÍ MEZI BUFFERY
- Ctrl + x, Levá šipka -> předchozí buffer (v historii)
- Ctrl + x, Pravá šipka -> následující buffer

-------------------------------------------------------------------------

## MULTIPLE CURSORS
- Ctrl + . -> přidej kurzor na další shodu
- Ctrl + , -> přidej kurzor na předchozí shodu
- Ctrl + Alt + . / , -> přeskoč aktuální shodu a pokračuj
- Ctrl + c, Ctrl + , -> označ všechny shody
- Ctrl + Shift + šipka dolů / nahoru -> přidá další kurzor o řádek níž / výš
- Ctrl + Shift + c, Ctrl + Shift + c -> editace více řádků najednou

-------------------------------------------------------------------------

## ÚPRAVY ŘÁDKŮ
- Ctrl + Shift + Backspace -> smazat celý řádek
- Ctrl + q, ) -> vloží doslova znak „)“ (quoted insert; funguje analogicky i pro jiné znaky)
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
- Ctrl + x, d -> otevře interaktivně soubory a složky (Dired)

- Ctrl + x, Ctrl + q -> přepne okno do writable režimu a může přejmenovávat složky/soubory
  - Ctrl + c, Ctrl + c -> potvrďit
  - Ctrl + c, Ctrl + k -> zrušit

- Ctrl + x, Ctrl + f -> najdu si soubor o kterém vím kde přesně se nachází

- r -> rename
- d -> delete (můžu i víckrát a potom potvrdit)
- Shift + u -> panic, zruší co chci vymazat
- x -> potvrdit

- g -> refresh diredu
- Alt gr + a -> ~

- Šipka vlevo -> o adresář výš
- Šipka vpravo -> otevřít soubor / vstoupit do složky

- /ssh:user@server:/cesta -> připojení dired na ssh

-------------------------------------------------------------------------

## IDO
- Šipka vlevo -> o adresář výš
- Šipka vpravo -> potvrdit výběr
- IDO už automaticky neslučuje podsložky

-------------------------------------------------------------------------

## COMMANDY
- Ctrl + j -> Pokud nechci doporučenou nabídku (tu zvýrazněnou)

- M-x -> smex, lepší nabídka commandů
- M-Shift-: -> eval
- Ctrl + c, Ctrl + c, M-x -> normální execute-extended-command

-------------------------------------------------------------------------

## VTERM
- Ctrl + x, t -> otevře nové vertikální okno a v něm nový terminál
- Alt + w -> ve vtermu zkopíruje označený text
- Alt + w -> když není nic označené, zapne vterm-copy-mode

-------------------------------------------------------------------------

## MARKDOWN
- Ctrl + c, p -> markdown-live-preview-mode

-------------------------------------------------------------------------

## TAGS
- Ctrl + x, e -> vytvoří / refreshne TAGS v aktuálním projektu vedle .git
- bere soubory:
  - *.c
  - *.h
  - *.cpp
  - *.py
  - *.el
  - *.inc
  - ignoruje soubory podle .gitignore

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
2. Alt + x magit-init
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
- Ctrl + c, m, s -> magit-status
- Ctrl + c, m, l -> magit-log

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
- ***r i*** -> interactive rebase (squash/fixup), následně -force push
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
