# Easyconnect for Strato

Strato instances are often launched for short lived purposes. That's good. 

The command for connecting to them is usually ~98 % the same (only the last two bits in the IP change). Typing that takes a long time. That's bad. 

Easyconnect only asks you for the two last bits. That's a ~98 % improvement.

# Install

Add this to your `.bashrc`/`.zshrc` to ensure that you can run the commands.

One way of doing this is navigating to this repo and calling: 
```
alias strato="bash $(pwd)/strato_easyconnetch.sh"
```

## Configuration

EasyConnect has two variables that you must change once and for all: `JUMPHOST` and `IDENTITY_FILE'. 
Look inside `strato_easyconnect.sh` for more information.

### Bugs
If you lose your internet connection, the socket file can not be reused and you will have to delete the file.
I'm working on a solution for doing this automatically.
