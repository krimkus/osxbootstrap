# Use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo. (https://github.com/cobyism/dotfiles/blob/master/zsh/zshrc.symlink)
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# Simple navigation
alias ..="cd .."
alias ~="cd ~"
alias cd..='..'
alias ll="ls -ltr"
alias ga="git -am"

alias sss="~/ssh_lacewing.sh"
alias work=". ~/work_on.sh"

# Show/hide hidden files in Finder (https://github.com/mathiasbynens/dotfiles/blob/master/.aliases)
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

#########
# Other #
#########
export GREP_OPTIONS="--color"
export CLICOLOR=true

# Zsh
CASE_SENSITIVE="true"

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.zshistory"
export SAVEHIST=$HISTSIZE
export HISTCONTROL=erasedups
shopt -s histappend

# Use vim as the editor
export EDITOR=vim
alias vi="vim"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git django github history history-substring-search osx python ssh-agent sublime vagrant)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# To hide the “user@hostname” info when you’re logged in as yourself on your local machine.
DEFAULT_USER="kyle"

ssh-add
