# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=UTF8           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export LESSCHARSET=UTF-8


bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする


### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない


### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=20000            # メモリに保存されるヒストリの件数
SAVEHIST=20000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M viins '^F' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-forward

# すべてのヒストリを表示する
function history-all { history -E -D 1  }


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
 zstyle ':completion:*' verbose yes
 zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
 zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
 zstyle ':completion:*:warnings' format '%F{RED}No matches for:'%F{YELLOW} %d'$DEFAULT'
 zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
 zstyle ':completion:*:options' description 'yes'
 zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors  ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'


### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
    tmp_prompt="%B%U${tmp_prompt}%u%b"
    tmp_prompt2="%B%U${tmp_prompt2}%u%b"
    tmp_rprompt="%B%U${tmp_rprompt}%u%b"
    tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[yellow]}%}${HOST%%.*} ${PROMPT}"
;


### Title (user@hostname) ###
case "${TERM}" in
    kterm*|xterm*)
        preexec() {
            TMP_COMMAND=$1
            mycmd=(${(s: :)${1}})
            echo -ne "\033]0;${USER}@${HOST%%.*}:$mycmd[1]\007"
        }
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}\007"
        }
        ;;
esac

# ------------------------------
# Other Settings
# ------------------------------

### RVM ###
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

### Macports ###
case "${OSTYPE}" in darwin*)
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
    ;;
esac

function 256colortest(){
for code in {0..255}; do
    echo -e "\e[38;05;${code}m $code: Test"
done
}
function body(){
    tail -n +$1 | head -$((M-N+1)); 
}
function head_tail(){
    contents=`cat -`
    {
        echo $contents | head -n $1
        echo '...'
        echo $contents | tail -n $2 
    }
}

function mail_alart(){
    ##TODO: "| NOTE"の部分を消し去りたい
    if [ -p /dev/stdin ]; then
        export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
        if [ $# -gt 0 ]; then
            out=$1
        else
            out=/dev/tty
        fi
        tee -a $out | head_tail 10 10 | sed '1iCOMMAND:\n\t'${TMP_COMMAND}'\n\nCONTENTS:'  | nkf -w \
            | mail -s 'Complete Running Command' $EMAIL
    else
        echo 'Command\n'$TMP_COMMAND\
            | mail -s 'Complete Running Command' $EMAIL
    fi
}

today(){ echo `date +%Y%m%d` } 

if ! [[ -d ~/.zsh ]]; then
    mkdir ~/.zsh
fi
if [[ -d ~/.zsh/zsh-completions ]]; then
    fpath=(~/.zsh/zsh-completions/src $fpath)
else
    git clone https://github.com/zsh-users/zsh-completions.git  ~/.zsh/zsh-completions
    fpath=(~/.zsh/zsh-completions/src $fpath)
    rm -f ~/.zcompdump; compinit
fi

## for Python settings ##

### Aliases ###
alias r=rails
# alias python='python'
alias tmux='tmux -2'
alias v=vim
alias vi='vim -u NONE'
alias vtime="vim $HOME/.vim/.log --startuptime $HOME/.vim/.log -c '1,$delete' -c 'e! %'"
alias ls='ls -G --color -X'
alias sort="LC_ALL=C sort"
alias uniq="LC_ALL=C uniq"
alias less='less -IMx4 -X -R'
alias NOTE=mail_alart 
# alias -s py=python
alias -g L='| less'
#### Export Configurations #### 
export PATH="/usr/local/bin":$PATH
export LD_LIBRARY_PATH="/usr/local/lib":"/usr/lib/x86_64-linux-gnu/":$LD_LIBRARY_PATH
# export PYTHONPATH=$PYTHONPATH

if [ -f "$HOME/.zshrc_local" ]; then
    source $HOME/.zshrc_local
fi

if [ -e "$HOME/Dropbox" ]; then
    alias todo="$EDITOR ~\/Dropbox\/.todo"
else
    alias todo="$EDITOR ~\/.todo"
fi  

# cdコマンド実行後、lsを実行する
function cd() {
    builtin cd $@ && ls;
}

