case $TERM in
    xterm*)
        PS1="\[\033]0;\u@\h:\w \007\]\w: "
        ;;
    *)
        PS1="bash\\$ "
        ;;
esac
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/klochner/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

export AWS_RDS_HOME=/Users/klochner/packages/RDSCli-1.4.007
export AWS_CREDENTIAL_FILE=/Users/klochner/packages/RDSCli-1.4.007/cred.txt
export LD_LIBRARY_PATH=$LIBRARY_OUTPUT_PATH
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
export PYTHONPATH=$VTK_ROOT/Wrapping/Python:/Users/klochner/packages/VTK-build/bin
export PYTHONPATH=/Users/klochner/packages/VTK-build/Wrapping/Python:/Users/klochner/packages/VTK-build/bin
export JAVA_HOME=/Library/Java/Home
export RESIN_HOME=/Users/klochner/packages/resin-pro-3.1.7a
export ANT_HOME=/Users/klochner/packages/apache-ant-1.9.4
export PATH=/usr/local/git/bin:/Users/klochner/bin/:$PATH:/usr/local/mysql/bin/:${AWS_RDS_HOME}/bin
PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH

#export RUBYOPT="-ropenssl"
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
