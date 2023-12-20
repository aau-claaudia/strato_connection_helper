# EasyConnect for Strato

EasyConnect solves two problems:

1. Strato instances are often launched for short lived purposes. The command for connecting to them is usually ~98 % the same (only the last two bits in the IP change). Typing that takes a long time. EasyConnect only asks you for the two last bits.

2. Strato instances are most often launched on the "Campus Networks", and are thus only reachable if you are on AAU network. If you are not already on AAU network, Easyconnect will find your instance through the SSH-Gateway. EasyConnect can also reuse your previous connections, reducing the need for authentication and allowing for faster logins.

### Install

Add this to your `.bashrc`/`.zshrc` to ensure that you can run the commands.

One way of doing this is navigating to this repo and calling:

BASH:
```
alias strato="bash $(pwd)/strato_easyconnect.sh" >> $HOME/.bashrc
```

ZSH:
```
echo alias strato="bash $(pwd)/strato_easyconnect.sh" >> $HOME/.zshrc
```

### Configuration

EasyConnect relies on two user variables that you must change in the file `strato_easyconnect.sh`. Look inside the file for more information.

### Bugs
In case you lose your internet connection, the socket file can not be reused and you will have to delete the file manually. I'm working on a solution for doing this automatically.
