# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ethansmbp/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_MODE="awesome-patched"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Containerz
alias d="docker"
dlogs() {
  d logs -f $1
}
dprune() { # Remove all exited containers
  dead_containers=()
  while IFS= read -r line; do
      dead_containers+=( "$line" )
  done < <( dpsa -f status=exited -q )
  for i in $dead_containers
  do
    d rm $i
  done
}
alias dps="d ps"
alias dpsa="d ps -a"

# Kube
alias k="kubectl"
kcs(){
  k config use-context $1 # TODO: I dont like this one
}
klogs() {
  k logs -f $1 # Pod ID/name/etc
}
alias kgp="k get pods"

# GIT
alias g="git"
alias gs="g status"
alias gcb="g checkout -b" # + branch name
gtrc(){
  full_tag=rc/$(date +"%Y%m%d%H%M")
  g tag -a $full_tag -m $1 $2 # [Message, <commit hash>]
  echo $full_tag
}
gtpr(){
  full_tag=release/$(date +"%Y%m%d%H%M")
  g tag -a $full_tag -m $1 $2 # [Message, <commit hash>]
  echo $full_tag
}
alias mas="g pull origin master"
alias push="g push origin" # + branch name
alias pull="g pull origin" # + branch name
alias fetch="g fetch"

# CAPSULE
alias pharmlogs="d logs -f $(dps | grep pharmakon-dev | awk '{ print substr($1, /(\w+)?/) }')" # TODO: this might be broken
sandbox() {
  read "answer?Are you sure? (yn) "
  echo
  if [[ $answer =~ ^[Yy]$ ]]
  then
    echo "git branch -D sandbox ...";
    git branch -D sandbox;
    sleep 1;
    echo "git branch sandbox ...";
    git branch sandbox;
    sleep 1;
    echo "git push origin sandbox -f ...";
    git push origin sandbox -f;
    sleep 1;
    echo "current repo pushed to sandbox.";
  fi
}

# ZSHRC
alias cpzsh="cp ~/.zshrc ."
alias srczsh="source ~/.zshrc"
alias zshconfig="code ~/.zshrc"

# Artifactory Config

# Java Config
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ethansmbp/.sdkman"
[[ -s "/Users/ethansmbp/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ethansmbp/.sdkman/bin/sdkman-init.sh"
