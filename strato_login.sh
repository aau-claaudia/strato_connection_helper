
#!/bin/bash

# ==================================
# -- VARIABLES
AAU_UPN='cc11gz@its.aau.dk'
ssh_key="$HOME/Filen_io/ssd_env/ssh/keys/generic/ssd_24q3"
host_user='ubuntu'
first_bit='10.92.'
login_history="$(dirname ${BASH_SOURCE[0]})/.strato_login_history"
jumphost_arg=""
ctrlm_time=28800
ctrlm_path="$HOME/.ssh/controlmasters"; mkdir -p $ctrlm_path
ctrlm_arg="-o ControlMaster=auto -o ControlPath=$ctrlm_path/%r@%h -o ControlPersist=$ctrlm_time"

# Determine if we are on aau network
if ! ping -c 1 ai-fe02.srv.aau.dk &> /dev/null; then
  jumphost_arg="-J $AAU_UPN@sshgw.aau.dk"
fi

# ==================================
# -- READ 
# Gather command
ssh_cmd="ssh $jumphost_arg -i $ssh_key $@ $host_user@$first_bit"

# Print ssh-command
echo -n "$ssh_cmd"

# Read last bit
last_bit=$(bash -c "read last_bit; echo \$last_bit")

# Find the two last bits of the IP 
if [[ -z "$last_bit" ]]; then
  if [[ -f "$login_history" ]]; then
    # Get last bit from file
    last_bit=$(awk -F "." 'END { print $3 "." $4 }' < $login_history)
    ssh_cmd="${ssh_cmd}${last_bit}"
    echo -en "\033[1A\033[2K"   # Removes previous line (which is empty because user hit enter)
    echo -e "$ssh_cmd"          # Prints the complete command to the line
  else
    echo -e "\nRemote host IP was not finished, and no login history file was found."
    exit 1
  fi
fi

# ==================================
# -- CONNECT
# Check if socket file exists
ctrlm_socket_file=$(find "$ctrlm_path" -type s -name "*$user_name@$first_bit$last_bit*")

# Check if the socket file works - if not, remove it.
if [[ -n $ctrlm_socket_file ]]; then
  timeout 1 ssh $host hostname &> /dev/null
  if [[ $? > 0 ]]; then
    rm $ctrlm_socket_file
  fi
fi

eval $ssh_cmd

# ==================================
# -- LOG
# Log successful connection 
echo "$(date "+%Y-%m-%d_%H:%M") $host_user@$first_bit$last_bit" > $login_history
