fpath+=$HOME/.zsh/pure
source $HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

autoload -U promptinit; promptinit
prompt pure

autoload -Uz compinit && compinit       # Loads completion modules
setopt AUTO_MENU                        # Show completion menu on tab press
setopt ALWAYS_TO_END                    # Move cursor after completion
setopt COMPLETE_ALIASES                 # Allow autocompletion for aliases
setopt COMPLETE_IN_WORD                 # Allow completion from middle of word
setopt LIST_PACKED                      # Smallest completion menu
setopt AUTO_PARAM_KEYS                  # Intelligent handling of characters
setopt AUTO_PARAM_SLASH                 # after a completion
setopt AUTO_REMOVE_SLASH                # Remove trailing slash when needed

autoload edit-command-line; zle -N edit-command-line

# Vim!
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd "^V" edit-command-line

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

