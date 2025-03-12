#!/bin/bash

start_oobs () {
    if [ -d "$1" ]; then
        START_OOBS_SCRIPT=$(find $1 -name start_oobs.sh)
    else
        START_OOBS_SCRIPT="$DEVHOME/devtools/oobs/bin/start_oobs.sh"
    fi
    if [ -x "$START_OOBS_SCRIPT" ]; then
        . $START_OOBS_SCRIPT
    else
        echo "could not find a valid start_oobsscript (START_OOBS_SCRIPT = \"$START_OOBS_SCRIPT\")"
    fi
}
alias so=start_oobs
# just to test


# Note: some if the exports are for the Benerail API team
# These may change over time
# The MR_VERSION however  can be used by all, and is used
# in the useful new_branch() function
switch_repo () {
    if [ -n "$1" ]; then
        export MR_VERSION=$1
        if [ -d "$HOME/git/mr$1" ]; then
            export DEVHOME=$HOME/git/mr$1
        elif [ -d "$HOME/GIT/MR$1" ]; then
            export DEVHOME=$HOME/GIT/MR$1
        elif [ -d "$HOME/git/$1" ]; then
            export DEVHOME=$HOME/git/$1
        elif [ -d "$HOME/GIT/$1" ]; then
            export DEVHOME=$HOME/GIT/$1
        else
            echo "Invalid parameter $1: The directory $HOME/GIT/MR$1, $HOME/git/mr$1, $HOME/git/$1, or $HOME/GIT/$1 do not exist"
            return
        fi
        echo "DEVHOME is now set to $DEVHOME... Calling start_oobs"
        cd $DEVHOME
        export PKI_DIRECTORY=$HOME/pki
        # export D_SERVICES_PASSWORD='NotSetSecret'
        # export ORACLE_PASSWORD='NotSetSecret'
        so
    else
        echo "you should provide a parameter to identify the MR you want to switch to."
    fi
    if [ -n "$2" ]; then
        echo "Using $2 as D_SERVICES_SERVER"
        export D_SERVICES_SERVER=$2
    else
        echo "Warning:  No platform specified, using c01 as D_SERVICES_SERVER"
        export D_SERVICES_SERVER='c01'
    fi
}
alias sr=switch_repo


new_branch () {
    if [ -n "$1" ]; then
        repo start feature/mr$MR_VERSION-$1 .
        git push origin feature/mr$MR_VERSION-$1
        git branch --set-upstream-to origin/feature/mr$MR_VERSION-$1
    else
        echo "Branch name required"
    fi
}
alias nb=new_branch


baseRepoUpdate () {
    if [ -n "$1" ]; then
        repo_all_checkout $1
        echo " "
        echo "START pulling repo's branch $1"
        echo " "
        repo_all_pull
        echo " "
        echo "END pulling rep's branch $1"
        echo " "
    else
        echo "provide a valid branch. E.g.: repoUpodate dev_mr54.0"
        return
    fi
}


repoUpdate () {
    if [ -n "$1" ]; then
        START=$(date +%s);
        echo "repoUpdate S1 started"
        echo ""
        baseRepoUpdate $1
        END=$(date +%s)
        echo "repoUpdate branch $1 finished after $((END-START)) seconds"
        return
    else
        echo "provide a valid branch. E.g.: repoUpodate dev_mr54.0"
        fi
}


repoSyncAndUpdate () {
    if [ -n "$1" ]; then
        START=$(date +%s);
        echo "repoSyncAndUpdate S1 started"
        repo sync
        echo ""
        baseRepoUpdate $1
        END=$(date +%s)
        echo "repoSyncAndUpdate branch $1 finished after $((END-START)) seconds"
    else
        echo "provide a valid branch. E.g.: repoUpodate dev_mr54.0"
        return
    fi
}


repoStashSyncPop () {
    echo "START repo repoStashSyncPop"
    echo "git stash"
    git stash
    echo "repo sync"
    repo sync .
    echo "git stash pop"
    git stash pop
    echo "END repo repoStashSyncPop"    
}


repo_all_checkout () {
    if [ -n "$1" ]; then
        echo "START checking out repo's branch $1"
        repo forall -c git checkout $1
        echo " END of checking out repo's branch $1"
    else
        echo "please provide a valid branch name.  E.g.: dev_mr54.0 "
        return
    fi
}


alias rssp=repsStashSyncPop
alias ru=repoUpdate
alias rsu=repoSyncAndUpdate

alias rap=repo_all_pull
alias rac=repo_all_checkout

export GIT_HOME=$HOME/git
