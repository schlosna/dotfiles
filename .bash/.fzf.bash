# Setup fzf
# ---------

BREW_HOME=${BREW_HOME:-/opt/homebrew}
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && [ -s "${BREW_HOME}/opt/fzf/shell/completion.bash" ] && . "${BREW_HOME}/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
key_bindings="${BREW_HOME}/opt/fzf/shell/key-bindings.bash"
[ -s "${key_bindings}" ] && . "${key_bindings}";
