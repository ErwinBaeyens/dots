#!/bin/bash
# -*- mode: sh; fill-colunm: 75; comment-column: 50; -*-
if [[ $- == *i* ]]; then 
    echo "running exports"
    # User specific environment variables
    export EDITOR='emacsclient -c'
    export MANPATH                          #This is a test comment 
    export PATH
    export PS1 
    export PYTHONSTARTUP=~/.pythonrc
    export VISUAL='emacsclient -c'
    export PS1="\[\033[0;31m\]\u@\h \[\033[1;33m\]\w\[\033[0;32m\]\$(__git_ps1)\[\033[0m\] $ "
    export GIT_OPS_ROOT="$HOME/git/operations/tools-model"
    export GIT_DEV_ROOT="$HOME/git/deployment/deployment-model"
fi
