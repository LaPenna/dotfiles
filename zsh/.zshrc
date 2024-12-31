eval "$(starship init zsh)"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

export EDITOR=nvim
export GIT_EDITOR=nvim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# Alias

## System Utils
nt() {
  local target="${1:-.}"
  (nautilus "$target" >/dev/null 2>&1 &)
}
alias subdir-sizes='find . -mindepth 2 -maxdepth 2 -type d -exec du -sh {} + | sort -h'

## media
alias yt='mpv --no-video'
alias yts='function _yts() { video_info=$(yt-dlp --no-warnings --print "title" --get-url "ytsearch1:$*"); video_title=$(echo "$video_info" | head -n 1); video_url=$(echo "$video_info" | tail -n 1); echo "Now playing: $video_title"; mpv --no-video "$video_url"; }; _yts'

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

## Laravel
alias pls='php artisan'
alias mfs='php artisan migrate:fresh --seed'

alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias spls='sail artisan'
