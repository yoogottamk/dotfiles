# begin git aliases

alias g=git
alias ga='git add'
alias gb='git branch'
alias gbd='git branch -d'
alias gc='git checkout'
alias gcam='git commit -a -m'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gd='git diff'
alias gl='git log'
alias glo='git log --oneline --decorate'
alias gm='git merge'
alias gmom='git merge origin/master'
alias gpom='git pull origin master'
alias gr='git remote'
alias gst='git status'

# end git aliases

alias tmux="tmux -u"
alias i="sudo apt install"
alias octave="octave --no-gui -q"

# easy way out
alias x='exit'

# for testing
function hcc() {
    gcc -m32 -fno-stack-protector -z execstack -mpreferred-stack-boundary=2 -g "$1" -o $( echo "$1" | cut -d. -f1 )
}

# what i always do anyways
function cl() {
    cd "$@" && ls
}

function mkcd() {
    mkdir "$1" && cd "$1"
}

alias gdb="gdb -q"

alias mx="chmod +x"

alias v='f -e vim'
alias o='a -e xdg-open'

alias xo='xdg-open'

