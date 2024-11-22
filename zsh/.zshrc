eval "$(starship init zsh)"

# Alias

## ls et al
alias ll='ls -l'

## Git
alias gis='git status'
nah () {
    git reset --hard
    git clean -df
    if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then
        git rebase --abort
    fi
}

typeset -U path cdpath fpath
path=(
    $HOME/.local/bin
    /opt/nvim-linux64/bin
    $path
)
