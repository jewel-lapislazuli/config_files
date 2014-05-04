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
