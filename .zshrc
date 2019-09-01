
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Replacing Spaceship with Powerlevel10K
# # Spaceship options
# SPACESHIP_PROMPT_ADD_NEWLINE="true"
# SPACESHIP_CHAR_SYMBOL="\u2a65"
# SPACESHIP_CHAR_PREFIX=""
# SPACESHIP_CHAR_SUFFIX="%k "
# SPACESHIP_CHAR_COLOR_SUCCESS="white}%K{blue"
# # SPACESHIP_PROMPT_DEFAULT_PREFIX="$USER"
# SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
# SPACESHIP_USER_SHOW="true"
# # SPACESHIP_DIR_COLOR="white}%K{red"
# SPACESHIP_DIR_PREFIX=""
# SPACESHIP_DIR_SUFFIX=" "
# SPACESHIP_PACKAGE_PREFIX=""
# SPACESHIP_PACKAGE_SYMBOL="\ue74e\u2006"
# SPACESHIP_PACKAGE_COLOR="blue"
# SPACESHIP_JOBS_SYMBOL="\uf451"
# SPACESHIP_GIT_BRANCH_PREFIX="\uf418\u2006"
# SPACESHIP_GIT_PREFIX=""
# SPACESHIP_GIT_STATUS_COLOR="magenta"
# SPACESHIP_GIT_STATUS_PREFIX=" "
# SPACESHIP_GIT_STATUS_SUFFIX=""
# SPACESHIP_RUBY_SYMBOL="\uf43b\u2006"
# SPACESHIP_PROMPT_DEFAULT_PREFIX=""

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="spaceship-prompt/spaceship"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

fpath=(/usr/local/share/zsh-completions $fpath)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn gem osx brew python ruby rails django nvm)

# Hide the trailing %
# PROMPT_EOL_MARK=''  ### TODO

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:/opt/local/bin:/opt/local/sbin:/Users/krues8dr/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/bin/ec2/bin
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export SH_DIR=$HOME/.sh.d
source $SH_DIR/functions.sh
source $SH_DIR/exports.sh
source $SH_DIR/misc.sh
source $SH_DIR/serve.sh
source $SH_DIR/motd.sh

source $SH_DIR/history.sh
setopt APPEND_HISTORY
setopt share_history


# Set Spaceship ZSH as a prompt
# autoload -U promptinit; promptinit
# prompt spaceship

alias ls='colorls --dark --sort-dirs'
alias lc='colorls --tree --dark'

#bindkey "\e\e[D" backward-word
#bindkey "\e\e[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

setopt HUP
