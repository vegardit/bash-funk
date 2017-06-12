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
if ! hash screen &>/dev/null; then
    BASH_FUNK_NO_PROMPT_SCREEN=1
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

    # share command history accross Bash sessions
    history -a # add last command to history file
    history -n # reload new commands from history file

    # maintain directory history
    if [[ "${__BASH_FUNK_LAST_PWD:-}" != "$PWD" ]]; then
        echo "$PWD" >> ~/.bash_funk_dirs

        if [[ "${DIRSTACK:-}" ]]; then
            # search and remove previous entry of this dir from history
            local __idx
            for (( __idx=1; __idx<${#DIRSTACK[*]}; __idx++ )); do
                if [[ "${DIRSTACK[$__idx]}" == "$PWD" ]]; then
                    popd -n +$__idx >/dev/null
                    __idx=
                    break
                fi
            done
        fi
        pushd -n $PWD >/dev/null
        __BASH_FUNK_LAST_PWD=$PWD
    fi

    if shopt -q checkwinsize; then
        # shopt -s checkwinsize under cygwin does not work reliable
        if [[ $TERM == "cygwin" ]]; then
            printenv COLUMNS &>/dev/null # for some reason this forces updating of the $COLUMNS variable under cygwin
        fi
    else
        # manually determine the current terminal width
        if hash tput &>/dev/null; then
            export COLUMNS=$(tput cols)
        else
            export COLUMNS=$(stty size | cut -d' ' -f 2)
        fi
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
    local C_FG_YELLOW="\033[30m"
    local C_FG_GRAY="\033[37m"
    local C_FG_WHITE="\033[97m"
    local C_BG_RED="\033[41m"
    local C_BG_GREEN="\033[42m"
    local C_BG_YELLOW="\033[43m"

    if [[ $TERM == "cygwin" ]]; then
        local C_FG_BLACK="\033[22m\033[30m"
        local C_FG_WHITE="$C_BOLD$C_FG_GRAY"
        local C_FG_LIGHT_YELLOW="$C_BOLD$C_FG_YELLOW"
    else
        local C_FG_BLACK="\033[30m"
        local C_FG_WHITE="\033[97m"
        local C_FG_LIGHT_YELLOW="\033[93m"
    fi


    local p_lastRC p_bg
    if [[ $lastRC == 0 ]]; then
        p_bg="${C_BG_GREEN}"
        p_lastRC=""
    else
        p_bg="${C_BG_RED}"
        p_lastRC="${C_FG_GRAY}[$lastRC] "
    fi


    local p_user
    if [[ $EUID -eq 0 ]]; then
        # highlight root user yellow
        p_user="${C_FG_BLACK}${C_BG_YELLOW}*${USER}*${p_bg} "
    else
        p_user="${C_FG_WHITE}${USER}${C_FG_BLACK} "
    fi


    local p_host
    p_host="| ${C_FG_WHITE}\h${C_FG_BLACK} "


    local p_scm
    if [[ ! ${BASH_FUNK_PROMPT_NO_GIT:-} ]]; then
        if p_scm=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null); then
            local modifications=$(git ls-files -o -m -d --exclude-standard | wc -l)
            if [[ $modifications && $modifications != "0" ]]; then
                p_scm="git:$p_scm${C_FG_WHITE}($modifications)"
            else
                p_scm="git:$p_scm"
            fi
        fi
    fi
    if [[ ! $p_scm && ! ${BASH_FUNK_PROMPT_NO_SVN:-} ]]; then
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


    local p_date
    if [[ ! ${BASH_FUNK_PROMPT_NO_DATE:-} ]]; then
        p_date="| \d \t "
    fi


    local p_jobs
    if [[ ! ${BASH_FUNK_PROMPT_NO_JOBS:-} ]]; then
        if [[ $OSTYPE == "cygwin" ]]; then
            p_jobs="| \j jobs "
        else
            p_jobs=$(jobs -r | wc -l)
            case "$p_jobs" in
                0) p_jobs= ;;
                1) p_jobs="| ${C_FG_LIGHT_YELLOW}1 job${C_FG_BLACK} " ;;
                *) p_jobs="| ${C_FG_LIGHT_YELLOW}$p_job jobs${C_FG_BLACK} " ;;
            esac
        fi
    fi


    local p_screens
    if [[ ! ${BASH_FUNK_PROMPT_NO_SCREENS:-} ]]; then
        # determine number of attached and detached screens
        p_screens=$(screen -ls 2>/dev/null | grep "tached)" | wc -l);
        if [[ ${STY:-} ]]; then
            # don't count the current screen session
            (( p_screens-- ))
        fi
        case "$p_screens" in
            0) p_screens= ;;
            1) p_screens="| ${C_FG_LIGHT_YELLOW}1 screen${C_FG_BLACK} " ;;
            *) p_screens="| ${C_FG_LIGHT_YELLOW}$p_screens screens${C_FG_BLACK} " ;;
        esac
    fi


    local p_tty
    if [[ ! ${BASH_FUNK_PROMPT_NO_TTY:-} ]]; then
        if [[ ${STY:-} ]]; then
            p_tty="| tty #\l ${C_FG_LIGHT_YELLOW}(screen)${C_FG_BLACK} "
        else
            p_tty="| tty #\l "
        fi
    fi

    local p_prefix
    if [[ ${BASH_FUNK_PROMPT_PREFIX:-} ]]; then
        p_prefix="${C_RESET}${BASH_FUNK_PROMPT_PREFIX:-}${C_RESET}${p_bg} "
    else
        p_prefix="${C_RESET}${p_bg}"
    fi

    local LINE1="${p_prefix}${p_lastRC}${p_user}${p_host}${p_scm}${p_date}${p_jobs}${p_screens}${p_tty}${C_RESET}"
    local LINE2="[\033[${BASH_FUNK_DIRS_COLOR}m${pwd}${C_RESET}]"
    local LINE3="$ "
    PS1="\n$LINE1\n$LINE2\n$LINE3"
}
