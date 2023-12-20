#!/bin/bash

# -- 
JUMPHOST=""
IDENTITY_FILE="$HOME/.ssh/" # Replace with path of your SSH-key
CONTROLMASTER="-o ControlMaster=auto  -o ControlPath='~/.ssh/controlmasters/%r@%h' -o ControlPersist=600"

# --

if [ ! -d "$HOME/.ssh/controlmasters/" ]; then
  mkdir -p "$HOME/.ssh/controlmasters/" 
fi

# -- 

if ! ping -c 1 ai-fe02.srv.aau.dk &> /dev/null; then
  COMMAND="ssh $JUMPHOST $CONTROLMASTER $IDENTIFIYFILE ubuntu@10.92."
  echo -n $COMMAND; read LAST_BIT
  eval $COMMAND$LAST_BIT
else  
  COMMAND="ssh $CONTROLMASTER $IDENTITY_FILE ubuntu@10.92."
  echo -n $COMMAND; read LAST_BIT
  eval $COMMAND$LAST_BIT
fi
