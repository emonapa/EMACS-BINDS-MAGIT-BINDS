## --Keybindings in EMACS--

## SAVING & OPENING
- Ctrl + x, Ctrl + s -> saves the current file (save-buffer)
- Ctrl + x, Ctrl + f -> open file
- Ctrl + g -> cancel the current command (escape)

- When switching buffers, the file is automatically saved if it was modified

-------------------------------------------------------------------------

## BUFFERS & WINDOWS
- Ctrl + x, Ctrl + b -> buffer list
- Ctrl + x, 1 -> keep only the current window
- Ctrl + x, 0 -> close the current window
- Ctrl + x, O / Ctrl + Tab -> move to another window
- Ctrl + Shift + Tab -> move to the previous window
- Ctrl + x, k -> close the current window without killing its buffer
- Ctrl + x, K -> close the current window together with its buffer

-------------------------------------------------------------------------

### Window movement and management
- Ctrl + c, left arrow -> move to the window on the left
- Ctrl + c, right arrow -> move to the window on the right
- Ctrl + c, up arrow -> move to the window above
- Ctrl + c, down arrow -> move to the window below

- Ctrl + c, w, arrow -> swaps the contents of the current window with the neighboring window in the given direction
- Ctrl + c, w, d, arrow -> deletes the neighboring window in the given direction
- Ctrl + c, w, m -> maximizes the current window to the full frame / pressing again restores the previous layout
- Ctrl + c, w, u -> restores the previous window layout (winner-undo)
- Ctrl + c, w, r -> reapplies the reverted window layout change (winner-redo)
- Ctrl + c, w, = -> equalizes the sizes of all windows

- Directional commands work generally for any number and arrangement of windows; they do not need to form a regular grid.
- If there is no window in the given direction, directional movement stays in the current window.
- Deleting a window does not kill its buffer, it only stops displaying it.

-------------------------------------------------------------------------

## SELECTION & CLIPBOARD
- Ctrl + Space -> start selecting a region, then move the cursor
- Shift + arrows -> select text while moving
- Alt + w -> copy (to the kill ring)
- Ctrl + w -> cut
- Ctrl + y -> paste (yank)
- Ctrl + a -> select the whole buffer
- Alt + h -> select paragraph
- Alt + k -> delete paragraph

- Delete -> deletes a character, or the selected region without saving it to the kill ring
- Backspace -> deletes a character backward, or the selected region without saving it to the kill ring
- Ctrl + k -> deletes from the cursor to the end of the line without saving it to the kill ring

-------------------------------------------------------------------------

## TEXT NAVIGATION
- Alt + f -> one word forward
- Alt + b -> one word backward
- Ctrl + s -> search forward (incremental search)
- Ctrl + r -> search backward

- If something is selected, Ctrl + s / Ctrl + r immediately searches for the selected text

- Ctrl + v -> one screen forward
- Alt + v -> one screen backward

-------------------------------------------------------------------------

## HELM / QUICK SEARCH AND OPEN
- Ctrl + c, h, f -> searches for files by pattern (regex) in the current subtree
- Ctrl + c, h, d -> browse directories / files (Helm "find files")
- Ctrl + c, h, r -> recently opened files
- Ctrl + c, h, s -> searches by file contents (ripgrep)
- Ctrl + c, d -> duplicates the current line or selected region

- Ctrl + c, h, t -> helm-projectile
- Ctrl + c, h, g, g -> helm-git-grep
- Ctrl + c, h, g, l -> helm-ls-git-ls
- Ctrl + c, h, a -> helm-org-agenda-files-headings

- In Helm find files:
  - Left arrow -> one directory up
  - Right arrow -> open / persistent action

-------------------------------------------------------------------------

## SWITCHING BETWEEN BUFFERS
- Ctrl + x, Left arrow -> previous buffer (in history)
- Ctrl + x, Right arrow -> next buffer

-------------------------------------------------------------------------

## MULTIPLE CURSORS
- Ctrl + . -> add cursor at the next match
- Ctrl + , -> add cursor at the previous match
- Ctrl + Alt + . / , -> skip the current match and continue
- Ctrl + c, Ctrl + , -> select all matches
- Ctrl + Shift + down / up arrow -> add another cursor one line below / above
- Ctrl + Shift + c, Ctrl + Shift + c -> edit multiple lines at once

-------------------------------------------------------------------------

## LINE EDITING
- Ctrl + Shift + Backspace -> delete the whole line
- Ctrl + q, ) -> inserts the character ")" literally (quoted insert; works analogously for other characters)
- Alt + p -> move the current line up
- Alt + n -> move the current line down

- Tab -> when text is selected, indent the whole region to the right
- Shift + Tab -> when text is selected, indent the whole region to the left

-------------------------------------------------------------------------

## UNDO / REDO
- Ctrl + ů -> Undo
- Ctrl + § -> Redo

-------------------------------------------------------------------------

## DIRED (INTERACTIVE FILE BROWSING)
- Ctrl + x, d -> opens files and directories interactively (Dired)

- Ctrl + x, Ctrl + q -> switches the window into writable mode and allows renaming directories/files
  - Ctrl + c, Ctrl + c -> confirm
  - Ctrl + c, Ctrl + k -> cancel

- Ctrl + x, Ctrl + f -> find a file whose exact location I know

- r -> rename
- d -> delete (can be used multiple times and then confirmed)
- Shift + u -> panic, cancels what I want to delete
- x -> confirm

- g -> refresh Dired
- Alt gr + a -> ~

- Left arrow -> one directory up
- Right arrow -> open file / enter directory

- /ssh:user@server:/path -> connect dired to ssh
- Ctrl + o -> hides hidden files

-------------------------------------------------------------------------

## IDO
- Left arrow -> one directory up
- Right arrow -> confirm selection
- IDO no longer automatically merges subdirectories

-------------------------------------------------------------------------

## COMMANDS
- Ctrl + j -> If I do not want the recommended option (the highlighted one)

- M-x -> smex, better command menu
- M-Shift-: -> eval
- Ctrl + c, Ctrl + c, M-x -> normal execute-extended-command

-------------------------------------------------------------------------

## VTERM
- Ctrl + x, t -> opens a new vertical window and a new terminal in it
- Alt + w -> copies selected text in vterm
- Alt + w -> if nothing is selected, enables vterm-copy-mode

-------------------------------------------------------------------------

## MARKDOWN
- Ctrl + c, p -> markdown-live-preview-mode

-------------------------------------------------------------------------

## TAGS
- Ctrl + x, e -> creates / refreshes TAGS in the current project next to .git
- includes files:
  - *.c
  - *.h
  - *.cpp
  - *.py
  - *.el
  - *.inc
  - ignores files according to .gitignore

<br>
<br>

> ## --GIT (Magit in Emacs)--

### Basic terms:
- origin/main -> server version
- main        -> local version
- origin/test -> server version of branch test
- test        -> local version of branch test

--------------------------------------------------

### Initialization and remote:
1. create repository directory
2. Alt + x magit-init
3. files...
4. Ctrl+c, m, s -> magit-status
5. stage file (***s***) -> commit (***c c***)
6. add remote: ***M*** -> ***a*** -> name "origin" -> SSH URL
7. ***P u*** -> sets upstream to origin/main

--------------------------------------------------

### Connecting a local repository to GitHub:
1. magit status (Ctrl + c, m, s)
2. ***M*** (capital M)
3. ***a*** -> name, e.g. "origin", insert SSH URL // Remote configured
4. ***P u***
5. confirm that it should be set as origin/main

--------------------------------------------------

### Opening Magit:
- Ctrl + c, m, s -> magit-status
- Ctrl + c, m, l -> magit-log

--------------------------------------------------

### Stage/commit:
- ***s***   -> stage file
- ***S***   -> stage all
- ***u***   -> unstage
- ***U***   -> unstage all

- ***c c*** -> new commit
- ***c a*** -> amend (add staged changes to the last commit)
- ***c w*** -> reword (change only the last commit message)
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
- ***P -f*** -> push --force-with-lease (only if remote has not changed)
- ***f***    -> fetch
- ***F***    -> pull (fetch + merge/rebase)

--------------------------------------------------

### Rebase/merge:
- ***r u*** -> rebase onto upstream
- ***r m*** -> rebase onto a specific branch
- ***r i*** -> interactive rebase (squash/fixup), followed by force push
- ***r r*** -> continue (after conflict)
- ***r a*** -> abort

- ***m m*** -> merge
- ***m s*** -> squash merge (turns all commits into one commit)

--------------------------------------------------

### Reset:
- ***X h*** -> reset (hard) to another commit (locally, discards changes)

--------------------------------------------------

### Stash:
- ***z z*** -> save stash
- ***z a*** -> apply the latest stash
- ***z p*** -> pop (apply + delete stash)
- ***z l*** -> list stashes

--------------------------------------------------

### Conflicts (rebase/merge):
- ***E m*** -> Ediff Merge on a file in Unmerged
- ***e*** -> in magit-status on a file, opens the file and starts smerge-ediff
- ***a***/***b*** -> choose version
- ***X c*** -> edit manually
- ***q***   -> quit Ediff
- (***s***) -> stage the fixed file
- ***r r*** -> rebase continue

--------------------------------------------------

### Blame:
- M-x magit-blame (in an open file)
- ***n***/***p*** -> next/previous hunk
- ***RET*** -> jumps to the commit in the log
- ***TAB*** -> line details

--------------------------------------------------

### Misc:
- ***l l*** -> commit tree
- in magit-status ***Ctrl+Shift+Tab*** -> magit-section-cycle
- M-x + smerge-ediff -> starts a proper ediff on the open diff file

--------------------------------------------------

### Rebase:
```text
r u -> 1.) take commits from some branch and insert them into the current branch
       2.) ediff conflicts
       3.) r r
       4.) keep doing this until the conflicts disappear
       5.) then the "Unmerged into main (1)" window remains until I merge it (I do not have to do it immediately)

// if I do not merge, I can continue working however I want
// then switch to main, use (m m)
// optionally then in (l l) move to the first commit of all our possible commits,
// and then switch all the lower ones to "squash" using (s)
```

- ***c w*** -> changes the message of the last commit  
- ***r a*** -> abort the entire rebase  

--------------------------------------------------

### Squashing commits in interactive rebase:
```text
r i -> rebase commits, combines commits together, most commonly fix/rebase commit.
       in (l l), move to the commit I want to rebase so that TODO looks like this:
pick  1b886da "main message"
fixup a218acd "fix commit after (c f)"
// so that fixup is below
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
         feature:                E'
```
