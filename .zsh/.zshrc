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
    /usr/share/man
    /usr/local/share/man
    "$manpath[@]"
)

ld_library_path=(
    $HOME/.local/lib
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

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit wait lucid for \
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
    atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
    zsh-users/zsh-history-substring-search \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions

# Install Google Cloud SDK
zinit ice as'null' id-as"google-cloud-sdk.tar.gz" \
    atclone'tar zxfa *.tar.gz && ./google-cloud-sdk/install.sh -q --path-update false --usage-reporting false' \
    src'google-cloud-sdk/path.zsh.inc' atpull'%atclone' 
zinit snippet "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-337.0.0-linux-x86_64.tar.gz?hl=ja"

zinit wait lucid for \
    sbin'' k4rthik/git-cal \
    make"!build" sbin'' x-motemen/ghq \
    make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' sbin'' src"zhook.zsh" direnv/direnv \
    from"gh-r" sbin"bin/exa* -> exa" ogham/exa \
    from"gh-r" sbin"win32yank* -> win32yank" equalsraf/win32yank \
    from'gh-r' has'kubectl' bpick'kubens*' sbin'kubens' id-as'kubens' ahmetb/kubectx \
    from'gh-r' has'kubectl' bpick'kubectx*' id-as'kubectx' ahmetb/kubectx \
    from'gh-r' has'rustc' sbin'rust-analyzer* -> rust-analyzer' rust-analyzer/rust-analyzer \
    as'program' pick"gcloudctx" atclone"cp completion/gcloudctx.zsh _gcloudctx_completion" ogerbron/gcloudctx

zinit lucid as'program' pick"$ZPFX/bin/(fzf|fzf-tmux)" \
    atclone"cp shell/completion.zsh _fzf_completion; \
      cp bin/(fzf|fzf-tmux) $ZPFX/bin" \
    src="shell/completion.zsh" \
    make"PREFIX=$ZPFX install" for \
        junegunn/fzf

# Load OMZ Git library
zinit snippet OMZL::git.zsh
zinit wait lucid for \
      OMZP::colored-man-pages

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# Zbell
zbell_duration=5
zbell_duration_email=12000
zinit snippet https://gist.githubusercontent.com/TKNGUE/aaeb57123ac97c649b34dfdc5f278b89/raw/ede9c19ed66907076ac0162deed8247a1c0e041e/zbell.zsh

# A little more complex rustup configuration that uses Bin-Gem-Node annex
# and installs the cargo completion provided with rustup, using for-syntax
zinit id-as=rust wait=1 as='program' pick="bin/*" lucid rustup \
    atload="[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall rust; \
    export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup" for \
        zdharma/null

# FIXME: Impl 
#   [[ $OSNAME == 'Darwin' ]] && zgen load https://gist.github.com/5535a140f8de7c5b1ca616e36568a720.git
#   # zgen load jonmosco/kube-ps1 kube-ps1.sh

autoload -Uz compinit
compinit; zinit cdreplay

# -----------------------------------------------------------------------------
#                               GENERAL SETTINGS
# -----------------------------------------------------------------------------
export EDITOR=vim 
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=UTF8        # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export LESSCHARSET=UTF-8
export GREP_OPTION="--color auto"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export GOPATH=$HOME/.go && [[ ! -d $GOPATH ]] && mkdir -p $GOPATH
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
if [[ ! -z $ZSH_HIGHLIGHT_STYLES ]] then
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=45'
fi

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

[[ -f ${ZDOTDIR}/colorsheme.zsh ]] && source ${ZDOTDIR}/colorsheme.zsh

# -----------------------------------------------------------------------------
#                               KEY BINDINGS
# -----------------------------------------------------------------------------

[[ -f ${ZDOTDIR}/key_bindings.zsh ]] && source ${ZDOTDIR}/key_bindings.zsh

### Complement ###
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する

zstyle ':completion:*' menu select

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _gnu_generic _history
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
#                                     OTHERS
# -----------------------------------------------------------------------------
[[ -z $LD_LIBRARY_PATH ]] && export LD_LIBRARY_PATH=${PATH:gs/bin/lib}

today(){ echo `date +%Y%m%d` } 
now(){ echo `date +%Y%m%d%H%M%S` } 

# ------------------------------
# Aliases
# ------------------------------
alias tmux='tmux -2'
# alias vi='vim -u NONE'
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

(( $+commands[exa] )) && alias ls='exa'
(( $+commands[nvim] )) && alias vim='nvim' && export EDITOR=nvim
(( $+commands[htop] )) && alias top='htop'
# [[ -x `which nvim 2>/dev/null` ]]  && alias vim='nvim'
(( $+commands[pygmentize] )) && alias c='pygmentize -O style=monokai -f console256 -g'
(( $+commands[hub] )) && alias git='hub'

# ------------------------------
# Functions
# ------------------------------
function cd() {
    if [[ $1 = "-" ]]; then
        shift;
        builtin cd $(dirs -lp | uniq | fzf || pwd) $@
    else
        builtin cd $@
    fi
}

function foreground-vi() {
    fg %$EDITOR
}

zle -N foreground-vi
bindkey '^Z' foreground-vi

zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

function render_test(){  
    # kubectx -c
    # echo "☁️  $(gctx current)"
}

function memo_cmd(){  
    [[ -n ${TMUX_PANE} ]] && echo $1 > "${TMP:-/tmp}/tmux_pane_cmd_${TMUX_PANE}"
}
# For tmux powerline, to detect current directory setting
PS1="$PS1"
add-zsh-hook preexec memo_cmd
add-zsh-hook precmd render_test


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

# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi
