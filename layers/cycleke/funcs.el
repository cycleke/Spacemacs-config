(require 'cl-lib)

(defun cycleke/compile-without-debug ()
  "Compile current buffer"
  (interactive)
  (let (filename suffix progname)
    (setq filename (file-name-nondirectory buffer-file-name))
    (setq progname (file-name-sans-extension filename))
    (setq suffix (file-name-extension filename))
    (if (string= suffix "c")
        (compile (concat "gcc " filename " -o " progname " -O2 -Wall -lm")))
    (if (or (string= suffix "cc") (string= suffix "cpp"))
        (compile (concat "g++ " filename " -o " progname " -O2 -Wall -lm -std=c++11")))
    (if (string= suffix "tex")
        (compile (concat "xelatex " filename)))
    ))
(defun cycleke/compile-with-debug ()
  "Compile current buffer"
  (interactive)
  (let (filename suffix progname)
    (setq filename (file-name-nondirectory buffer-file-name))
    (setq progname (file-name-sans-extension filename))
    (setq suffix (file-name-extension filename))
    (if (string= suffix "c")
        (compile (concat "gcc " filename " -o " progname " -g -Wall -lm")))
    (if (or (string= suffix "cc") (string= suffix "cpp"))
        (compile (concat "g++ " filename " -o " progname " -g -Wall -lm -std=c++11")))
    ))

(defun cycleke/indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))
(defun cycleke/indent-region-or-buffer ()
  "Indent a region of selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (cycleke/indent-buffer)
        (message "Indented the buffer.")))))

(defun cycleke/web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'cycleke/web-mode-indent-setup)

(defun cycleke/toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))
  (setq indent-tabs-mode nil))

(defconst default-elpa-mirror
  (concat user-home-directory "elpa-mirror"))
(defvar cycleke-configuration-elpa-mirror-path '()
  "List of additional paths where to look for configuration local mirrors.
Paths must have a trailing slash (ie. `~/.mycontribs/')")

(defun cycleke/load-local-mirror ()
  "Load local mirrors. This is for offline using."
  (interactive)
  (let* ((current-elpa-mirror-paths (mapcar (lambda (dir) (expand-file-name dir))
                                            (cl-pushnew
                                             default-elpa-mirror
                                             cycleke-configuration-elpa-mirror-path)))
         (other-choice "Another directory...")
         (helm-lp-source
          `((name . "Configuration ELPA Mirror Paths")
            (candidates . ,(append current-elpa-mirror-paths
                                   (list other-choice)))
            (action . (lambda (c) c))))
         (elpa-mirror-path-sel (if (configuration-layer/layer-used-p 'ivy)
                                   (ivy-read "Configuration ELPA Mirrors path: "
                                             (append current-elpa-mirror-paths
                                                     (list other-choice)))
                                 (helm :sources helm-lp-source
                                       :prompt "Configuration ELPA Mirrors path: ")))
         (elpa-mirror-path (cond
                            ((string-equal elpa-mirror-path-sel other-choice)
                             (read-directory-name (concat "Other configuration "
                                                          "ELPA Mirror path: ") "~/" ))
                            ((member elpa-mirror-path-sel current-elpa-mirror-paths)
                             elpa-mirror-path-sel)
                            (t
                             (error "Please select an option from the list")))))
    ;;(layer-dir (concat layer-path "/" name)))
    (setq configuration-layer-elpa-archives
          `(("melpa" . ,(concat elpa-mirror-path "melpa/"))
            ("org"   . ,(concat elpa-mirror-path "org/"))
            ("gnu"   . ,(concat elpa-mirror-path "gnu/"))))))
