###   Global vars   ###
export g_user="jwalker"
export g_homeDir="$HOME"
export g_toolsDir="$g_homeDir/LinuxTools"

###   Setup Tools   ###
# Run this method to install the plugins that these tools use :)
SetupCentOSTools()
{
	sudo yum -y install tmux emacs
}

SetupUbuntuTools()
{
	sudo apt -y install tmux emacs
}

###   Setup VIM   ###
g_vimrc="$g_toolsDir/.vimrc"
if test -e $g_toolsDir/.vimrc; then
    export g_vimrc
else
    echo "warning:"
    echo -e "\t$g_toolsDir/.vimrc does not exist"
	echo
fi

if test -e "$g_vimrc"; then
    echo "======================="
    echo "+++   VIM CONFIGS   +++"
    echo "======================="
    echo "$(which vim)";
	echo

else
    echo "error:"
    echo -e "\tUnable to configure vim"
    echo "================+++++++++="
    echo "+++   DEBUG   +++"
    echo
    echo -e "-\tg_user=$f_user"
    echo -e "-\tg_homeDir=$g_homeDir"
	echo -e "-\tg_toolsDir=$g_toolsDir"
    echo -e "-\tg_vimrc=$g_vimrc"
    echo "=========================="
	echo
fi

###   Setup TMUX   ###
TMUX()
{
    set -x
    tmux has -t g_user

	# Attach if session already exists
	if [ $? -eq 0] ; then
		tmux attach -t $g_user
	else
		tmux new -d -s $g_user -n $g_user
		tmux set-option -t $g_user default-command "/bin/bash --rcfile ${g_toolsDir}/.bashrc"
		tmux new-window -t $g_user
		
		# Source tools
		tmux send-keys -t $g_user source SPACE $g_toolsDir/tools.sh ENTER
		if [ -e $g_repoBase/.tmux.conf ]; then
			tmux send-keys -t $g_user tmux SPACE source-file SPACE $g_toolsDir/.tmux.conf ENTER
		fi
		tmux attach -t $g_user
	fi
	set +x
}

###   Setup EMACS   ###
g_emacscfg="$g_toolsDir/emacs.el"
if test -e "$g_emacscfg"; then
    alias emacs="emacs -nw -l $g_emacscfg"
    echo "Custom emacs set"
    echo
else
    alias emacs="emacs -nw"
    echo "emacs = emacs -nw"
    echo
fi

CleanEmacs()
{
	find . -iname "*~" | xargs rm
	find . -iname "*#" | xargs rm
}

###   Other Helpful Tools   ###
la()
{
	ls -alh --color=auto $1
	pwd
}
echo "la = ls -alh --color=auto and pwd"
echo

cd()
{
    builtin cd $*
    pwd
}
echo "cd = cd and pwd"
echo

alias ShowEnv="printenv | less"
echo "ShowEnv = printenv | less"
echo

alias rpmi="sudo rpm -ivh"
echo "rpmi = install rpm"
echo

alias rpme="sudo rpm -e"
echo "rpme = uninstall rpm"
echo

if [ -z "$JWTOOLS_ENABLED" ] ; then
    TM=$( echo -e '\u2122')

    # \W is the current folder
    # \u is the user
    # \h is the server
    #export PS1="[jwTools$TM \h \W]$ "

	# With color
	END_COLOR='\[\e[m\]'
	COLOR_WHITE='\[\e[0m\]'
	COLOR_CYAN='\[\e[0;36m\]'
	COLOR_PURPLE='\[\e[0;35m\]'
	COLOR_RED='\[\e[0;31m\]'
	
	# Too much spacing
	#export PS1="[$COLOR_CYAN jwTools$TM $END_COLOR $COLOR_PURPLE \h $END_COLOR $COLOR_RED \W $END_COLOR]$ "
	
	# Correct spacing
	export PS1="[\[\e[0;36m\]jwTools$TM\[\e[m\] \[\e[0;35m\]\h\[\e[m\] \[\e[0;31m\]\W\[\e[m\]]$ "
fi

JWTOOLS_ENABLED=117;
