# Fix the ulimit.
ulimit -n 2560

# Enable NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# Enable RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Enable rbenv
eval "$(rbenv init -)"

# Add our SSH keys.
ssh-add -K ~/.ssh/github.dsa &>/dev/null