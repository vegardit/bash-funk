#!/bin/bash
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

function -bash-prompt() {
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

    local C_RESET="\e[0m"
    local C_FX_BOLD="\e[1m"
    local C_FX_BOLD_OFF="\e[22m"
    #local C_FX_ITALIC="\e[3m"
    #local C_FX_UNDERLINE="\e[4m"
    #local C_FX_UNDERLINE_DOUBLE="\e[21m"
    #local C_FX_UNDERLINE_OFF="\e[24m"
    #local C_FX_BLINK_SLOW="\e[5m"
    #local C_FX_BLINK_FAST="\e[6m"
    #local C_FX_BLINK_OFF="\e[25m"
    #local C_FX_INVERT="\e[7m"
    #local C_FX_INVERT_OFF="\e[27m"
    local C_FG_BLACK="\e[30m"
    #local C_FG_RED="\e[31m"
    #local C_FG_GREEN="\e[32m"
    #local C_FG_YELLOW="\e[33m"
    local C_FG_BLUE="\e[34m"
    #local C_FG_MAGENTA="\e[35m"
    #local C_FG_CYAN="\e[36m"
    local C_FG_WHITE="\e[37m"
    #local C_FG_LIGHT_RED="\e[91m"
    #local C_FG_LIGHT_GREEN="\e[92m"
    #local C_FG_LIGHT_YELLOW="\e[93m"
    #local C_FG_LIGHT_BLUE="\e[94m"
    #local C_FG_LIGHT_MAGENTA="\e[95m"
    #local C_FG_LIGHT_CYAN="\e[96m"
    #local C_FG_LIGHT_WHITE="\e[97m"
    #local C_BG_BLACK="\e[40m"
    local C_BG_RED="\e[41m"
    local C_BG_GREEN="\e[42m"
    #local C_BG_YELLOW="\e[43m"
    #local C_BG_BLUE="\e[44m"
    #local C_BG_MAGENTA="\e[45m"
    #local C_BG_CYAN="\e[46m"
    #local C_BG_WHITE="\e[47m"
    #local C_BG_LIGHT_BLACK="\e[100m"
    #local C_BG_LIGHT_RED="\e[101m"
    #local C_BG_LIGHT_GREEN="\e[102m"
    #local C_BG_LIGHT_YELLOW="\e[103m"
    #local C_BG_LIGHT_BLUE="\e[104m"
    #local C_BG_LIGHT_MAGENTA="\e[105m"
    #local C_BG_LIGHT_CYAN="\e[106m"
    #local C_BG_LIGHT_WHITE="\e[107m"
    local BG="${C_RESET}${C_BG_GREEN}"

    if [[ $lastRC == 0 ]]; then
        lastRC=""
    else
        lastRC="[$lastRC] "
        BG="${C_RESET}${C_BG_RED}"
    fi

    local LINE1="${BG}$lastRC${C_FG_WHITE}${C_FX_BOLD}\u${C_FX_BOLD_OFF} ${C_FG_BLACK}| ${C_FG_WHITE}${C_FX_BOLD}\h${C_FX_BOLD_OFF} ${C_FG_BLACK}| \d \t | \j Jobs | tty #\l ${C_RESET}"
    local LINE2="[${C_FX_BOLD}${C_FG_BLUE}${pwd}${C_RESET}]"
    PS1="\n$LINE1\n$LINE2\n$ "
}
