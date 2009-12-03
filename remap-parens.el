;; Written 1994-08-09 by Noah Friedman <friedman@prep.ai.mit.edu>
;; Last modified 1995-01-05
;; Public domain.

(defun make-keyboard-translate-table (&optional size)
  "Create a table suitable as a keyboard translation table, and return it.
The initial contents is a direct mapping of index number to corresponding
character in whatever character set is being used.

Optional argument SIZE determines the size of the table.
By default the size is 128, which is large enough to handle all 7-bit ASCII
characters."
  (or size (setq size 128))
  (let ((tbl (make-string size 0))
        (i 1))
    (while (< i size)
      (aset tbl i i)
      (setq i (1+ i)))
    tbl))

(defun keyboard-swap-parens-brackets ()
  "Swap location of open/close parentheses and square brackets on keyboard.
This is useful for lisp programmers so that parens can be typed unshifted.

This is accomplished by altering the emacs `keyboard-translate-table', so
the change is only visible in emacs; other programs' windows are not affected.
The change can be undone with the command `keyboard-restore-parens-brackets'.

This command is ineffective in Lucid Emacs because it does not honor the
keyboard translate table when running in X."
  (interactive)
  (or keyboard-translate-table 
      (setq keyboard-translate-table (make-keyboard-translate-table)))
  (aset keyboard-translate-table ?\( ?\[)
  (aset keyboard-translate-table ?\) ?\])
  (aset keyboard-translate-table ?\[ ?\()
  (aset keyboard-translate-table ?\] ?\)))

(defun keyboard-restore-parens-brackets ()
  "Restore open/close parentheses and square brackets to their rightful place."
  (interactive)
  (cond 
   (keyboard-translate-table
    (aset keyboard-translate-table ?\( ?\()
    (aset keyboard-translate-table ?\) ?\))
    (aset keyboard-translate-table ?\[ ?\[)
    (aset keyboard-translate-table ?\] ?\]))))


(or (fboundp 'defalias)
    (fset 'defalias 'fset))

(defalias 'remap-parens 'keyboard-swap-parens-brackets)
(defalias 'restore-parens 'keyboard-restore-parens-brackets)

(provide 'remap-parens)

;; remap-parens.el ends here.
