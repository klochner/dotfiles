case $TERM in
    xterm*)
        PS1="\[\033]0;\u@\h:\w \007\]\w: "
        ;;
    *)
        PS1="bash\\$ "
        ;;
esac
export DOCKER_CERT_PATH=/Users/klochner/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"
test -d "$HOME/bin" &&
PATH="$HOME/bin:$PATH"

set -o vi
function gv { /Applications/MacVim.app/Contents/MacOS/Vim -g $*; }
function wtf { lynx -dump "http://www.urbandictionary.com/define.php?term=${1}" | sed -n "115,120 p"; }
source ~/.alias

case "$TERM" in
      xterm-color|xterm-256color) color_prompt=yes
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac
if [ "$TERM" != "dumb" ]; then
  CLICOLOR=1
  LSCOLORS=DxGxcxdxCxcgcdabagacad
  export CLICOLOR LSCOLORS
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
