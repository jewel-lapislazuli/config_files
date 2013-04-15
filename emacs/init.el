; load-pathの追加
(add-to-list 'load-path "~/.emacs.d/config")

; 言語を日本語にする
(set-language-environment 'Japanese)

; 極力UTF-8にする
(prefer-coding-system 'utf-8)

; Ctrl-hをバックスペースにする
(global-set-key (kbd "C-h") 'backward-delete-char)

; Ctrl-kで行全体を削除
(setq kill-whole-line t)

; Metaキーをoptionにする
(setq mac-option-modifier 'meta)

; インデントにタブを使わない
(setq-default indent-tabs-mode nil)

; インデント幅は4
(setq-default c-basic-offset 4)

; タブ幅は4
(setq-default tab-width 4)

; 対応する括弧を光らせる
(show-paren-mode 1)

; メニューバーを消す
(menu-bar-mode nil)

; バックアップファイルを作らない
(setq backup-inhibited t)

; 同名ファイルを開いたときにディレクトリ名を表示する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

; ファイル名の先頭に #! がある場合は実行権を付与する
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

; スペルチェックを行う
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")

;;; 補完
; 補完時に大文字、小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

; 括弧の補完
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

; 色の設定
(set-face-foreground 'font-lock-comment-face "SlateGray")
(set-face-foreground 'font-lock-string-face "SpringGreen3")
(set-face-foreground 'font-lock-keyword-face "IndianRed1")
(set-face-foreground 'font-lock-function-name-face "khaki1")
(set-face-foreground 'font-lock-variable-name-face "yellow")
(set-face-foreground 'font-lock-builtin-face "SteelBlue2")

; テンプレートの挿入
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templetes/")
(define-auto-insert "\\.py$" "python-templete.py")
(define-auto-insert "\\.rb$" "ruby-templete.rb")

; 追加パッケージに関する設定を読み込み
(load "packages")
