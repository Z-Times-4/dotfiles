# LANG
export LANG=ja_JP.UTF-8
 
# KEYBIND
bindkey -v

# PROMPT {{{
PROMPT="%~:%c %n$ "
PROMPT2="> "
SPROMPT="%r is correct? [n,y,a,e]: "
RPROMPT='[`rprompt-git-current-branch`%F{cyan}%~%f]'
RPROMPT2="%K{green}%_%k"
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
## 入力が右端まで来たらRPROMPTを消す
setopt transient_rprompt


## ${fg[...]} や $reset_color をロード
autoload -U colors; colors

## gitのプロンプト用
function rprompt-git-current-branch {
local name st color
 
if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
return
fi
name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
if [[ -z $name ]]; then
return
fi
st=`git status 2> /dev/null`
if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
color=${fg[green]}
elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
color=${fg[yellow]}
elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
color=${fg_bold[red]}
else
color=${fg[red]}
fi

echo "%{$color%}$name%{$reset_color%} "
}
# }}}

# HISTORY {{{
## ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## すぐにヒストリファイルに追記する。
setopt inc_append_history
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ヒストリを共有
setopt share_history
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
## }}}

# 補完 {{{
autoload -Uz compinit
compinit
## The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
## 補完候補を一覧表示
setopt auto_list
## TAB で順に補完候補を切り替える
setopt auto_menu
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
## 補完候補の色づけ
if [ -f ~/.dircolors ]; then
  if type dircolors > /dev/null 2>&1; then
      eval $(dircolors ~/.dircolors)
  elif type gdircolors > /dev/null 2>&1; then
      eval $(gdircolors ~/.dircolors)
  fi
fi
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補を詰めて表示
setopt list_packed
## スペルチェック
setopt correct
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
# }}}

# 未分類 {{{
## 日本語ファイル名を表示可能にする
setopt print_eight_bit
## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## ビープを鳴らさない
setopt nobeep
# ビープ音の停止(補完時)
setopt nolistbeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## ディレクトリ名だけで cd
setopt auto_cd
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
#setopt NO_flow_control
## コマンドラインでも # 以降をコメントと見なす
#setopt interactive_comments

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# 高機能なワイルドカード展開を使用する
setopt extended_glob
# }}}


# PAGER {{{
if type lv > /dev/null 2>&1; then
## lvを優先する。
export PAGER="lv"
else
## lvがなかったらlessを使う。
export PAGER="less"
fi
 
if [ "$PAGER" = "lv" ]; then
## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
## -l: 1行が長くと折り返されていても1行として扱う。
## （コピーしたときに余計な改行を入れない。）
export LV="-c -l"
else
## lvがなくてもlvでページャーを起動する。
alias lv="$PAGER"
fi
# }}}

## go関連

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
eval "$(direnv hook zsh)"


## デフォルトエディタ設定
EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

case "$(uname)" in

    Darwin) # OSがMacならば
      export ZSH=/Users/z_times_4/.oh-my-zsh
      export XDG_CONFIG_PATH=~/.config
      export PATH="/Users/z_times_4/.local/bin:/Users/z_times_4/.nodebrew/current/bin:/Users/z_times_4/.nodebrew/current/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin/opt/homebrew-cask/Caskroom:$PATH"
      export PATH=$HOME/.nodebrew/current/bin:$PATH
      if [[ -d /Applications/MacVim.app ]]; then # MacVimが存在するならば
        alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
          alias vi=vim
      fi
      ;;
    Linux) # Linuxならば
      export ZSH=~/.oh-my-zsh
      export PATH=$HOME/local/bin:$HOME/.local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
      ;;

    *) ;; # OSがMac以外ならば何もしない
esac

## oh-my-zsh設定
plugins=(git ruby osx bundler brew rails emoji-clock)
ZSH_THEME="wedisagree"
source $ZSH/oh-my-zsh.sh
GREP_OPTIONS='--binary-files=without-match'
alias grep="grep $GREP_OPTIONS"


##alias設定
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

[ -s "/Users/z_times_4/.dnx/dnvm/dnvm.sh" ] && . "/Users/z_times_4/.dnx/dnvm/dnvm.sh" # Load dnvm
xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY 2> /dev/null
