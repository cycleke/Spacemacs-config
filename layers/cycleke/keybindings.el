(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key [f5] 'cycleke/compile-without-debug)
(global-set-key [f6] 'cycleke/compile-with-debug)
(global-set-key (kbd "C-M-\\") 'cycleke/indent-region-or-buffer)
(global-set-key (kbd "s-/") 'hippie-expand)
(global-set-key (kbd "C-c t i") 'cycleke/toggle-web-indent)
