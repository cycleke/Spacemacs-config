(setq irony-packages
      '(
        company-irony
        company-irony-c-headers
        irony
        irony-eldoc
        flycheck-irony))

(defun irony/init-irony ()
  (use-package irony
    :defer t
    :commands (irony-mode irony-install-server)
    :init
    (progn
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'c++-mode-hook 'irony-mode))
    :config
    (progn
      (setq irony-user-dir (f-slash (f-join user-home-directory "bin" "irony")))
      (setq irony-server-install-prefix irony-user-dir)
      (add-hook 'c++-mode-hook (lambda () (setq irony-additional-clang-options '("-std=c++11"))))
      (defun irony/irony-mode-hook ()
        (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
        (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))

      (add-hook 'irony-mode-hook 'irony/irony-mode-hook)
      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))))

(when (configuration-layer/layer-usedp 'auto-completion)
  (defun irony/init-company-irony ()
    (use-package company-irony
      :if (configuration-layer/package-usedp 'company)
      :defer t
      :commands company-irony
      :init
      (progn
        (eval-after-load 'company
          '(push 'company-irony company-backends-c-mode-common))
        ;;(add-to-list 'company-backends 'company-irony)
        (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)))))

(when (configuration-layer/layer-usedp 'auto-completion)
  (defun irony/init-company-irony-c-headers ()
    (use-package company-irony-c-headers
      :if (configuration-layer/package-usedp 'company)
      :defer t
      :commands company-irony-c-headers
      :init
      (push 'company-irony-c-headers company-backends-c-mode-common))))

(when (configuration-layer/layer-usedp 'syntax-checking)
  (defun irony/init-flycheck-irony ()
    (use-package flycheck-irony
      :if (configuration-layer/package-usedp 'flycheck)
      :defer t
      :init (add-hook 'irony-mode-hook 'flycheck-irony-setup))))

(defun irony/init-irony-eldoc ()
  (use-package irony-eldoc
    :commands (irony-eldoc)
    :init
    (add-hook 'irony-mode-hook 'irony-eldoc)))
