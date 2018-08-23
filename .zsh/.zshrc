#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#        |''||''| '||'  |'  '|.   '|'  ..|'''.|  '||'  '|' '||''''|
#           ||     || .'     |'|   |  .|'     '   ||    |   ||  .
#           ||     ||'|.     | '|. |  ||    ....  ||    |   ||''|
#           ||     ||  ||    |   |||  '|.    ||   ||    |   ||
#          .||.   .||.  ||. .|.   '|   ''|...'|    '|..'   .||.....|
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# -----------------------------------------------------------------------------
#                                 PATH SETTINGS
# -----------------------------------------------------------------------------
#
# Local settings and styles can go here and (usually) overwrite
# things defined by me later.

PROFILE_STARTUP=${PROFILE_STARTUP:-false}
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof 
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>/tmp/startlog.zshrc.$$
    setopt xtrace prompt_subst
fi

path=(
    $HOME/.local/bin
    $HOME/.local/sbin
    "$path[@]"
)

manpath=(
    "$lmanpath[@]"
    ~/.zplug/doc/man
    /usr/share/man
    /usr/local/share/man
    "$manpath[@]"
)

ld_library_path=(
    "${(z)path:gs/bin/lib/}[@]"
    "${(z)path:gs/bin/lib64/}[@]"
)

path=( ${^path}(N-/) )
manpath=( ${^manpath}(N-/) )
ld_library_path=( ${^ld_library_path}(N-/) )

typeset -T LD_LIBRARY_PATH ld_library_path
typeset -gU path
typeset -gU manpath
typeset -gU ld_library_path

# -----------------------------------------------------------------------------
#                               PLUGIN SETTINGS
# -----------------------------------------------------------------------------
if [[ ! -d ~/.zgen ]]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
  zgen load zsh-users/zsh-history-substring-search
  zgen load k4rthik/git-cal
  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load junegunn/fzf shell/completion.zsh
  zgen load https://gist.github.com/aaeb57123ac97c649b34dfdc5f278b89.git

  # generate the init script from plugins above
  zgen save
fi

# -----------------------------------------------------------------------------
#                               GENERAL SETTINGS
# -----------------------------------------------------------------------------
export EDITOR=vim 
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=UTF8        # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export LESSCHARSET=UTF-8
# export GREP_OPTION="--color auto"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export GOPATH=$HOME/.go && [[ ! -d $GOPATH ]] && mkdir -p $GOPATH
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
if [[ ! -z $ZSH_HIGHLIGHT_STYLES ]] then
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=45'
fi

bindkey -v              # キーバインドをviモードに設定

setopt interactivecomments #
setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

autoload -Uz ls_abbrev

DIRSTACKSIZE=200
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
  ls_abbrev
}

### Autoloads ###
autoload -Uz add-zsh-hook
autoload -U colors; colors
autoload -Uz history-search-end
autoload -Uz vcs_info          # VCSの情報を表示する
autoload -Uz is-at-least
autoload -Uz replace-string
autoload -Uz exec-oneliner

autoload -U compinit
if [[ $(date +'%j') != $(stat -f '%Sm' -t '%j' $ZDOTDIR/.zcompdump) ]]; then
  compinit
else
  compinit -C
fi

if is-at-least 5.0.8; then
  autoload -Uz select-bracketed

  zle -N select-bracketed
  for m in visual viopp; do
      for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
      bindkey -M $m $c select-bracketed
      done
  done

  autoload -Uz select-quoted
  zle -N select-quoted
  for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
      bindkey -M $m $c select-quoted
    done
  done

  autoload -Uz surround
  zle -N delete-surround surround
  zle -N change-surround surround
  zle -N add-surround surround

  bindkey -a cs change-surround
  bindkey -a ds delete-surround
  bindkey -a ys add-surround
  bindkey -M visual S add-surround
fi

# -----------------------------------------------------------------------------
#                               KEY BINDINGS
# -----------------------------------------------------------------------------

autoload -Uz bindkey_function

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[kubectl] )) && source <(kubectl completion zsh)

# CTRL-T - Paste the selected file path(s) into the command line
if [[ -x `which fzf` ]]; then
  export FZF_COMPLETION_OPTS='+c -x'
  (( $+commands[ag] )) \
    && export FZF_DEFAULT_COMMAND='ag -g ""' \
    && _fzf_compgen_path() { ag -g "" "$1" }
  export FZF_DEFAULT_OPTS='
    --bind ctrl-f:page-down,ctrl-b:page-up
    --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
    --color info:183,prompt:110,spinner:107,pointer:167,marker:215
 '
  bindkey_function '^T' fzf-file-widget
  bindkey_function '^G' fzf-cd-widget
  bindkey_function '^R' fzf-history-widget
  bindkey_function '^X' exec-oneliner

  autoload -Uz fdr
  zle -N fdr
else 
  bindkey -M viins '^F' history-incremental-search-backward
fi


# # マッチしたコマンドのヒストリを表示できるようにする
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

bindkey_function '^O' replace-string
bindkey_function -M vicmd v edit-command-line
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

### Hooks ###
add-zsh-hook precmd vcs_info

### Complement ###
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

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

zstyle ':vcs_info:*' formats '(⭠ %b)'
zstyle ':vcs_info:*' actionformats '(%b:%a)'

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

# ### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=100000            # メモリに保存されるヒストリの件数
SAVEHIST=1000000            # 保存されるヒストリの件数
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt hist_ignore_space  # spaceから始まるコマンドは記録しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# すべてのヒストリを表示する
function history-all { history -E -D 1  }

# -----------------------------------------------------------------------------
#                             LOOK AND FEEL SETTINGS
# -----------------------------------------------------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
# export GREP_OPTIONS='--color=auto' 


# -----------------------------------------------------------------------------
#                                     OTHERS
# -----------------------------------------------------------------------------

[[ -z $LD_LIBRARY_PATH ]] && export LD_LIBRARY_PATH=${PATH:gs/bin/lib}

today(){ echo `date +%Y%m%d` } 

# ------------------------------
# Aliases
# ------------------------------
alias tmux='tmux -2'
# alias vi='vim -u NONE'
alias vtime="nvim  --startuptime $HOME/.vim/.log -c '1,$delete' -c 'e! $HOME/.vim/.log' "
case "$OSTYPE" in
    darwin*)
        alias ls='ls -G'
        (( $+commands[terminal-notifier])) && \
            alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
        ;;
    *)
        alias ls='ls --color=auto'
esac
# alias ztime="PROFILE_STARTUP=true zsh --login -c 'exit' && zsh_profile_decoder.py `ls -t ~/tmp/startlog* | head -n1` | sort -k2n | less"
alias less='less -IMx4 -X -R'
alias -g NL='>/dev/null'
alias rm='rm -i'
alias sort="LC_ALL=C sort"
alias uniq="LC_ALL=C uniq"
# alias -s py=python
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'

[[ -x `which nvim 2>/dev/null` ]]  && alias vim='nvim' && export EDITOR=nvim
[[ -x `which htop 2>/dev/null` ]]  && alias top='htop'
# [[ -x `which nvim 2>/dev/null` ]]  && alias vim='nvim'
(( $+commands[pygmentize] )) && alias c='pygmentize -O style=monokai -f console256 -g'
(( $+commands[hub] )) && alias git='hub'

# ------------------------------
# Functions
# ------------------------------
function man()
{
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[30;43m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

function sshcd()
{
    ssh $1 -t "cd `pwd`; zsh"
}

function cd() {
    if [[ $1 = "-" ]]; then
        shift;
        builtin cd `dirs -lp | uniq | fzf ` $@
    else
        builtin cd $@
    fi
}

function ssh() {
    local window_name=$(tmux display -p '#{window_name}')
    command ssh $@
    tmux rename-window $window_name
}

function frepo() {
    local dir
    if [ ! -z $TMUX ]; then
        FZF=fzf-tmux
    else
        FZF=fzf
    fi
    dir=$(ghq list > /dev/null | $FZF --reverse +m) &&
        cd $(ghq root)/$dir
}

function foreground-vi() {
    fg %$EDITOR
}
zle -N foreground-vi
bindkey '^Z' foreground-vi

zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

## Zbell configuration
zbell_duration=3
zbell_duration_email=300

function show_process_time_after_cmd(){
    local zbell_cmd_duration
    zbell_cmd_duration=$(( $EPOCHSECONDS - $zbell_timestamp ))
    [[ ${zbell_cmd_duration} -gt $zbell_duration ]] && echo "$zbell_cmd_duration s Elapsed"
}

add-zsh-hook precmd show_process_time_after_cmd

function memo_cmd(){  
    [[ -n ${TMUX_PANE} ]] && echo $1 > "${TMP:-/tmp}/tmux_pane_cmd_${TMUX_PANE}"
}

add-zsh-hook preexec memo_cmd

#### Export Configurations ####
export PYTHONSTARTUP=~/.pythonstartup

if [ -e "$HOME/Dropbox" ]; then
    alias todo="$EDITOR ~\/Dropbox\/.todo"
else
    alias todo="$EDITOR ~\/.todo"
fi

# ------------------------------
# Prompt Settings
# ------------------------------
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

get_myvcs_info()
{
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        # 0以外を返すとそれ以降のフック関数は呼び出されない
        return ''
    fi
    # root=$(git rev-parse --git-dir 2> /dev/null)

    # [[ -z ${root} ]] && echo '' && return
    # cd $root >/dev/null && cd ../ > /dev/null
    # branch=$(git diff --shortstat | sed -E -e 's/, / /g' -e 's/([0-9]*) insertions?\(\+\)/+\1/' -e 's/([0-9]*) deletions?\(-\)/-\1/' -e 's/ ([0-9]+) files? changed/📚 \1/')
    # echo "${branch}"
}

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

PROMPT="$tmp_rprompt\$vcs_info_msg_0_(\$(get_myvcs_info))
$tmp_prompt"    # 通常のプロンプト

PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT="\$(check_last_exit_code)"  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# For tmux powerline, to detect current directory setting
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && \
    PROMPT="
$tmp_rprompt\$vcs_info_msg_0_
%{${fg[yellow]}%}${HOST%%.*} $tmp_prompt"

# Entirety of my startup file... then
[[ -f ${HOME}/.local.zshenv ]] && source ${HOME}/.local.zshenv

# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi
