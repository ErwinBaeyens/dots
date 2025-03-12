#!/usr/bin/bash

# export $GIT=~/git/
# export $GIT_OPS_ROOT=$GIT/operations/tools-models
# export $GIT_DEV_ROOT=$GIT/deployment/deployment-model
# cd ${GIT_DEV_ROOT}
# git checkout dev_mr$MR
export ANSIBLE_VAULT_PASSWORD_FILE="~/git/operations/werner/vault/decrypt-vault"

# Emacs vterm functions 

vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # tell tmux to pass the escape sequeces  trough
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256, ...)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    function clear() {
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    }
fi

function vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}

# add rust environment
# . "$HOME/.cargo/env"

