(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
         ("\\.html\\'" . web-mode))
       auto-mode-alist))

(add-hook 'js2-mode 'flycheck-mode)
(add-hook 'c-mode 'flycheck-mode)
(add-hook 'c++-mode 'flycheck-mode)
(add-hook 'java-mode 'flycheck-mode)
(add-hook 'python-mode 'flycheck-mode)

(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             (setq tab-width 2)
             (setq indent-tabs-mode nil)
             (setq c-basic-offset 2)))

(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             ;;(c-toggle-auto-state)
             (setq tab-width 2)
             (setq indent-tabs-mode nil)
             (setq c-basic-offset 2)))

(add-hook 'java-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             (setq tab-width 2)
             (setq indent-tabs-mode nil)
             (setq c-basic-offset 2)))

(setq tab-width 2)
(setq default-tab-width 2)
(setq indent-tabs-mode nil)
(setq tab-stop-list ())

(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(setq-default ns-use-srgb-colorspace nil)
