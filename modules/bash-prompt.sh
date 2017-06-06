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

if ! hash svn &>/dev/null; then
    BASH_FUNK_NO_PROMPT_SVN=1
fi
if ! hash git &>/dev/null; then
    BASH_FUNK_NO_PROMPT_GIT=1
fi

# change the color of directories in ls
if hash dircolors &>/dev/null; then
    TMP_LS_COLORS=$(dircolors -b)
    eval "${TMP_LS_COLORS/di=01;34/di=${BASH_FUNK_DIRS_COLOR}}" # replace 01;34 with custom colors
    unset TMP_LS_COLORS
fi

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
    local C_BOLD="\033[1m"
    local C_BOLD_OFF="\033[22m"
    local C_FG_BLACK="\033[30m"
    local C_FG_YELLOW="\033[30m"
    local C_FG_GRAY="\033[37m"
    local C_FG_WHITE="\033[97m"
    local C_BG_RED="\033[41m"
    local C_BG_GREEN="\033[42m"

    if [[ $TERM == "cygwin" ]]; then
        local C_FG_WHITE="$C_BOLD$C_FG_GRAY"
        local C_FG_LIGHT_YELLOW="$C_BOLD$C_FG_YELLOW"
    else
        local C_FG_WHITE="\033[97m"
        local C_FG_LIGHT_YELLOW="\033[93m"
    fi

    if [[ $lastRC == 0 ]]; then
        lastRC=""
        local bg="${C_RESET}${C_BG_GREEN}"
    else
        lastRC="[$lastRC] "
        local bg="${C_RESET}${C_BG_RED}"
    fi

    [[ ${BASH_FUNK_NO_PROMPT_DATE:-} ]] && local p_date= || local p_date="| \d \t "
    [[ ${BASH_FUNK_NO_PROMPT_JOBS:-} ]] && local p_jobs= || local p_jobs="| \j Jobs "
    [[ ${BASH_FUNK_NO_PROMPT_TTY:-}  ]] && local p_tty=  || local  p_tty="| tty #\l "

    local p_scm
    if [[ ! ${BASH_FUNK_NO_PROMPT_GIT:-} ]]; then
        if p_scm=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null); then
            local modifications=$(git ls-files -o -m -d --exclude-standard | wc -l)
            if [[ $modifications && $modifications != "0" ]]; then
                p_scm="git:$p_scm${C_FG_WHITE}($modifications)"
            else
                p_scm="git:$p_scm"
            fi
        fi
    fi

    if [[ ! $p_scm && ! ${BASH_FUNK_NO_PROMPT_SVN:-} ]]; then
        # extracting trunk/branch info without relying using sed/grep for higher performance
        if p_scm=$(svn info 2>/dev/null); then
            if [[ "$p_scm" == *URL:* ]]; then
                p_scm="${p_scm#*$'\n'URL: }" # substring after URL:
                p_scm="${p_scm%%$'\n'*}"     # substring before \n
                case $p_scm in
                    */trunk|*/trunk/*)
                        p_scm="trunk"
                      ;;
                    */branches/*)
                        p_scm="${p_scm#*branches/}"
                        p_scm="${p_scm%%/*}"
                      ;;
                    */tags/*)
                        p_scm="${p_scm#*tags/}"
                        p_scm="${p_scm%%/*}"
                      ;;
                esac

                if [[ $p_scm ]]; then
                    local modifications=$(svn status | wc -l)
                    if [[ $modifications && $modifications != "0" ]]; then
                        p_scm="svn:$p_scm${C_FG_WHITE}($modifications)"
                    else
                        p_scm="svn:$p_scm"
                    fi
                fi
            fi
        fi
    fi

    if [[ $p_scm ]]; then
        p_scm="| ${C_FG_LIGHT_YELLOW}$p_scm${C_FG_BLACK} "
    fi

    local LINE1="${bg}$lastRC${C_FG_WHITE}\u${C_RESET}${bg} ${C_FG_BLACK}| ${C_FG_WHITE}\h${C_RESET}${bg} ${C_FG_BLACK}${p_scm}${p_date}${p_jobs}${p_tty}${C_RESET}"
    local LINE2="[\033[${BASH_FUNK_DIRS_COLOR}m${pwd}${C_RESET}]"
    local LINE3="$ "
    PS1="\n$LINE1\n$LINE2\n$LINE3"
}
