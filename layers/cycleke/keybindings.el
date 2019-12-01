(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key (kbd "C-M-\\") 'cycleke/indent-region-or-buffer)
(global-set-key (kbd "s-/") 'hippie-expand)
(global-set-key (kbd "C-c t i") 'cycleke/toggle-web-indent)

(add-hook 'c-mode
          (lambda ()
            (define-key [f5] 'cycleke/compile-without-debug)
            (define-key [f6] 'cycleke/compile-with-debug)))
(add-hook 'c++-mode
          (lambda ()
            (define-key [f5] 'cycleke/compile-without-debug)
            (define-key [f6] 'cycleke/compile-with-debug)))
(add-hook 'java-mode
          (lambda()
            (define-key [f5] 'cycleke/compile-without-debug)))
