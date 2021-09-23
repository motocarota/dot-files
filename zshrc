# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# export variables for tiny-care-terminal
# see https://github.com/notwaldorf/tiny-care-terminal/

# TTC_BOTS
# are the 3 twitter bots to check, comma separated. The first entry in this list will be displayed in the party parrot.

export TTC_REPOS="$HOME/var"
# a comma separated list of repos to look at for git commits. This is using git-standup under the hood, and looks one subdirectory deep

export TTC_WEATHER=16043
# the location or zip code to check the weather for (so both 90210 and Paris should work)

export TTC_APIKEYS=false
# set this to false if you don't want to use Twitter API keys and want to scrape the tweets instead.

export TTC_UPDATE_INTERVAL=5
# set this to change the update frequency in minutes, default is 20 minutes.

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"
# ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="bureau"
# ZSH_THEME="gentoo"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/github_rsa"
# ssh-add ~/.ssh/github_rsa

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="sublime ~/.oh-my-zsh"

alias mmv='noglob zmv -W'
alias nvpatch='npm version patch'
alias nvminor='npm version minor'
alias nvmajor='npm version major'
alias ns='clear && npm start'
alias ni='clear && npm install'
alias nb'clear && npm run build'
alias l='ls -FlASh'
alias did="vim +'normal Go' +'r!date' ~/did.txt"
alias wc-project="find . -name \"*.js\" -print0 | xargs -0 wc -l"
alias watip="curl 'https://api.ipify.org?format=json'"
alias ver='$SCRIPTS_PATH/bfx/showAllVersions.sh .'
alias npx='echo'
alias cdd='cd ../..'
alias cddd='cd ../../..'
alias meteo='clear && curl http://v2.wttr.in/lavagna'
alias nri='rm -rf node_modules && npm install'
alias nris='rm -rf node_modules && npm install && npm start'
#alias gpus='git pull && git pull usptream staging && git submodule update'

# files/projects locations
export MY_SCRIPTS_PATH="$HOME/scripts"
export BITFINEX_PATH="$HOME/bitfinex"
export WEBAPP_PATH="$BITFINEX_PATH/webapp"
export SCRIPTS_PATH="$BITFINEX_PATH/bfx-ui-scripts"
export TEMP_CHANGES_FILE="$BITFINEX_PATH/.pending-bfxft-changes.tmp"
export TEMP_PR_WA_FILE="$BITFINEX_PATH/.pending-webapp-changes.tmp"
export ENABLE_LOCAL_OUTPUT=1

# custom shell scripts
alias halp='less $SCRIPTS_PATH/README.md'
alias prl='$SCRIPTS_PATH/pr/list.sh'
alias prf='$SCRIPTS_PATH/pr/ft.sh'
alias prwa='$SCRIPTS_PATH/pr/webapp.sh'
alias prp='$SCRIPTS_PATH/pr/public.sh'
alias unbump='$SCRIPTS_PATH/unbump.sh'
alias postRelease='$SCRIPTS_PATH/post_release/run.sh'
alias tr='$MY_SCRIPTS_PATH/translate.sh'
alias code='codium'
# TODO use the aliases folder to avoid this shit

function git_dig {
  git log --pretty=format:'%Cred%h%Creset - %Cgreen(%ad)%Creset - %s %C(bold blue)<%an>%Creset' --abbrev-commit --date=short -G"$1" -- $2
}

#
# Hooks
#

autoload -U add-zsh-hook

function -auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (eg. via another
  # function).
  if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
    clear
    pwd
    l
  fi
}
add-zsh-hook chpwd -auto-ls-after-cd

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# source /usr/local/etc/bash_completion.d/password-store
autoload -U zmv

# pulls everything from a repo
function gpu () {
	local branch=${1:-staging}
	git pull origin "$branch"
	git pull origin "$branch" --tags

	git pull upstream "$branch"
	git pull upstream "$branch" --tags

	git submodule update --recursive --init
}
export PATH="/opt/homebrew/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"

# ICG env vars
export ICG_SERVER_URL="http:\/\/localhost:4300"
