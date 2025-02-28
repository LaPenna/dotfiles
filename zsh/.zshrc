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
alias qq=exit

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
alias yts='function _yts() { video_info=$(yt-dlp --no-warnings --print "title" --get-url "ytsearch1:$*"); video_title=$(echo "$video_info" | head -n 1); video_url=$(echo "$video_info" | tail -n 1); echo "Now playing: $video_title"; mpv --no-video --volume=20 "$video_url"; }; _yts'
ytpl() {
    if [ -z "$1" ]; then
        echo "Usage: play_playlist <playlist_url>"
        return 1
    fi

    PLAYLIST_URL="$1"

    # Extract video titles and URLs from the playlist
    video_info=$(yt-dlp --flat-playlist --print "%(title)s || %(url)s" "$PLAYLIST_URL" 2>/dev/null)

    if [ -z "$video_info" ]; then
        echo "No videos found in the playlist."
        return 1
    fi

    # Loop through each video's title and URL
    echo "$video_info" | while IFS='||' read -r video_title video_url; do
        # Trim leading/trailing whitespace from the title and URL
        video_title=$(echo "$video_title" | xargs)
        video_url=$(echo "$video_url" | xargs)

        yts "$video_title"
    done
}

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

## DOCKER

# Because we suck at typing
alias dokcer=docker

# we often spawn a shell into a container
alias dit='docker exec -it'
# boot into our kali instance
alias dkali='docker exec -it exciting_torvalds bash'

# Various handy REPL style interactive docker envs here
alias dpy='docker run -it --rm python:3.9-slim python'

# alias dpy.='docker run -it --rm -v "$(pwd)":/app python:3.9-slim sh -c "python /app/$1; python"'
dpy.() {
if [ -z "$1" ]; then
    docker run -it --rm -v "$(pwd)":/app python:3.9-slim bash
    return 1
fi
docker run -it --rm -v "$(pwd)":/app python:3.9-slim sh -c "python /app/$1; python"
}

# Start our docker container with persistant pip packages
# We use this with our nvim keymap <leader>py to run challenge tests
alias dpi='docker run -d --name py-pip -v python-packages:/root/.local/lib/python3.11/site-packages -v $(pwd):/workspace py-pip'

#
## Python
#
alias py=python3
alias python=python3
alias pyact="source venv/bin/activate"

## END ALIAS

# fnm
FNM_PATH="/home/klp/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/klp/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
## php.new stuff
export PATH="/home/klp/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/klp/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

