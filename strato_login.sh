#!/bin/bash

# ==========================================
# Variables

# -- Mandatory:
# Change this to your actual AAU UPN
AAU_UPN="aa00xx@its.aau.dk"

# Change this to the location of your ssh-key
IDENTITY_FILE="$HOME/.ssh/id_rsa"


# -- Optional
# How long should the connection be kept alive for?
CONTROLMASTER_TIME=3600 

# If the remote host has a different username, this can be set
HOST_USERNAME="ubuntu" 

# If remote ip is not in the 10.92 area, this can be set
HOST_IP="10.92." 

# No need to change anything below this line
# ==========================================

# cd to the location of script
cd $(dirname $0)

# -------------------------------------------
# Identify network
if ! ping -c 1 ai-fe02.srv.aau.dk &> /dev/null; then
  AAU_NETWORK="-J $AAU_UPN@sshgw.aau.dk"
else
  AAU_NETWORK=""
fi

# ------------------------------------------
# Controlmaster chunk
CONTROLPATH="$HOME/.ssh/controlmasters" ; mkdir -p $CONTROLPATH
CONTROLMASTER="-o ControlMaster=auto -o ControlPath=$CONTROLPATH/%r@%h -o ControlPersist=$CONTROLMASTER_TIME"

# Locate $SOCKET_FILE (if exists)
SOCKET_FILE=$(find $CONTROLPATH -type s -name "*$HOST_USERNAME*$HOST_IP$LAST_BIT")

# Determine age of $SOCKET_FILE
if [ ! -z $SOCKET_FILE ]; then
  if [ "$(uname)" = "Darwin" ]; then
    SOCKET_FILE_AGE=$(stat -f "%m" $SOCKET_FILE)
  elif [ "$(uname)" = "Linux" ]; then
    SOCKET_FILE_AGE=$(stat -c %Y $SOCKET_FILE)
  fi
  SOCKET_TIME_LEFT=$(echo "$(date +%s) - $SOCKET_FILE_AGE" | bc)
  echo "Control socket: $SOCKET_TIME_LEFT/$CONTROLMASTER_TIME sec"
  echo ""
fi

# -------------------------------------------
# Print ssh-command and read last bit of IP
COMMAND="ssh $AAU_NETWORK -i $IDENTITY_FILE $HOST_USERNAME@$HOST_IP"

echo -e "$COMMAND\c"
LAST_BIT=$(bash -c "read last_bit; echo \$last_bit")

if [[ -z "$LAST_BIT" ]]; then
  if [[ ! -f ".strato_login_history" ]]; then
    echo -e "\nAborting! Remote host IP wasn't finished, and no login history file was found."
    exit 1
  fi
  echo -en "\033[1A\033[2K"
  LAST_BIT=$(awk -F "." 'END { print $3 "." $4 }' < .strato_login_history)
  echo -e "$COMMAND$LAST_BIT"
fi

# ------------------------------------------
ssh $AAU_NETWORK $CONTROLMASTER -i $IDENTITY_FILE $HOST_USERNAME@$HOST_IP$LAST_BIT

# ------------------------------------------
echo "$(date "+%Y-%m-%d %H:%M")  $HOST_USERNAME@$HOST_IP$LAST_BIT" >> .strato_login_history
