#virtualenv setup for wehkamp
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$(which python2)
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
which virtualenvwrapper.sh > /dev/null && source $(which virtualenvwrapper.sh)

export ANSIBLE_ROLES_PATH=/home/rjs/workspaces/wehkamp/rebb-ansible-roles

function gotossh() {
  local ipregex="(\d+[^\d]?){3}\d+"
  local ip=$(echo "$@" | grep -Po "$ipregex" | sed "s/[^0-9]/./g")
  if ! echo "$ip" | grep -qPo "$ipregex"
  then
    echo "Not a valid ip adress: \"$@\""
  else
    ssh root@"$ip"
  fi
}

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

alias cclip='xclip -selection clipboard'
alias clipp='xclip -selection clipboard -o'

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [ -f ~/.nvm/nvm.sh ]
then
  source ~/.nvm/nvm.sh
fi

export REBB_WEBSITE_DEVELOPMENT=true
export NODE_ENV=development

alias li='list_instances -r eu-west-1 -H ID,State,T:Environment,T:Name,IP,PrivateIP'
alias offsets_dev='ssh $(li | awk '\''$3=="developmentCI" && $4=="queue-node" && $6!="None"{print $6;exit}'\'') -l root /opt/kafka/bin/kafka-consumer-offset-checker.sh --zookeeper $(li | awk '\''$3=="developmentCI" && $4=="zookeeper-node" && $6!="None"{print $6":2181";exit}'\'') --group'
alias offsets_accept='ssh $(li | awk '\''$3=="accept" && $4=="queue-node" && $6!="None"{print $6;exit}'\'') -l root /opt/kafka/bin/kafka-consumer-offset-checker.sh --zookeeper $(li | awk '\''$3=="accept" && $4=="zookeeper-node" && $6!="None"{print $6":2181";exit}'\'') --group'
alias offsets_production='ssh $(li | awk '\''$3=="production" && $4=="queue-node" && $6!="None"{print $6;exit}'\'') -l root /opt/kafka/bin/kafka-consumer-offset-checker.sh --zookeeper $(li | awk '\''$3=="production" && $4=="zookeeper-node" && $6!="None"{print $6":2181";exit}'\'') --group'

export PATH=/opt/android-sdk/platform-tools:$PATH

which thefuck > /dev/null && eval $(thefuck --alias)

alias sbt='sbt -mem 2048'

if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

#enable Ctrl-S and Ctrl-q in terminals
stty -ixon
