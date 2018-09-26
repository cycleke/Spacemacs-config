(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(delete-selection-mode t)
(global-auto-revert-mode t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(fset 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function 'ignore)

(require 'dired-x)
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(abbrev-mode t)
(define-abbrev-table
  'global-abbrev-table '(
                         ;; my name
                         ("7cy" "cycleke")
                         ))

(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect))

(setq tab-width 2)
(setq default-tab-width 2)
(setq indent-tabs-mode nil)
(setq tab-stop-list ())

(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(blink-cursor-mode -1)
(transient-mark-mode 1)

(electric-pair-mode t)
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(show-paren-mode t)
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))
(defun hidden-dos-eol ()
  "Don't show ^M in files containing mixed *UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with *UNIX eolns CR."
  (interactive)
  (goto-char (point-max))
  (while (search-forward "\r" nil t) (replace-match "")))
