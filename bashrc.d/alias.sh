#!/usr/bin/bash

# User specific aliases and functions
alias emacs='emacsclient -c'
alias k='minikube kubectl --' 
alias vcenter='sudo -E ssh exl217@adm-in-lcl -N -L127.0.0.5:443:172.18.128.82:443'
alias werner="cd $HOME/git/operations/werner/"
alias la='ls -ahl --color=auto'
alias ll='ls -lh --color=auto'
alias l='ls -lhd --color=auto'
alias brol="cd $HOME/brol/"
alias gpl="git pull && git last"
# for minio staging
alias minios='ssh -fNT minios'
# for minio production
alias miniop='ssh -fNT miniop'
# unified minio
alias minio_all='ssh -fNT minio_all'
# kubernetes forwarding
alias k8s='ssh -fNT k8s'
