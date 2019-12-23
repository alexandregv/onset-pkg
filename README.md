# Onset-pkg
An [Onset](https://playonset.com) package utility to manage your packages in-game.  
Also check: 
- [alexandregv/OnsetPackages](https://github.com/alexandregv/OnsetPackages): a list of all my packages
- [alexandregv/awesome-onset](https://github.com/alexandregv/awesome-onset): an awesome list of all the bests packages

## Commands
- `/pkg help`: Print usage information
- `/pkg list [<started|stopped>]`: List all packages on the server
- `/pkg info <packages>`: Get informations about one or more package(s)
- `/pkg start <packages>`: Start one or more package(s)
- `/pkg stop <packages>`: Stop one or more package(s)
- `/pkg restart <packages>`: Restart one or more package(s)
- `/pkg restart-all`: Restart all packages
- `/pkg restart-list`: Restart packages defined with `/pkg set restart-list`
- `/pkg set restart-list <packages>`: Set a list of packages to restart with `/pkg restart-list` or F5 (see [Keys](#keys))
- `/pkg get restart-list`: Get the list of packages defined with `/pkg set restart-list`
- `/pkg set restart-key`: Set the key that triggers `/pkg restart-list`
- `/pkg get restart-key`: Get the key that triggers `/pkg restart-list`

## Keys
- `F5`: Equivalent of `/pkg restart-list`. Can be changed with `/pkg set restart-key`.

## Aliases
Because I know you are a lazy person, these words can be replaced by their alias.
- `help` == `h`
- `list` == `l`
- `info` == `i`
- `start` == `+`
- `stop` == `-`
- `restart` == `r`
- `restart-all` == `ra`
- `restart-list` == `rl`
- `restart-key` == `rk`

## Examples
- `/pkg list`: Prints all installed packages
- `/pkg l started`: Prints all started packages
- `/pkg info roleplay`: Prints infos about the "roleplay" package
- `/pkg start setupmap roleplay debug`: Starts the "setupmap", "roleplay" and "debug" packages
- `/pkg - setupmap`: Stops the "setupmap" package
- `/pkg restart roleplay`: Restarts the "roleplay" package
- `/pkg set restart-list roleplay greeter`: Saves "roleplay" and "greeter" packages into the restart-list
- `/pkg rl`: Restarts packages in the restart-list ("roleplay" and "greeter")
- `/pkg restart-all`: Restarts all packages, excepted itself (this would crash your server)
- `/pkg set restart-key F6`: Sets the restart-key to F6 instead of the default F5
- `/pkg get rk`: Gives the restart-key, currently F6
- `*Press F6*`: Same as `/pkg restart-list`, so restarts "roleplay" and "greeter"
