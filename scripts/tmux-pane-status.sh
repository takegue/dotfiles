#!/bin/bash
# Prints current branch in a VCS directory if it could be detected.
# Source lib to get the function get_tmux_pwd
# source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

branch_symbol="⭠"
git_colour="5"
svn_colour="220"
hg_colour="45"

run_segment() {
    tmux_path=$1
    cd "$tmux_path"
    __update_git_repo >/dev/null 2>&1 &

    branch=""
    if [ -n "${git_branch=$(__parse_git_branch)}" ]; then
        branch="$git_branch"
    fi

    if [ -n "$branch" ]; then
        echo "${branch}"
    fi
    return 0
}


__update_git_repo() {
   FILE=$(git rev-parse --absolute-git-dir)/now_fetch.pid
   if [[ -f $FILE ]]; then
     if [[ $(( `date +%s` - `/usr/bin/stat -f '%m' $FILE` )) -gt 300 ]]; then
        rm $FILE
     fi
     return
   fi

   date +%s > $FILE
   git fetch
}

# Show git banch.
__parse_git_branch() {
    type git >/dev/null 2>&1 && git rev-parse --git-dir 2> /dev/null;
    if [ "$?" -ne 0 ]; then
        return
    fi

    # Quit if this is not a Git repo.
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/')
    if [[ -z $branch ]] ; then
        # attempt to get short-sha-name
        branch=":$(git rev-parse --short HEAD 2> /dev/null)"
    fi
    if [ "$?" -ne 0 ]; then
        # this must not be a git repo
        return
    fi

    staged=$(git diff --staged --name-status | grep -c '')
    if [[ $staged -gt 0 ]] ; then
        local staged="$staged files staged"
    else
        local staged = ""
    fi

    # creates global variables $1 and $2 based on left vs. right tracking
    tracking_branch=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
    set -- $(git rev-list --left-right --count $tracking_branch...HEAD)

    behind=$1
    ahead=$2

    # print out the information
    if [[ $behind -gt 0 ]] ; then
        local compare="↓ $behind"
    fi
    if [[ $ahead -gt 0 ]] ; then
        local compare="${compare}↑ $ahead"
    fi
    if [[ -n $compare ]] ; then
        local compare="(${compare})"
    fi

    # Clean off unnecessary information.
    branch=${branch##*/}
    diff=$(git diff --shortstat)
    ret=`echo "${branch}${compare} ${staged} ${diff}" | sed "s/  */ /g"`
    echo  -n "#[fg=colour${git_colour}]${branch_symbol} #[fg=colour${TMUX_POWERLINE_CUR_SEGMENT_FG}]${ret}"

}

run_segment $@
