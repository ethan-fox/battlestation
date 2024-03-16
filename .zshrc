# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_MODE="awesome-patched"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
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

#####################################
#             ALIASES               #
#####################################

alias tf="terraform"

# Containerz
alias cs="colima start --memory 6"
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
  ENV=$1

  # Set project

  if [ "${ENV}" = "npd-bdata" ]; then
    project="mlb-bdata-npd-bc33"
  elif [ "${ENV}" = "prod-bdata" ]; then
    project="mlb-bdata-prod-eba6"
  elif [ "${ENV}" = "npd-streaming" ]; then
    project="mlb-streaming-npd-68b7"
  elif [ "${ENV}" = "prod-streaming" ]; then
    project="mlb-streaming-prod-4605"
  else
    echo "Invalid env - must be sbx, npd, or prod"
  fi

  ## List Cluster and Region

  gcloud config set project $project

  CLUSTER_INFO=$(gcloud container clusters list | awk NR\>1 | head -1 | awk {'print $1 " " $2'})
  CLUSTER=$(echo $CLUSTER_INFO | awk {'print $1'})
  REGION=$(echo $CLUSTER_INFO | awk {'print $2'})

  echo "Setting cluster as ${CLUSTER}, region ${REGION}"

  ## Set up kubectl
  gcloud container clusters get-credentials $CLUSTER --region $REGION
}
klogs() {
  k logs -f $1 -n $2 # [Pod ID/name/etc, <namespace>]
}
alias kg="k get"
alias kd="k describe"
alias kgp="k get pods"
alias kgd="k get deployments"
alias kdp="k describe pods"


# GIT
alias g="git"
alias gs="g status"
alias gcb="g checkout -b" # + branch name
alias gcm="g commit -m" # + commit message
alias push="g push origin" # + branch name
alias pull="g pull origin" # + branch name
alias fetch="g fetch"
# alias reset-sandbox="g reset --hard origin/sandbox"
# alias reset-dev="g reset --hard origin/dev"

# tmux
alias t="tmux"
alias tn="t new -s"
alias ta="t attach -t "
alias tk="t kill-session -t"

# Misc.
function pclear(){
  kill -9 $(lsof -ti:$1)
}

# Sporty CLI
export SPORTY_GH_AUTH_TOKEN="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"
export SPORTY_STREAMING_APP_CONFIG_PATH="/Users/ethan.fox/Desktop/code/application-config-streaming"

# ZSHRC
alias cpvs="cp $HOME/Library/Application\ Support/Code/User/settings.json ."
alias srczsh="source ~/.zshrc"
alias ws="cd ~/Desktop/code"
alias zshconfig="code -n ~/.zshrc"
export EDITOR="vim"

# MLB
alias s="sporty"

# MISC.
# Skip forward/back a word with opt-arrow
bindkey '[C' forward-word
bindkey '[D' backward-word
alias py-s="code -n ~/Desktop/code/playground.py && cd ~/Desktop/code"

# Java Config
export JAVA_HOME='/usr/libexec/java_home -v 1.8.321.07'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Java path - switch b/w versions
export JAVA_HOME=/opt/homebrew/opt/openjdk@11
# export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17

# Rust
case ":${PATH}:" in
    *:"$HOME/.cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
        export PATH="$HOME/.cargo/bin:$PATH"
        ;;
esac
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ethan.fox/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ethan.fox/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ethan.fox/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ethan.fox/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
