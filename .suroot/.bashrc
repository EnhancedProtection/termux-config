
tpath() {
    export PATH="$SUDO__TERMUX_PRIORITY_PATH";
    export LD_LIBRARY_PATH="$SUDO__TERMUX_PRIORITY_LD_LIBRARY_PATH";
    export LD_PRELOAD="$SUDO__TERMUX_LD_PRELOAD";
}


apath() {
    export PATH="$SUDO__ANDROID_PRIORITY_PATH";
    export LD_LIBRARY_PATH="$SUDO__ANDROID_PRIORITY_LD_LIBRARY_PATH";
    unset LD_PRELOAD;
}


PS1="[root@saurabh \W]# "

alias cls="clear"
alias la="ls -A"
alias ll="ls -lA"
alias ..="cd .."
alias ...="cd ..."

# Change to home dir!
cd ~


