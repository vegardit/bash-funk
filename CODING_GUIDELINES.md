# Bash Coding Guidelines and Best Practices


## Code Style
1. Always indent by four spaces, do not use tab characters.
1. Ensure lines do not end with white space characters (enable automatic line trimming in your editor of choice)
1. Place the keywords `then / do` on the same line like `if / for / while` and not a separate line.
1. Always use `$( myCommand )` instead of backticks ` `` myCommand `` ` to execute commands in subshells


## Code Safety
1. Always use the `local` keyword when declaring variables within functions.
1. Prefer using lowercase variable names except when exporting them to environment. Otherwise unintentional clashes with existing environment variables, e.g. `$USER`, or `$PATH` may happen.
1. Prefer using the bash builtin double brackets test operator `[[ ... ]]` instead of the single bracket test operator. It supports glob/regex pattern matching and better handles testing of empty variables. See http://mywiki.wooledge.org/BashGuide/Practices#Bash_Tests


## Performance
1. Try to limit the usage of subshells which are expensive in emulated environments such as Cygwin.
    1. Use $PWD instead of $(pwd) to get the current path.
    1. Avoid unnecessary cat, use `command < file` instead of `cat file | command` which is executed in a subshell.

## Portability
1. Use `#!/usr/bin/env bash` instead of `#!/bin/bash`
1. Use `\033` as escape sequence instead of `\e` to support MacOS


## References

1. https://github.com/kvz/bash3boilerplate#best-practices
1. https://github.com/progrium/bashstyle
1. http://wiki.bash-hackers.org/scripting/obsolete
1. http://mywiki.wooledge.org/BashGuide/Practices
1. http://fahdshariff.blogspot.com/2013/10/shell-scripting-best-practices.html
