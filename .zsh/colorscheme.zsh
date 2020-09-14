#!/usr/bin/env zsh

echo "oge"
(( $+commands[vivid] )) && export LS_COLORS="$(vivid generate molokai)"
