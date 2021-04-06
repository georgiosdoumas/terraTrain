# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=yes
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\n[\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;202m\]\u\[$(tput sgr0)\]]-[\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;202m\]\h\[$(tput sgr0)\]]-[\[$(tput sgr0)\]\[\033[38;5;202m\]\W\[$(tput sgr0)\]]-[\[$(tput sgr0)\]\[\033[38;5;202m\]\A\[$(tput sgr0)\]-\[$(tput sgr0)\]\[\033[38;5;202m\]\d\[$(tput sgr0)\]]\n\\$ \[$(tput sgr0)\]'

else
    PS1='\n[\[$(tput bold)\]\u\[$(tput sgr0)\]]-[\[$(tput bold)\]\h\[$(tput sgr0)\]]-[\W]-[\A-\d]\n\\$ \[$(tput sgr0)\]'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1='\n[\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;202m\]\u\[$(tput sgr0)\]]-[\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;202m\]\h\[$(tput sgr0)\]]-[\[$(tput sgr0)\]\[\033[38;5;202m\]\W\[$(tput sgr0)\]]-[\[$(tput sgr0)\]\[\033[38;5;202m\]\A\[$(tput sgr0)\]-\[$(tput sgr0)\]\[\033[38;5;202m\]\d\[$(tput sgr0)\]]\n\\$ \[$(tput sgr0)\]'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
source /terraTrain/config.tfvars
complete -C /usr/bin/terraform terraform
alias d="docker"
alias k="kubectl"
alias k-n-kubesystem="kubectl -n kube-system"
alias tt-purge="terraform destroy --force -compact-warnings -var-file=/terraTrain/config.tfvars"
alias tt-genClientBundle="/bin/bash /terraTrain/client-bundle.sh"

# terraTrain-run function to create a cluster
tt-plan() {
    terraform plan -var-file=/terraTrain/config.tfvars
}
tt-run() {
var="aaaaaaaaaaaaallllllllllllllllllllllllllF"
/usr/games/sl -e sl -${var:$(( RANDOM % ${#var} )):1} 
terraform apply -var-file=/terraTrain/config.tfvars -auto-approve -compact-warnings
#echo "Yey! All of the instance were created by MKE installation is still in progress."
#echo "Do you want to see MKE installation logs?"
#echo "Press y to see the logs and press any other key to ignore"
#echo "You can close this log watching session with ctrl+c"

#read input
#if (( "$input" == 'y' || "$input" == 'Y' )) ; then
#    mke=$(cat terraform.tfstate 2>/dev/null | jq -r '.resources[] | select(.name=="ucp-leader") | .instances[] | .attributes.public_dns' 2>/dev/null)
#    mke_username=$(awk -F= -v key="amiUserName" '$1==key {print $2}' /terraTrain/config.tfvars  | tr -d '"' | tr -d "\n")
#
#    if (( $(awk -F= -v key="amiUserName" '$1==key {print $2}' /terraTrain/config.tfvars  | tr -d '"' | tr -d "\n") == 'ubuntu' )) ; then 
#    ssh -i key-pair -o StrictHostKeyChecking=false -l ${mke_username} ${mke} "sudo tail -f /var/log/cloud-init-output.log"   
#
#    elif (( $(awk -F= -v key="amiUserName" '$1==key {print $2}' /terraTrain/config.tfvars  | tr -d '"' | tr -d "\n") == 'ec2-user' )) ; then
#    # redhat 7 put all the cloud-init logs inside messages where redhat 8 uses cloud-init-output.log file
#    ssh -i key-pair -o StrictHostKeyChecking=false -l ${mke_username} ${mke} "if [ ! -f /var/log/cloud-init-output.log ] ; then sudo tail -f /var/log/messages | grep cloud-init; else sudo tail -f /var/log/cloud-init-output.log; fi"
#    
#    elif (( $(awk -F= -v key="amiUserName" '$1==key {print $2}' /terraTrain/config.tfvars  | tr -d '"' | tr -d "\n") == 'centos' )) ; then
#    mke=$(cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="ucp-leader") | .instances[] | .attributes.public_dns' 2>/dev/null)
#    ssh -i key-pair -o StrictHostKeyChecking=false -l ${mke_username} ${mke} "sudo tail -f /var/log/messages | grep cloud-init"   
#
#    else
#        echo "My bad. Can't detect the os"
#    fi
#else
#    exit 0
#fi
tt-show
}


# terraTrain-show function to list the cluster details (more efficient than terraform binary) [time of execution: real	0m0.021s, user	0m0.019s, sys	0m0.005s ]
tt-show() {
printf "\n\n MKE's Username and Password: \n"
echo "-------------------------------------------------------------------------------"
printf '\e[1;34m%-6s\e[m' "Username: "
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="mke_username") | .instances[] | .attributes.id' 2>/dev/null
printf  '\e[1;34m%-6s\e[m' "Password: "
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="mke_password") | .instances[] | .attributes.result' 2>/dev/null

printf "\n\n Leader Node: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="ucp-leader") | .instances[] | { Name: .attributes.tags.Name, URL: ("https://" + .attributes.public_dns), Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
printf "\n\n Manager Nodes: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="managerNode") | .instances[] | { Name: .attributes.tags.Name, URL: ("https://" + .attributes.public_dns), Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
printf "\n\n MSR Nodes: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="dtrNode") | .instances[] | { Name: .attributes.tags.Name, URL: ("https://" + .attributes.public_dns), Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
printf "\n\n Worker Nodes: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="workerNode") | .instances[] | { Name: .attributes.tags.Name, Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
}
tt-show-mke-creds() {
printf "\n\n MKE's Username and Password: \n"
echo "-------------------------------------------------------------------------------"
printf '\e[1;34m%-6s\e[m' "Username: "
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="mke_username") | .instances[] | .attributes.id' 2>/dev/null
printf '\e[1;34m%-6s\e[m' "Password: "
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="mke_password") | .instances[] | .attributes.result' 2>/dev/null
}
tt-show-ldr() {
printf "\n\n Leader Node: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="ucp-leader") | .instances[] | { Name: .attributes.tags.Name, URL: ("https://" + .attributes.public_dns), Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
printf '\e[1;34m%-6s\e[m' "Username: "
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="mke_username") | .instances[] | .attributes.id' 2>/dev/null
printf '\e[1;34m%-6s\e[m' "Password: "
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="mke_password") | .instances[] | .attributes.result' 2>/dev/null

}
tt-show-mgr() {
printf "\n\n Manager Nodes: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="managerNode") | .instances[] | { Name: .attributes.tags.Name, URL: ("https://" + .attributes.public_dns), Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
}
tt-show-msr() {
printf "\n\n MSR Nodes: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="dtrNode") | .instances[] | { Name: .attributes.tags.Name, URL: ("https://" + .attributes.public_dns), Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
}
tt-show-wkr() {
printf "\n\n Worker Nodes: \n"
echo "-------------------------------------------------------------------------------"
cat terraform.tfstate 2>/dev/null | jq '.resources[] | select(.name=="workerNode") | .instances[] | { Name: .attributes.tags.Name, Hostname: .attributes.private_dns, PublicDNS: .attributes.public_dns, PublicIP: .attributes.public_ip }' 2>/dev/null
}

tt-msr-rethinkcli() {
msr=$(cat terraform.tfstate 2>/dev/null | jq -r '.resources[] | select(.name=="dtrNode") | .instances[] | .attributes.public_dns' 2>/dev/null | head -n 1)
ssh -i ./key-pair -o StrictHostKeyChecking=false  -l $(awk -F= -v key="amiUserName" '$1==key {print $2}' /terraTrain/config.tfvars  | tr -d '"' | tr -d "\n") $msr 'exec sudo docker run -it --rm --net dtr-ol -v dtr-ca-e6e1331b4888:/ca dockerhubenterprise/rethinkcli:v2.2.0  e6e1331b4888'
}

tt-msr-login() {

msr=$(cat terraform.tfstate 2>/dev/null | jq -r '.resources[] | select(.name=="dtrNode") | .instances[] | .attributes.public_dns' 2>/dev/null | head -n 1)
uname=$(cat terraform.tfstate 2>/dev/null | jq -r '.resources[] | select(.name=="mke_username") | .instances[] | .attributes.id' 2>/dev/null)
pass=$(cat terraform.tfstate 2>/dev/null | jq -r '.resources[] | select(.name=="mke_password") | .instances[] | .attributes.result' 2>/dev/null)
if [[ -d /terraTrain/client-bundle ]] 
    then 
    curl -k https://$msr/ca -o /usr/local/share/ca-certificates/$msr.crt 
    update-ca-certificates
    docker login $msr -u $uname -p $pass
else 
    tt-genClientBundle
    curl -k https://$msr/ca -o /usr/local/share/ca-certificates/$msr.crt 
    update-ca-certificates
    docker login $msr -u $uname -p $pass
fi
}
tt-msr-populate-img() {
msr=$(cat terraform.tfstate 2>/dev/null | jq -r '.resources[] | select(.name=="dtrNode") | .instances[] | .attributes.public_dns' 2>/dev/null | head -n 1)

}
tt-msr-populate-orgs() {
msr=$(cat terraform.tfstate 2>/dev/null | jq -r '.resources[] | select(.name=="dtrNode") | .instances[] | .attributes.public_dns' 2>/dev/null | head -n 1)

}

# Connect function to ssh into a machine
connect() {
ssh -i ./key-pair -o StrictHostKeyChecking=false  -l $(awk -F= -v key="amiUserName" '$1==key {print $2}' /terraTrain/config.tfvars  | tr -d '"' | tr -d "\n") $1 "$2"
}