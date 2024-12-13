eval "$(starship init zsh)"

# Alias

# System Utils
nt() {
  local target="${1:-.}"
  (nautilus "$target" >/dev/null 2>&1 &)
}

## Terminal, paths and navigation
alias ll='ls -l'
alias ..='cd ../'

## Git
alias gis='git status'
nah () {
    git reset --hard
    git clean -df
    if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then
        git rebase --abort
    fi
}

## Tmux
alias ta='tmux attach'
alias tks='tmux kill-server'

typeset -U path cdpath fpath
path=(
    $HOME/.local/bin
    /opt/nvim-linux64/bin
    $path
)
