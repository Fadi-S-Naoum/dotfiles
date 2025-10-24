HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd notify
# End of lines configured by zsh-newuser-install

# Immediately write each new command to the history file
setopt INC_APPEND_HISTORY

# Immediately load all newly typed commands in all other zsh sessions
setopt SHARE_HISTORY

# Suggest fixes for mistyped commands
setopt CORRECT 

# make cd push the directory to the stack (run pushd) automatically
setopt AUTO_PUSHD         
# don't print each dir pushed to the stack
setopt PUSHD_SILENT
setopt PUSHD_IGNORE_DUPS

# advanced pattern matching
setopt EXTENDED_GLOB

# complete in the middle of a word
setopt COMPLETE_IN_WORD

#-------------------------
#	PYTHON STUFF
#-------------------------
# Show python venv if active
if [[ -n "$VIRTUAL_ENV" ]]; then
  PROMPT="(venv:$(basename $VIRTUAL_ENV)) $PROMPT"
fi

#-------------------------
#	AUTO COMPLETE
#-------------------------

autoload -Uz compinit
# Use a separate directory for compiled completion cache
[[ -d ~/.zcompdump.d ]] || mkdir ~/.zcompdump.d
compinit -d ~/.zcompdump.d/zcompdump

# include hidden files
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' '+l:|=* r:|=*'

#-------------------------
#	AUTO COMPLETE
#-------------------------
bindkey -v
export KEYTIMEOUT=1

#-------------------------
#	GIT	
#-------------------------
autoload -Uz vcs_info
# allow substitutionm in commands
setopt prompt_subst

# update vcs_info before each command
precmd() { vcs_info }

# configure vcs_info 
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}STAGED%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}UNSTAGED%f'
zstyle ':vcs_info:git:*' cleanstr '%F{blue}CLEAN%f'
# Define the format of the Git branch info (branch name + status symbols)
# %b = branch name, %c = staged symbol, %u = unstaged symbol
zstyle ':vcs_info:git:*' formats '%F{magenta}[%b]%f %c%u'
# Define the format if Git is in a special state (like rebase or merge)
zstyle ':vcs_info:git:*' actionformats '%F{red}[%b|%a]%f %c%u'

#-------------------------
#	ALIASES
#-------------------------
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

#-------------------------
#	PROMPT	
#-------------------------
PS1='%B%F{cyan}%n@%m:%F{magenta}%~ ${vcs_info_msg_0_} %F{green}%#%f%b ' 


