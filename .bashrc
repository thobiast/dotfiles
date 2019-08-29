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

# Set the default editor to vim.
export EDITOR=vim

# History
export HISTSIZE=100000
export HISTCONTROL=ignoreboth   # ignoredups and ignorespace
# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
shopt -s histappend
# Save multi-line commands as one command
shopt -s cmdhist
# Check window size and update $LINES and $COLUMNS after each command
shopt -s checkwinsize

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

# Preserve earlier PROMPT_COMMAND entries
PROMPT_COMMAND="set_my_ps1;$PROMPT_COMMAND"

