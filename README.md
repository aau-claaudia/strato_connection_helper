# EasyConnect for Strato

EasyConnect solves two problems:

1. Strato instances are often launched for short lived purposes. The command for connecting to them is usually ~98 % the same (only the last two bits in the IP change). Typing that takes a long time. EasyConnect only asks you for the two last bits. If you are attempting to login to the instance you last visited, you can just hit enter, and EasyConnect will do the rest.

2. Strato instances are most often launched on the "Campus Networks", and are thus only reachable if you are on AAU network. If you are not already on AAU network, Easyconnect will find your instance through the SSH-Gateway. EasyConnect can also reuse your previous connections, reducing the need for authentication and allowing for faster logins.

### Install

This is just a simple bash script, that is designed to run from anywhere.
One way of making it available to the shell is with an alias. Here we are assuming that $LOCATION is the location of the script.

Add this to your `.bashrc`/`.zshrc` to ensure that you can run the command.
```
alias strato="bash $LOCATION/strato_easyconnect.sh"
```

### Configuration

EasyConnect relies on two user variables that you must change in the file `strato_easyconnect.sh`. Look inside the file for more information.

### Bugs
In case you lose your internet connection, the socket file can not be reused and you will have to delete the file manually. I'm working on a solution for doing this automatically.
