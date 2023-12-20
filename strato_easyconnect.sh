#!/bin/bash

# --
source config
# --
if [ ! -d "$HOME/.ssh/controlmasters/" ]; then
  mkdir -p "$HOME/.ssh/controlmasters/" 
fi

CONTROLMASTER="-o ControlMaster=auto  -o ControlPath='~/.ssh/controlmasters/%r@%h' -o ControlPersist=600"

# -- 
if ! ping -c 1 ai-fe02.srv.aau.dk &> /dev/null; then
  COMMAND="ssh -J $AAU_UPN@sshgw.aau.dk $CONTROLMASTER -i $IDENTITY_FILE ubuntu@10.92."
  echo -n $COMMAND; read LAST_BIT
  eval $COMMAND$LAST_BIT
else  
  COMMAND="ssh $CONTROLMASTER -i $IDENTITY_FILE ubuntu@10.92."
  echo -n $COMMAND; read LAST_BIT
  eval $COMMAND$LAST_BIT
fi
