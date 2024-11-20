eval "$(starship init zsh)"
alias ll='ls -l'

typeset -U path cdpath fpath
path=(
    $HOME/.local/bin
    $path
)
