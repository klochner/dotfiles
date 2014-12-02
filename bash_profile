if [ -f ~/.bashrc ]; then
     source ~/.bashrc
fi
##
# Your previous /Users/klochner/.bash_profile file was backed up as /Users/klochner/.bash_profile.macports-saved_2011-11-17_at_10:35:08
##

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
alias wget="curl -O"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
