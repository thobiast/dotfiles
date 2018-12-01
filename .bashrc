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
# Docker alias
# ------------
# Stop all running containers
alias dstopall='docker stop $(docker ps -q)'
# Remove all stopped containers
alias drmstopped='docker rm $(docker ps -q -f status=exited)'
# Remove all containers. Even the ones running
alias drmall='docker rm -f $(docker ps -qa)'
# Remove all images
alias drmiall='docker rmi $(docker images -q)'
# Get into a running container. Specify the container ID
alias dshell='_dshell() { docker exec -ti "$1" /bin/bash; }; _dshell'
# List IP of all running containers
alias dip='docker inspect --format "{{.Name}} - {{.NetworkSettings.IPAddress }}" $(docker ps -q)'
# List all IP, exposed and mapped ports
alias dtcp='docker inspect --format "{{.Name}} - {{.NetworkSettings.IPAddress }} - {{.Config.ExposedPorts}} - {{.NetworkSettings.Ports}}" $(docker ps -q)'
# List containers volume mapping
alias dvol='docker inspect --format "{{.Name}} - {{ range .Mounts }}{{ .Source }} -> {{.Destination}}{{ end }}" $(docker ps -q)'
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

	PS1="${MY_PS1}$cmd_status "
}

# Dynamic titles for screen
case "$TERM" in
	screen*) PROMPT_COMMAND="echo -ne \"\033k\033\0134\""
esac

# Git prompt and aliases
test -r ~/.gitbash && source $_

# Preserve earlier PROMPT_COMMAND entries
PROMPT_COMMAND="set_my_ps1;$PROMPT_COMMAND"

