
## SAVING & OPENING
- Ctrl + X, Ctrl + S -> save the current file (save-buffer)
- Ctrl + X, Ctrl + F -> open file
- Ctrl + G -> cancel the current command (escape)

-------------------------------------------------------------------------

## BUFFERS & WINDOWS
- Ctrl + X, Ctrl + B -> list of buffers
- Ctrl + X, 1 -> keep only the current window
- Ctrl + X, 0 -> close the current window
- Ctrl + X, O / Ctrl + Tab -> switch to another window
- Ctrl + X, k -> close the current window and its buffer
- Ctrl + X, K -> close all other buffers (keep the current one)

-------------------------------------------------------------------------

## SELECTION & CLIPBOARD
- Ctrl + Space -> start marking a region, then move the cursor
- Shift + arrows -> mark text on the fly
- Alt + W -> copy (to kill ring)
- Ctrl + W -> cut
- Ctrl + Y -> paste (yank)
- Ctrl + A -> select the whole buffer

-------------------------------------------------------------------------

## TEXT NAVIGATION
- Alt + F -> forward by one word
- Alt + B -> backward by one word
- Ctrl + S -> search forward (incremental search)
- Ctrl + R -> search backward

- Ctrl + V -> one screen forward
- Alt + V -> one screen backward

-------------------------------------------------------------------------

## HELM / QUICK SEARCH AND OPEN
- Ctrl + C, H, F -> search files by pattern (regex) in the current subtree
- Ctrl + C, H, D -> browse folders/files (Helm “find files”)
- Ctrl + C, H, R -> recently opened files (recent)
- Ctrl + C, H, S -> search by file content (ripgrep)
- Ctrl + C, T -> open a new vertical window with a terminal
- Ctrl + C, D -> duplicate the current line (copy and paste it below)

-------------------------------------------------------------------------

## SWITCHING BETWEEN BUFFERS
- Ctrl + X, Left arrow -> previous buffer (in history)
- Ctrl + X, Right arrow -> next buffer

-------------------------------------------------------------------------

## MULTIPLE CURSORS
- Ctrl + . -> add a cursor to the next match
- Ctrl + , -> add a cursor to the previous match
- Ctrl + Alt + . / , -> skip the current match and continue
- Ctrl + C, Ctrl + , -> select all matches
- Ctrl + Shift + arrow down / up -> add another cursor one line down / up

-------------------------------------------------------------------------

## LINE EDITING
- Ctrl + Shift + Backspace -> delete the whole line
- Ctrl + Q, ) -> insert the literal character “)” (quoted insert; analogous for other characters)
- Alt + p -> move the current line up
- Alt + n -> move the current line down

-------------------------------------------------------------------------

## UNDO / REDO
- Ctrl + ů -> Undo
- Ctrl + § -> Redo

-------------------------------------------------------------------------

## DIRED (INTERACTIVE FILE BROWSING)
- Ctrl + X, D -> interactively open files and folders (Dired)

- Ctrl + X, Ctrl + Q -> switch the window into writable mode to rename folders/files  
  Ctrl + C, Ctrl + C -> confirm / Ctrl + C, Ctrl + K -> cancel

- Ctrl + X, Ctrl + F -> find a file whose exact location I know

- R -> rename  
- D -> delete (I can mark multiple and then confirm)  
- Shift + U -> panic, unmark what I wanted to delete  
- X -> confirm

- g -> refresh dired
- Alt gr + A -> ~

-------------------------------------------------------------------------

## COMMANDS
- Ctrl + J -> If I don’t want the recommended option (the highlighted one)





> ## --GIT (Magit in Emacs)--            

GIT (Magit in Emacs)

### Basic terms:
- origin/main -> server version
- main        -> local version
- origin/test -> server version of the test branch
- test        -> local version of the test branch

--------------------------------------------------

### Initialization and remote:
1.) create the repo folder  
2.) Alt + X magit-init  
3.) files...  
4.) Ctrl + c, m, s -> magit-status  
5.) stage a file (s) -> commit (c c)  
6.) add remote: ***M*** -> ***a*** -> name “origin” -> SSH URL  
7.) ***P u*** -> sets upstream to origin/main

--------------------------------------------------

### Connecting a local repo to GitHub:
1.) magit status (Ctrl + c, m, s)  
2.) ***M*** (capital M)  
3.) ***a*** -> name, e.g. “origin”, paste SSH URL // Remote set  
4.) ***P u***  
5.) confirm that it should set origin/main

--------------------------------------------------

### Stage/commit:
- ***s***   -> stage file  
- ***S***   -> stage all  
- ***u***   -> unstage  
- ***U***   -> unstage all  

- ***c c*** -> new commit  
- ***c a*** -> amend (add staged changes to the last commit)  
- ***c w*** -> reword (change only the last commit’s message)  
- ***c f*** -> fixup commit  
- ***v***   -> revert (reverts a commit by creating a new commit)

--------------------------------------------------

### Branching:
- ***b b*** -> switch branch  
- ***b c*** -> create a new branch  
- ***b u*** -> set upstream

--------------------------------------------------

### Push/pull/fetch:
- ***P u***  -> push to upstream  
- ***P -f*** -> push --force-with-lease (only if the remote hasn’t changed)  
- ***f***    -> fetch  
- ***F***    -> pull (fetch + merge/rebase)

--------------------------------------------------

### Rebase/merge:
- ***r u*** -> rebase onto upstream  
- ***r m*** -> rebase onto a specific branch  
- ***r i*** -> interactive rebase (squash/fixup)  
- ***r r*** -> continue (after conflict)  
- ***r a*** -> abort  

- ***m m*** -> merge  
- ***m s*** -> squash merge (turn all commits into a single commit)

--------------------------------------------------

### Reset:
- ***X h*** -> reset (hard) to another commit (locally, discards changes)

--------------------------------------------------

### Stash:
- ***z z*** -> save stash  
- ***z a*** -> apply the last stash  
- ***z p*** -> pop (apply + remove the top stash)  
- ***z l*** -> list stashes

--------------------------------------------------

### Conflicts (rebase/merge):
- ***E m*** -> Ediff Merge on a file in Unmerged  
- ***a***/***b*** -> choose a side  
- ***X c*** -> edit manually  
- ***q***   -> exit Ediff  
- (***s***) -> stage the fixed file  
- ***r r*** -> rebase continue

--------------------------------------------------

### Blame:
- M-x magit-blame (in the open file)  
- ***n***/***p*** -> next/previous hunk  
- RET -> jump to the commit in Magit log  
- TAB -> detail for the line

--------------------------------------------------

### The rest:
- ***l l*** -> commit tree  
- in magit-status Ctrl + Shift + Tab -> magit-section-cycle  
- M-x + smerge-ediff -> launch a proper ediff on the open diff file

--------------------------------------------------

### Rebase:
```text
r u -> 1.) take commits from some branch and insert them into the current branch  
       2.) ediff the conflicts  
       3.) r r  
       4.) do it until conflicts disappear  
       5.) then the window "Unmerged into main (1)" will remain until I merge (I don’t have to immediately)

// if I don’t merge, I can continue working as I want  
// then switch to main, do (m m)  
// optionally then in (l l) go to the first commit of all our possible commits,  
// and then switch all the ones below to "squash" using (s)
```

***c w*** -> change the last commit’s message  
***r a*** -> abort the entire rebase

--------------------------------------------------

### Squashing commits in interactive rebase:
```text
r i -> rebase commits, merge commits together, most often a fix/rebase commit.  
       move in (l l) to the commit I want to rebase so that the TODO looks like this:  
pick  1b886da "main message"  
fixup a218acd "fix commit after (c f)"  
// so that the fixup is below
```
--------------------------------------------------

### The difference between merge and rebase is that merge creates a “bubble” and rebase does not:

**MERGE:**  
```
before:  main:    A---B----C  
                     \  
          feature:    D--E  
                ...  
after:   main:    A---B----C--M  
                     \     /  
          feature:    D--E 
```
___________________________________________

**REBASE:**  
```
before:  main:    A---B----C  
                     \  
          feature:    D--E  
                ...  
after:   main:    A---B----C  
                          \  
          feature:         D'--E'
```
___________________________________________

**FF MERGE:**  
- can be used only if main is the ancestor of feature (feature is not behind)  
- git always tries to do this; if I want to enforce it, enable --ff-only during merge

```
before:  main:    A---B---C  
                          \  
          feature:         D'--E'  
                ...  
after:   main:    A---B---C--D'--E'  
                                    
          feature:                 E'
```
--------------------------------------------------
