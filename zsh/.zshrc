eval "$(starship init zsh)"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

export EDITOR=nvim
export GIT_EDITOR=nvim
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export LS_COLORS="ln=01;36:di=01;34:fi=0:*.txt=01;32"
# Alias

## Terminal, paths and navigation
alias ls='exa --group-directories-first --icons'
alias ll='exa -lah --group-directories-first --icons'
alias lt='exa -T --level=2 -a --group-directories-first --icons'
alias lll='exa -lah --sort=newest --group-directories-first --icons'
alias llz='exa -lah --sort=size --icons'
alias lr='exa -lahR --icons'
# alias ls='ls -lah --color=auto'
# alias lt='tree -aC'
# alias ll='ls -l'
alias ..='cd ../'

## System Utils
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"
nt() {
  local target="${1:-.}"
  (nautilus "$target" >/dev/null 2>&1 &)
}
alias subdir-sizes='find . -mindepth 2 -maxdepth 2 -type d -exec du -sh {} + | sort -h'

## Media
alias yt='mpv --no-video'
alias yts='function _yts() { video_info=$(yt-dlp --no-warnings --print "title" --get-url "ytsearch1:$*"); video_title=$(echo "$video_info" | head -n 1); video_url=$(echo "$video_info" | tail -n 1); echo "Now playing: $video_title"; mpv --no-video "$video_url"; }; _yts'

## Git
alias gis='git status'
alias lzg='lazygit'
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/home/klp/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/klp/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
