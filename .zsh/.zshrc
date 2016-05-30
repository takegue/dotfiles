
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
# ZSHENVで環境変数の設定を書くと ZSHRCを読み込む際に
# 勝手に順番を書き換えられるのでここで再度更新
path=(
    "$lpath[@]"
    $GOPATH/bin
    /usr/local/bin
    /usr/bin
    /usr/X11/bin
    /usr/bin/X11
    /usr/local/X11/bin
    /usr/local/games
    /usr/games
    /usr/lib/nagios/plugins
    "$fpath[@]"
    "$path[@]"
    "$PATH[@]"
    /bin
)

manpath=(
    "$lmanpath[@]"
    ~/.zplug/man
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
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi
source ~/.zplug/zplug

# Make sure you use double quotes
zplug "zsh-users/zsh-history-substring-search"
zplug "tcnksm/docker-alias", use:zshrc
zplug "k4rthik/git-cal", as:command
zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*$OSNAME:l*amd64*"
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "TKNGUE/aaeb57123ac97c649b34dfdc5f278b89", \
    from:gist
zplug "hchbaw/opp.zsh", if:"(( ${ZSH_VERSION%%.*} < 5 ))"
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
zplug "zsh-users/zsh-syntax-highlighting", nice:10
[[ ! -d ${ANYENV_ROOT} ]] && \
    zplug "riywo/anyenv", \
    hook-build:"ln -Fs \`pwd\` ${ANYENV_ROOT:=$HOME/.anyenv}"
[[ ! -d ${ANYENV_ROOT}/plugins ]] && \
    zplug "znz/anyenv-update", \
    on:"riywo/anyenv", \
    hook-build:"mkdir -p \${ANYENV_ROOT}/plugins && ln -Fs \`pwd\` \${ANYENV_ROOT}/plugins"
[[ -d ${ANYENV_ROOT}/envs/pyenv ]] && \
    zplug "yyuu/pyenv-virtualenv", \
    on:"riywo/anyenv", \
    hook-build:"mkdir -p \$ANYENV_ROOT/envs/pyenv/plugins && ln -fs \`pwd\` \$ANYENV_ROOT/envs/pyenv/plugins/pyenv-virtualenv" 
zplug "zsh-users/zsh-completions"
zplug "carsonmcdonald/tmux-wifi-os-x", \
    as:command, use:wifi-signal-strength, \
    if:"[[ $OSTYPE == *darwin* ]]"
zplug "thewtex/tmux-mem-cpu-load", \
    as:command, use:"tmux-mem-cpu-load", \
    hook-build:'cmake . && make'
zplug "$HOME/.zsh/plugins/fzf-tmux-widgets", from:local

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load --verbose

# -----------------------------------------------------------------------------
#                               GENERAL SETTINGS
# -----------------------------------------------------------------------------
if (( $commands['nvim'] ));then
    export EDITOR=nvim 
else
    export EDITOR=vim 
fi

export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=UTF8        # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export LESSCHARSET=UTF-8
export GREP_OPTION="--color auto"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export GOPATH=$HOME/.go && [[ ! -d $GOPATH ]] && mkdir -p $GOPATH
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
ZSH_HIGHLIGHT_STYLES[globbing]='fg=45'

bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

DIRSTACKSIZE=12
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

autoload -Uz ls_abbrev
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
  ls_abbrev
}


### Autoloads ###
autoload -Uz add-zsh-hook
autoload -U colors; colors
autoload -U compinit   # 補完機能を有効にする
autoload -Uz history-search-end
autoload -Uz vcs_info          # VCSの情報を表示する
autoload -Uz is-at-least
autoload -Uz replace-string

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
  bindkey_function '^F' fzf-history-widget
else 
  bindkey -M viins '^F' history-incremental-search-backward
fi

# # マッチしたコマンドのヒストリを表示できるようにする
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

bindkey_function '^R' replace-string
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
export GREP_OPTIONS='--color=auto' 


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
alias vtime="vim $HOME/.vim/.log --startuptime $HOME/.vim/.log -c '1,$delete' -c 'e! %'"
case "$OSTYPE" in
    darwin*)
        alias ls='ls -G'
        (( $+commands[terminal-notifier])) && \
            alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
        ;;
    *)
        alias ls='ls --color=auto'
esac
alias less='less -IMx4 -X -R'
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

[[ -x `which htop 2>/dev/null` ]]  && alias top='htop'
# [[ -x `which nvim 2>/dev/null` ]]  && alias vim='nvim'
(( $+commands[pygmentize] )) && alias c='pygmentize -O style=monokai -f console256 -g'

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

function ssh() {
    local window_name=$(tmux display -p '#{window_name}')
    command ssh $@
    tmux rename-window $window_name
}

function frepo() {
    local dir
    dir=$(ghq list > /dev/null | fzf-tmux --reverse +m) &&
        cd $(ghq root)/$dir
}

function foreground-vi() {
    fg %vim
}
zle -N foreground-vi
bindkey '^Z' foreground-vi

zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

## Zbell configuration
zbell_duration=50
zbell_duration_email=300

function show_process_time_after_cmd(){
    local zbell_cmd_duration
    zbell_cmd_duration=$(( $EPOCHSECONDS - $zbell_timestamp ))
    [[ ${zbell_cmd_duration} -gt $zbell_duration ]] && echo "$zbell_cmd_duration s Elapsed"
}

add-zsh-hook precmd show_process_time_after_cmd

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

get_pyenv_version()
{
    name=$( pyenv version-name )
    [[ -n $name ]] && echo "(🐍 :$name)"

}
get_rbenv_version()
{
    name=$( rbenv version-name )
    [[ -n $name ]] && echo "(💎 :$name)"

}

PROMPT="\$(get_pyenv_version)\$(get_rbenv_version)
$tmp_rprompt\$vcs_info_msg_0_
$tmp_prompt"    # 通常のプロンプト

PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# For tmux powerline, to detect current directory setting
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && \
    PROMPT="\$(get_pyenv_version)
$tmp_rprompt\$vcs_info_msg_0_
%{${fg[yellow]}%}${HOST%%.*} $tmp_prompt"
;
