;; Auto-complateの設定
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-auto-start t)

; C-n,C-pで補完候補を選択できるようにする
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n") 'ac-next)
(define-key ac-menu-map (kbd "C-p") 'ac-previous)

; 補完推測機能用ファイルのパス
(setq ac-comphist-file "~/.emacs.d/cache/ac-comphist.dat")


;; emacs-helmの設定
(require 'helm-config)

; helm用キーバインド
(global-set-key (kbd "C-c C-h") 'helm-mini)
(global-set-key (kbd "C-c C-c") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

; C-c C-cがpython-modeのキーバインドと重複しているので対処
(add-hook 'python-mode-hook
    (lambda ()
        (define-key python-mode-map (kbd "C-c C-c") 'nil)
        ))


; helmでコマンド補完をできるようにする
(helm-mode 1)

; helm中にCtrl-hを使えるようにする
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
     ))

; helmのファイルパス自動補完機能を無効にする
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
; TABで補完できるようにする。
; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

; scss-mode
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
  '(lambda() (scss-custom)))

; web-modeの設定
(require 'web-mode)

;;; 適用する拡張子
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))

;;; インデント数
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2))
(add-hook 'web-mode-hook 'web-mode-hook)
