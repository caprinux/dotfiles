# basic stuff
alias bash='source ~/.bashrc'
alias bat='bat --paging=never'
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fzfs=$'rg . | fzf --print0 -e | awk -F: \'{print $1}\''
alias neo='neofetch'

# ctf aliases
alias ida32='wine ~/Workspace/CTF/Tools/Pwn/IDA/IDA\ Pro\ 7.6/ida.exe'
alias ida64='wine ~/Workspace/CTF/Tools/Pwn/IDA/IDA\ Pro\ 7.6/ida64.exe'
alias dbg='gdb -q --eval-command=init-pwndbg'
alias gef='gdb -q --eval-command=init-gef'
alias lslibs='ls ~/Workspace/CTF/Tools/Pwn/libcdb/libs/'
alias libcfind='~/Workspace/CTF/Tools/Pwn/libcdb/find'
alias libcid='~/Workspace/CTF/Tools/Pwn/libcdb/identify'

# dir transverse
alias play='cd ~/Workspace/Playground/'
alias ctf='cd ~/Workspace/CTF'
alias work='cd ~/Workspace/'
alias github='cd ~/Workspace/Git/'
alias vagr='cd ~/Workspace/Vagrant/'
