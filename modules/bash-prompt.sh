#!/usr/bin/env bash
#
# Copyright (c) 2015-2017 Vegard IT GmbH, http://vegardit.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @author Sebastian Thomschke, Vegard IT GmbH
# @author Patrick Spielmann, Vegard IT GmbH

if [[ $TERM == "cygwin" ]]; then
    BASH_FUNK_DIRS_COLOR="${BASH_FUNK_DIRS_COLOR:-1;34}"
else
    BASH_FUNK_DIRS_COLOR="${BASH_FUNK_DIRS_COLOR:-0;94}"
fi

# change the color of directories in ls
TMP_LS_COLORS=$(dircolors -b)
eval "${TMP_LS_COLORS/di=01;34/di=${BASH_FUNK_DIRS_COLOR}}" # replace 01;34 with custom colors
unset TMP_LS_COLORS


function __-bash-prompt() {
    # Save the return code of last command
    local lastRC=$?

    # http://superuser.com/questions/750138/bash-is-losing-history-even-though-shopt-s-histappend-is-set
    history -a

    if hash tput &>/dev/null; then
        export COLUMNS=$(tput cols)
    else
        export COLUMNS=$(stty size| cut -d' ' -f 2)
    fi

    # Calculate the current path to be displayed in the bash prompt
    local pwd=${PWD/#$HOME/\~}
    local pwdBasename=${pwd##*/}
    local pwdMaxWidth=$(( ( $COLUMNS-4 < ${#pwdBasename} ) ? ${#pwdBasename} : $COLUMNS-4 )) # max length of the path to be displayed
    local pwdOffset=$(( ${#pwd} - pwdMaxWidth ))
    if [[ $pwdOffset -gt 0 ]]; then
        pwd=${pwd:$pwdOffset:$pwdMaxWidth}
        pwd=../${pwd#*/}
    fi

    local C_RESET="\033[0m"
    local C_FX_BOLD="\033[1m"
    local C_FX_BOLD_OFF="\033[22m"
    #local C_FX_ITALIC="\033[3m"
    #local C_FX_UNDERLINE="\033[4m"
    #local C_FX_UNDERLINE_DOUBLE="\033[21m"
    #local C_FX_UNDERLINE_OFF="\033[24m"
    #local C_FX_BLINK_SLOW="\033[5m"
    #local C_FX_BLINK_FAST="\033[6m"
    #local C_FX_BLINK_OFF="\033[25m"
    #local C_FX_INVERT="\033[7m"
    #local C_FX_INVERT_OFF="\033[27m"
    local C_FG_BLACK="\033[30m"
    #local C_FG_RED="\033[31m"
    #local C_FG_GREEN="\033[32m"
    #local C_FG_YELLOW="\033[33m"
    #local C_FG_BLUE="\033[34m"
    #local C_FG_MAGENTA="\033[35m"
    #local C_FG_CYAN="\033[36m"
    local C_FG_WHITE="\033[37m"
    #local C_FG_LIGHT_RED="\033[91m"
    #local C_FG_LIGHT_GREEN="\033[92m"
    #local C_FG_LIGHT_YELLOW="\033[93m"
    #local C_FG_LIGHT_BLUE="\033[94m"
    #local C_FG_LIGHT_MAGENTA="\033[95m"
    #local C_FG_LIGHT_CYAN="\033[96m"
    local C_FG_LIGHT_WHITE="\033[97m"
    #local C_BG_BLACK="\033[40m"
    local C_BG_RED="\033[41m"
    local C_BG_GREEN="\033[42m"
    #local C_BG_YELLOW="\033[43m"
    #local C_BG_BLUE="\033[44m"
    #local C_BG_MAGENTA="\033[45m"
    #local C_BG_CYAN="\033[46m"
    #local C_BG_WHITE="\033[47m"
    #local C_BG_LIGHT_BLACK="\033[100m"
    #local C_BG_LIGHT_RED="\033[101m"
    #local C_BG_LIGHT_GREEN="\033[102m"
    #local C_BG_LIGHT_YELLOW="\033[103m"
    #local C_BG_LIGHT_BLUE="\033[104m"
    #local C_BG_LIGHT_MAGENTA="\033[105m"
    #local C_BG_LIGHT_CYAN="\033[106m"
    #local C_BG_LIGHT_WHITE="\033[107m"
    local BG="${C_RESET}${C_BG_GREEN}"

    if [[ $lastRC == 0 ]]; then
        lastRC=""
    else
        lastRC="[$lastRC] "
        BG="${C_RESET}${C_BG_RED}"
    fi

    if [[ $TERM == "cygwin" ]]; then
        local white="$C_FX_BOLD$C_FG_WHITE"
    else
        local white="$C_FG_LIGHT_WHITE"
    fi

    local LINE1="${BG}$lastRC${white}\u${C_RESET}${BG} ${C_FG_BLACK}| ${white}\h${C_RESET}${BG} ${C_FG_BLACK}| \d \t | \j Jobs | tty #\l ${C_RESET}"
    local LINE2="[\033[${BASH_FUNK_DIRS_COLOR}m${pwd}${C_RESET}]"
    PS1="\n$LINE1\n$LINE2\n$ "
}
