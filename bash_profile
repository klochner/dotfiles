if [ -f ~/.bashrc ]; then
     source ~/.bashrc
fi
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add
fi

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
export PATH
alias wget="curl -O"

ulimit -n 65536 unlimited

