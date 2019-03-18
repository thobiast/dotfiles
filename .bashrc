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

	# If kubeon, then show kubernetes current context on PS1
	if [ "$KUBE_PS1" == "on" ];
	then
		PS1="${MY_PS1}$(kube_ps1)$cmd_status "
	else
		PS1="${MY_PS1}$cmd_status "
	fi
}

# Dynamic titles for screen
case "$TERM" in
	screen*) PROMPT_COMMAND="echo -ne \"\033k\033\0134\""
esac

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

