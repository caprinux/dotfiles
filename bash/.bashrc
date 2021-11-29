#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# load bash_aliases
if [[ -f ~/.bash_aliases ]]; then
 source ~/.bash_aliases 
fi

# colorize commands
if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
# 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
. /usr/share/LS_COLORS/dircolors.sh

# var
etc=/home/cap/Workspace/etc

# startup
PATH=/home/cap/Workspace/bin:$PATH:/home/cap/.local/bin:/home/cap/.local/share/gem/ruby/3.0.0/bin
eval "$(starship init bash)"

# etc
export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR="nvim"
export PYTHONBREAKPOINT=ipdb.set_trace
export PYTHONWARNINGS="ignore"

# completion
source $etc/ga-cmd-completion.sh
source $etc/key-bindings.bash 
source $etc/completion.bash

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'
export FZF_COMPLETION_TRIGGER=,,

# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/usr/lib/kitty/shell-integration/kitty.bash"; then source "/usr/lib/kitty/shell-integration/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/2.2.19/gems/vagrant-2.2.19/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)
