## zsh環境設定
# zsh用ディレクトリの存在チェック
ZSH_CONFIG_DIR=$HOME/.zsh

if [ ! -e $ZSH_CONFIG_DIR ]; then
	mkdir $ZSH_CONFIG_DIR
fi

# Mac環境でのpath_helperの優先順位の変更
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
fi

# 言語環境
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# キーバインドをEmacsにする
bindkey -e

# 色の設定
autoload -U colors
colors

# 重複したPATHは登録しない
typeset -U PATH

# PATHの設定
PATH=/usr/local/bin:/usr/local/sbin:$PATH

# プロンプトの設定
PROMPT="[%n]%# "
RPROMPT="[%~] "

# ページャの設定
if type lv > /dev/null 2>&1 ; then
    export PAGER="lv"
fi


## cdrの設定(zaw-cdrとの連携用)
# 初期化
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both
# 移動したディレクトリの履歴ファイルの保存先
zstyle ':chpwd:*' recent-dirs-file $ZSH_CONFIG_DIR/chpwd-recent-dirs


## 補完関連の設定
# zshの補完機能を有効にする
autoload -U compinit
# zcompdumpの出力先を変更
compinit -d $ZSH_CONFIG_DIR/zcompdump
# 補完時に大文字、小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完機能のグループ化の設定
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ""
# 補完候補を選択できるようにする。補完結果が1つだけの場合はすぐに補完する。
zstyle ':completion:*:default' menu select=2


## 履歴関連の設定
# 履歴ファイルの保存先
export HISTFILE=$ZSH_CONFIG_DIR/zsh_history
# メモリ上に保持する履歴の数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の数
export SAVEHIST=10000
# 重複したコマンドは記録しない
setopt hist_ignore_all_dups
# 直前に同じコマンドを実行した場合は記録しない
setopt hist_ignore_dups
# コマンドを実行した時間と予想実行時間を記録
setopt extended_history
# 履歴の実行前に編集できるようにする
setopt hist_verify
# zsh間で履歴を共有
setopt share_history
# 履歴をHISTFILEにすぐ書き込む
setopt inc_append_history


## エイリアス関連の設定
# OSに合わせてlsの色付け設定
case ${OSTYPE} in
	darwin*)
	alias ls="ls -GF"
	;;
	linux*)
	alias ls="ls --color=auto"
	;;
esac

# 種々の設定
alias la="ls -a"
alias ll="ls -l"
alias rr="rm -rf"
alias emacs="emacs -nw"
alias grep="grep -n --binary-files=without-match --color=auto"
alias ag="ag --path-to-agignore=~/.agignore"

# Ctrl-^ で cd .. する
function cdup(){
	echo
	cd ..
	zle reset-prompt
}
zle -N cdup
bindkey '^\^' cdup

# 指定したディレクトリ配下を再帰的にgit pullする
function gitpull-r(){
    if [ $# -ne 1 ]; then
        echo "gitpull-r <directory>"
        return
    fi

    destdir=`ruby -e 'puts File.expand_path("#{ARGV[0]}")' $1`

    for gitdir in `find $destdir -name ".git" | sed -e s/\.git$//g`
    do  
        echo "== git pull results [$gitdir] =="
        git -C $gitdir pull
    done
}

## プログラミング言語関連の設定
# Perlのロケールの警告を表示させないようにする
export PERL_BADLANG=0

## rbenvの設定
# 初期化
if [ -e $HOME/.rbenv ]; then
	PATH=$HOME/.rbenv/bin:$PATH
	eval "$(rbenv init -)"
fi

## goenvの設定
if [ -e $HOME/.goenv ]; then
	PATH=$HOME/.goenv/bin:$PATH
	eval "$(goenv init -)"
fi

## nodebrewの設定
if [ -e $HOME/.nodebrew ]; then
	PATH=$HOME/.nodebrew/current/bin:$PATH
fi

## Caskの設定
# PATHへの追加
if [ -e $HOME/.cask ]; then
	PATH=$HOME/.cask/bin:$PATH
fi

## zawの設定
# 初期化
if [ -e $ZSH_CONFIG_DIR/zaw ]; then
	source $ZSH_CONFIG_DIR/zaw/zaw.zsh
	# 大文字・小文字を区別せずにフィルタリングする
	zstyle ':filter-select' case-insensitive yes
	# Ctrl-r でzaw-historyを呼び出す
	bindkey '^r' zaw-history
	# Ctrl-@ でzaw-kdrを呼び出す
	bindkey '^@' zaw-cdr
fi

## 個別設定
# 個別設定ファイル(.zsh_local)があれば読み込む
if [ -e $HOME/.zsh_local ]; then
	source $HOME/.zsh_local
fi
