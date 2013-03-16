;; packges.elを使う
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Auto-complateの設定
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-auto-start t)

; C-n,C-pで補完候補を選択できるようにする
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

; 補完推測機能用ファイルのパス
(setq ac-comphist-file "~/.emacs.d/cache/ac-comphist.dat")

;; Anythingの設定
(require 'anything)
(require 'anything-config)

; anything-c-adaptive-historyのパス変更
(setq anything-c-adaptive-history-file
          "~/.emacs.d/cache/anything-c-adaptive-history")

; AnythingをCtrl+lで呼び出す
(global-set-key "\C-l" 'anything)

; EmacsのコマンドをAnything経由で呼び出せるようにする
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)
