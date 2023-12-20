#!/bin/bash

# -- 
# Replace these to fit your own user credentials:
AAU_UPN="xx00xx@domain.aau.dk"  # Replace with your actual UPN
IDENTITY_FILE="$HOME/.ssh/key"  # Replace with the actual location of you SSH key
# --

if [ ! -d "$HOME/.ssh/controlmasters/" ]; then
  mkdir -p "$HOME/.ssh/controlmasters/" 
fi

CONTROLMASTER="-o ControlMaster=auto  -o ControlPath='~/.ssh/controlmasters/%r@%h' -o ControlPersist=900"

if ! ping -c 1 ai-fe02.srv.aau.dk &> /dev/null; then
  COMMAND="ssh -J $AAU_UPN@sshgw.aau.dk $CONTROLMASTER -i $IDENTITY_FILE ubuntu@10.92."
  echo -n $COMMAND; read LAST_BIT
  eval $COMMAND$LAST_BIT
else  
  COMMAND="ssh $CONTROLMASTER -i $IDENTITY_FILE ubuntu@10.92."
  echo -n $COMMAND; read LAST_BIT
  eval $COMMAND$LAST_BIT
fi
