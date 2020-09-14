#!/usr/bin/env zsh
# CTRL-T - Paste the selected file path(s) into the command line

autoload -Uz bindkey_function

bindkey -v               # キーバインドをviモードに設定

if (( $+commands[fzf] )) ; then
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
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

bindkey_function '^O' replace-string
bindkey_function -M vicmd v edit-command-line

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

### 
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

zle -N foreground-vi
bindkey '^Z' foreground-vi

function foreground-vi() {
    fg %$EDITOR
}

zle -N foreground-vi
bindkey '^Z' foreground-vi

