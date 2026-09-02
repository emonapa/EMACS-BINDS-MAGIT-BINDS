## --Binds in EMACS--

## SAVING & OPENING
- Ctrl + X, Ctrl + S -> saves current file (save-buffer)
- Ctrl + X, Ctrl + F -> open file
- Ctrl + G -> cancel current command (escape)

- When switching buffers, the file is automatically saved if it was modified
- Ctrl + X, E -> generates / refreshes TAGS file for current project

-------------------------------------------------------------------------

## BUFFERS & WINDOWS
- Ctrl + X, Ctrl + B -> buffer list
- Ctrl + X, 1 -> keep only current window
- Ctrl + X, 0 -> close current window
- Ctrl + X, O / Ctrl + Tab -> switch to another window
- Ctrl + Shift + Tab -> switch to previous window
- Ctrl + X, k -> close current window without its buffer
- Ctrl + X, K -> close current window with its buffer

-------------------------------------------------------------------------

### Window navigation and management
- Ctrl + C, Left arrow -> move to the window on the left
- Ctrl + C, Right arrow -> move to the window on the right
- Ctrl + C, Up arrow -> move to the window above
- Ctrl + C, Down arrow -> move to the window below

- Ctrl + C, W, arrow -> swap the contents of the current window with the neighboring window in that direction
- Ctrl + C, W, D, arrow -> delete the neighboring window in that direction
- Ctrl + C, W, M -> maximize the current window / press again to restore the previous layout
- Ctrl + C, W, U -> restore the previous window layout (winner-undo)
- Ctrl + C, W, R -> redo the reverted window layout change (winner-redo)
- Ctrl + C, W, = -> balance the sizes of all windows

- Directional commands work with any number and arrangement of windows; they do not require a regular grid.
- If there is no window in the requested direction, focus stays in the current window.
- Deleting a window does not kill its buffer; it only stops displaying it.

-------------------------------------------------------------------------

## SELECTION & CLIPBOARD
- Ctrl + Space -> start selecting region, then move cursor
- Shift + arrows -> select text while moving
- Alt + W -> copy (to kill-ring)
- Ctrl + W -> cut
- Ctrl + Y -> paste (yank)
- Ctrl + A -> select whole buffer
- Alt + H -> select paragraph
- Alt + K -> delete paragraph

- Delete -> deletes character, or selected region without saving into kill-ring
- Backspace -> deletes character backwards, or selected region without saving into kill-ring
- Ctrl + K -> deletes from cursor to end of line without saving into kill-ring

-------------------------------------------------------------------------

## TEXT NAVIGATION
- Alt + F -> one word forward
- Alt + B -> one word backward
- Ctrl + S -> search forward (incremental search)
- Ctrl + R -> search backward

- If something is selected, Ctrl + S / Ctrl + R searches for the selected text directly

- Ctrl + V -> one screen forward
- Alt + V -> one screen backward

-------------------------------------------------------------------------

## HELM / FAST SEARCH AND OPEN
- Ctrl + C, H, F -> search files by pattern (regex) in current subtree
- Ctrl + C, H, D -> browse directories / files (Helm “find files”)
- Ctrl + C, H, R -> recently opened files
- Ctrl + C, H, S -> search by file contents (ripgrep)
- Ctrl + C, D -> duplicate current line or selected region

- Ctrl + C, H, T -> helm-projectile
- Ctrl + C, H, G, G -> helm-git-grep
- Ctrl + C, H, G, L -> helm-ls-git-ls
- Ctrl + C, H, A -> helm-org-agenda-files-headings

- In Helm find files:
  - Left arrow -> go one directory up
  - Right arrow -> open / persistent action

-------------------------------------------------------------------------

## SWITCHING BETWEEN BUFFERS
- Ctrl + X, Left arrow -> previous buffer (in history)
- Ctrl + X, Right arrow -> next buffer

-------------------------------------------------------------------------

## MULTIPLE CURSORS
- Ctrl + . -> add cursor to next match
- Ctrl + , -> add cursor to previous match
- Ctrl + Alt + . / , -> skip current match and continue
- Ctrl + C, Ctrl + , -> select all matches
- Ctrl + Shift + arrow down / up -> add another cursor one line down / up
- Ctrl + Shift + C, Ctrl + Shift + C -> edit multiple lines at once

-------------------------------------------------------------------------

## LINE EDITING
- Ctrl + Shift + Backspace -> delete whole line
- Ctrl + Q, ) -> insert literal character “)” (quoted insert; works similarly for other characters)
- Alt + p -> move current line up
- Alt + n -> move current line down

- Tab -> when text is selected, indent whole region right
- Shift + Tab -> when text is selected, indent whole region left

-------------------------------------------------------------------------

## UNDO / REDO
- Ctrl + ů -> Undo
- Ctrl + § -> Redo

-------------------------------------------------------------------------

## DIRED (INTERACTIVE FILE BROWSING)
- Ctrl + X, D -> open files and directories interactively (Dired)

- Ctrl + X, Ctrl + Q -> switch window into writable mode and rename files/directories
  - Ctrl + C, Ctrl + C -> confirm
  - Ctrl + C, Ctrl + K -> cancel

- Ctrl + X, Ctrl + F -> find file when I know exactly where it is

- R -> rename
- D -> delete (can be repeated multiple times and then confirmed)
- Shift + U -> panic, cancels what I want to delete
- X -> confirm

- g -> refresh dired
- Alt gr + A -> ~

- Left arrow -> go one directory up
- Right arrow -> open file / enter directory

-------------------------------------------------------------------------

## IDO
- Left arrow -> go one directory up
- Right arrow -> confirm selection
- IDO no longer auto-merges subdirectories

-------------------------------------------------------------------------

## COMMANDS
- Ctrl + X, T -> open new vertical window and terminal in it
- Ctrl + X, t -> open vterm below, if it exists reuse existing one
- Ctrl + J -> When I do not want the suggested option (the highlighted one)
- Ctrl + C, p -> turn on markdown livestream in second window
- Ctrl + C, c -> disabled, not used for org-capture

- M-x -> smex, better command menu
- Ctrl + C, Ctrl + C, M-x -> normal execute-extended-command

-------------------------------------------------------------------------

## VTERM
- Ctrl + X, t -> open vterm below, if it exists reuse existing one
- Ctrl + X, T -> open new vterm below with unique name
- Alt + W -> in vterm copy selected text
- Alt + W -> when nothing is selected, enable vterm-copy-mode

-------------------------------------------------------------------------

## EMACS LISP
- Ctrl + C, Ctrl + J -> eval-print-last-sexp

-------------------------------------------------------------------------

## PROGRAMMING
- Line numbers are enabled globally
- In vterm, dired and term line numbers are disabled
- Python:
  - uses 4 spaces
  - Tab does no smart magic
  - Enter does not autoindent
- C/C++:
  - indentation 4 spaces
  - style bsd
- Trailing whitespace is automatically deleted on save in most code modes
- Markdown does not delete two spaces at end of line, so hard breaks can be used

-------------------------------------------------------------------------

## MARKDOWN
- Ctrl + C, p -> markdown-live-preview-mode
- README.md opens as gfm-mode
- Markdown preview uses pandoc

-------------------------------------------------------------------------

## COQ / PROOF GENERAL
- Ctrl + C, Ctrl + Q, Ctrl + N -> proof-assert-until-point-interactive

-------------------------------------------------------------------------

## TAGS
- Ctrl + X, E -> create / refresh TAGS in current project
- takes files:
  - *.c
  - *.h
  - *.cpp
  - *.py
  - *.el

<br>
<br>

> ## --GIT (Magit in Emacs)--

### Basic terms:
- origin/main -> server version
- main        -> local version
- origin/test -> server version of branch test
- test        -> local version of branch test

--------------------------------------------------

### Init and remote:
1. create repo directory
2. Alt + X magit-init
3. files...
4. Ctrl+c, m, s -> magit-status
5. stage file (***s***) -> commit (***c c***)
6. add remote: ***M*** -> ***a*** -> name "origin" -> SSH URL
7. ***P u*** -> sets upstream to origin/main

--------------------------------------------------

### Connecting local repo with github:
1. magit status (Ctrl + c, m, s)
2. ***M*** (capital M)
3. ***a*** -> name, e.g. "origin", paste SSH URL // Remote set
4. ***P u***
5. confirm that it should set origin/main

--------------------------------------------------

### Opening Magit:
- Ctrl + C, m, s -> magit-status
- Ctrl + C, m, l -> magit-log

--------------------------------------------------

### Stage/commit:
- ***s***   -> stage file
- ***S***   -> stage all
- ***u***   -> unstage
- ***U***   -> unstage everything

- ***c c*** -> new commit
- ***c a*** -> amend (add staged changes to last commit)
- ***c w*** -> reword (change only last commit message)
- ***c f*** -> fixup commit
- ***v***   -> revert (undoes commit by creating a new commit)

--------------------------------------------------

### Branching:
- ***b b*** -> switch branch
- ***b c*** -> create new branch
- ***b u*** -> set upstream

--------------------------------------------------

### Push/pull/fetch:
- ***P u***  -> push to upstream
- ***P -f*** -> push --force-with-lease (only when remote did not change)
- ***f***    -> fetch
- ***F***    -> pull (fetch + merge/rebase)

--------------------------------------------------

### Rebase/merge:
- ***r u*** -> rebase onto upstream
- ***r m*** -> rebase onto specific branch
- ***r i*** -> interactive rebase (squash/fixup)
- ***r r*** -> continue (after conflict)
- ***r a*** -> abort

- ***m m*** -> merge
- ***m s*** -> squash merge (turns all commits into one commit)

--------------------------------------------------

### Reset:
- ***X h*** -> reset (hard) to another commit (locally, throws away changes)

--------------------------------------------------

### Stash:
- ***z z*** -> save stash
- ***z a*** -> apply latest stash
- ***z p*** -> pop (apply + delete stash)
- ***z l*** -> list stashes

--------------------------------------------------

### Conflicts (rebase/merge):
- ***E m*** -> Ediff Merge on file in Unmerged
- ***e*** -> in magit-status on file opens the file and starts smerge-ediff
- ***a***/***b*** -> choose version
- ***X c*** -> edit manually
- ***q***   -> quit Ediff
- (***s***) -> stage fixed file
- ***r r*** -> rebase continue

--------------------------------------------------

### Blame:
- M-x magit-blame (in opened file)
- ***n***/***p*** -> next/previous hunk
- ***RET*** -> jump to commit in log
- ***TAB*** -> line detail

--------------------------------------------------

### Rest:
- ***l l*** -> commit tree
- in magit-status ***Ctrl+Shift+Tab*** -> magit-section-cycle
- M-x + smerge-ediff -> starts proper ediff on opened diff file

--------------------------------------------------
### Rebase:
```text
r u -> 1.) take commits from some branch and insert them into the current branch
       2.) ediff the conflicts
       3.) r r
       4.) keep doing it until the conflicts disappear
       5.) then the "Unmerged into main (1)" window will remain until you merge it (no need to do it right away)
// if you don't merge, you can keep working however you want
// then switch to main, press (m m)
// optionally then in (l l) navigate to the first commit of all your potential commits,
// and then switch all the ones below to "squash" using (s)
```
- ***c w*** -> changes the message of the last commit  
- ***r a*** -> abort the entire rebase  
--------------------------------------------------
### Squashing commits in interactive rebase:
```text
r i -> rebase commits, merges commits together, most commonly a fix/rebase commit.
       in (l l) navigate to the commit you want to rebase, so that the TODO looks like this:
pick  1b886da "main message"
fixup a218acd "fix commit after (c f)"
// so that fixup is at the bottom
```
--------------------------------------------------
### The difference between merge and rebase is that merge creates a "bubble" and rebase does not:
**MERGE:**
```text
before:  main:    A---B----C
                       \
         feature:       D--E
               ...
after:   main:    A---B----C--M
                       \     /
         feature:       D--E
```
___________________________________________
**REBASE:**
```text
before:  main:    A---B----C
                       \
         feature:       D--E
               ...
after:   main:    A---B----C
                            \
         feature:            D'--E'
```
___________________________________________
**FF MERGE:**  
- can only be used if main is an ancestor of feature (feature is not behind)  
- git always tries to do this; if you want to force it, enable ***--ff-only*** during merge  
```text
before:  main:    A---B---C
                            \
         feature:            D'--E'
               ...
after:   main:    A---B---C--D'--E'
         feature:               E'
```
