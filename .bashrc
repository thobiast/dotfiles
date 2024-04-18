# Add ~/bin to PATH
test -d "${HOME}/bin" && PATH="$_:$PATH"

#########
# Alias #
#########
# Prompt before every removal/overwrite
# -------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# Colors
# ------
alias ls='ls --color=auto'
alias grep='grep --color'
# Archlinux pacman
alias pacman='function _pacs(){ if [ "$1" = "-Ss" ]; then command sudo pacman -Ss $2 | sed "s,^[^ ]\+,\x1b[32m&\x1b[0m,;s, \[installed[ 0-9:._-]*\] *$,\x1b[36m&\x1b[0m,;N;s/\n */ - /"; else
command sudo pacman --color auto "$@"; fi; unset -f _pacs; }; _pacs'
alias podman='function _podman(){ command sudo podman "$@"; unset -f _podman; }; _podman'
alias podman-compose='function _podman-compose(){ command sudo podman-compose "$@"; unset -f _podman-compose; }; _podman-compose'

# Lazy
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Readline displays possible tab completions using different colors to indicate their file type
bind 'set colored-stats on'

# Make Tab autocomplete regardless of filename case
set completion-ignore-case on

# Set the default editor to vim.
export EDITOR=vim
# Tell grep to highlight matches
export GREP_OPTIONS='-color=auto'

# openstack fit the table to the display width
export CLIFF_FIT_WIDTH=1

# History
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL=ignoreboth   # ignoredups and ignorespace
export HISTTIMEFORMAT="%d/%m/%y %T "
# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
shopt -s histappend
# Save multi-line commands as one command
shopt -s cmdhist
# Check window size and update $LINES and $COLUMNS after each command
shopt -s checkwinsize

# disable ctrl+s (flow control)
stty -ixon

#############
# My prompt #
#############
# \u     the username of the current user
# \h     the hostname up to the first `.'
# \w     the current working directory, with $HOME abbreviated with a tilde
PS1_COLOR_GREEN='\[\e[0;32m\]'  # green
PS1_COLOR_WHITE='\[\e[0;37m\]'  # white
PS1_COLOR_BBLUE='\[\e[1;34m\]'  # bold blue
PS1_COLOR_BRED='\[\e[1;31m\]'   # bold red
PS1_COLOR_RESET='\[\e[0m\]'     # reset color
MY_PS1="\u@\h:${PS1_COLOR_BBLUE}\w${PS1_COLOR_RESET}"

# Customize prompt
# Call back for bash-git-prompt and for set_my_ps1 function
prompt_callback()
{
    local tfworkspace

    if [ -d .terraform ]; then
        tfworkspace="$(command terraform workspace show 2>/dev/null)"
        [ "$tfworkspace" ] &&
            echo -n "${PS1_COLOR_GREEN} (tf: $tfworkspace)${PS1_COLOR_RESET}"
    fi

    [ -n "$OS_PROJECT_NAME" ] &&
        echo -n "${PS1_COLOR_GREEN}(Openstack: $OS_PROJECT_NAME)${PS1_COLOR_RESET}"

    if [ "$KUBE_PS1" == "on" ]; then
        kube_ps1 2> /dev/null || return
    fi
}

# Customize my PS1
set_my_ps1()
{
    # last command return code
    local last_cmd_rc=$?
    local cmd_status='\$'

    # If last command executed on shell return code non-zero
    # change prompt '$' to red
    [ "$last_cmd_rc" != "0" ] &&
        cmd_status="${PS1_COLOR_BRED}\$${PS1_COLOR_RESET}"

    PS1="${MY_PS1}$(prompt_callback)$cmd_status "
}

# Dynamic titles for screen
case "$TERM" in
    screen*) PROMPT_COMMAND="echo -ne \"\033k\033\0134\""
esac

# Bash completion
test -r /etc/bash_completion && source $_
# Git prompt and aliases
test -r ~/.gitbash && source $_
# Openshift oc bash completion
test -r ~/.oc_bash_completion.sh && source $_
# Docker alias
test -r ~/.dockerbash && source $_
# Kubernetes/openshift prompt and alias
test -r ~/.kubebash && source $_

# Load funcoeszz.net
zzon()
{
    export ZZPATH="/home/thobias_trevisan/github/funcoeszz/funcoeszz"  # script
    export ZZDIR="/home/thobias_trevisan/github/funcoeszz/zz"    # pasta zz/
    source "$ZZPATH"
}

# Preserve earlier PROMPT_COMMAND entries
PROMPT_COMMAND="set_my_ps1;$PROMPT_COMMAND"

