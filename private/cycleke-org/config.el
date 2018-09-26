;; 解决org表格里面中英文对齐的问题
(when (configuration-layer/layer-usedp 'chinese)
  (when (and (spacemacs/system-is-mac) window-system)
    (spacemacs//set-monospaced-font "Source Code Pro for powerline" "Hiragino Sans GB" 14 16)))
;; Setting Chinese Font
(when (and (spacemacs/system-is-mswindows) window-system)
  (setq ispell-program-name "aspell")
  (setq w32-pass-alt-to-system nil)
  (setq w32-apps-modifier 'super)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Microsoft Yahei" :size 14))))
