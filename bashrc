# .bashrc

#  avoid problems with non interactive logins like rsync etc
    # set a debug flag that shows which files in .bashrc.d are being sourced 
    export DEBUG=""

    # Source global definitions
    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi

    # User specific environment
    if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
    then
        PATH="$HOME/.local/bin:$HOME/bin:$PATH"
    fi
    PATH="$PATH:/usr/local/pycharm/bin"
    MANPATH="$MANPATH:/usr/local/share/man/:/usr/share/man/"

    # Uncomment the following line if you don't like systemctl's auto-paging feature:
    # export SYSTEMD_PAGER=

    if [[ $- == *i* ]]; then
        # start the gpg agent
        gpg-agent --daemon --log-file=~/.gnupg/gpg.log --pinentry-program $(which pinentry) 2>&1 >>~/.gnupg/gpg_junk.log
   

        # start the ssh-agent
        eval "$(ssh-agent -s)"
    fi
    # process the files in ~/.bashrc.d if it exists
    # show which file is being processed if DEBUG is not empty
    if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*.sh; do
            if [ -f "$rc" ]; then
                if [ ! -z  "$DEBUG" ]; then
                    if [ ${rc: -1} == "~" ]; then
                        echo "$rc: Backup!";
                    else
                        echo "$rc"
                        echo "========================"
                        cat "~/.bashrc.d/$rc"
                        echo "========================"
                    fi
                fi
                if [ ${rc: -1} != "~" ]; then
                    source  "$rc"
                fi
            fi
        done
        unset rc
    fi

    # # add kubctl completion
    # source <$(kubectl completion bash)

    # # add helm completion
    # source <$(helm completion bash)

    # get the correct Xresources loaded
    xrdb -merge ~/.Xresources
    
    complete -F __start_kubectl k

