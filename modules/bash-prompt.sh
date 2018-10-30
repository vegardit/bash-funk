#!/usr/bin/env bash
#
# Copyright (c) 2015-2018 Vegard IT GmbH, http://vegardit.com
# SPDX-License-Identifier: Apache-2.0
#
# @author Sebastian Thomschke, Vegard IT GmbH
# @author Patrick Spielmann, Vegard IT GmbH

if [[ $TERM == "cygwin" ]]; then
    BASH_FUNK_DIRS_COLOR="${BASH_FUNK_DIRS_COLOR:-1;34}"
else
    BASH_FUNK_DIRS_COLOR="${BASH_FUNK_DIRS_COLOR:-0;94}"
fi

if ! hash svn &>/dev/null; then
    BASH_FUNK_PROMPT_NO_SVN=1
fi
if ! hash git &>/dev/null; then
    BASH_FUNK_PROMPT_NO_GIT=1
fi
if ! hash screen &>/dev/null; then
    BASH_FUNK_PROMPT_NO_SCREENS=1
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
        # shopt -s checkwinsize under Cygwin with cmd.exe does not work reliable
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
        p_user="${C_FG_BLACK}${C_BG_YELLOW}*\u*${p_bg}"
    else
        p_user="${C_FG_WHITE}\u${C_FG_BLACK}"
    fi


    local p_host
    p_host="@${C_FG_WHITE}\h${C_FG_BLACK} "


    local p_scm scm_info
    if [[ ! ${BASH_FUNK_PROMPT_NO_GIT:-} ]] && ${BASH_FUNK_PREFIX:--}find-up --type d .git &>/dev/null; then
        # sub-shells, pipes and external programs are avoided as much as possible to significantly improve performance under Cygwin
        if scm_info=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null && echo "-----" && git ls-files -o -m -d --exclude-standard); then
            p_scm="${scm_info%%$'\n'-----*}"     # substring before '\n-----'

            local modifications="${scm_info#*$'\n'-----}" # substring after '-----'
            modifications=( ${modifications// /} )
            if [[ ${#modifications[@]} != "0" ]]; then
                p_scm="git:$p_scm${C_FG_WHITE}(${#modifications[@]})"
            else
                p_scm="git:$p_scm"
            fi
        fi
    fi
    if [[ ! $p_scm && ! ${BASH_FUNK_PROMPT_NO_SVN:-} ]] && ${BASH_FUNK_PREFIX:--}find-up --type d .svn &>/dev/null; then
        # sub-shells, pipes and external programs are avoided as much as possible to significantly improve performance under Cygwin
        if scm_info=$(svn info 2>/dev/null && echo "-----" && svn status); then
            if [[ "$scm_info" == *URL:* ]]; then
                p_scm="${scm_info#*$'\n'URL: }"  # substring after 'URL: '
                p_scm="${p_scm%%$'\n'*}"         # substring before \n

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

                    *)
                        local svn_repo_root="${scm_info#*$'\n'Repository Root: }" # substring after 'Repository Root: '
                        svn_repo_root="${svn_repo_root%%$'\n'*}"  # substring before \n
                        p_scm="${p_scm#$svn_repo_root/}"          # substring after repo root
                        p_scm="${p_scm%%/*}"                      # substring before first /
                      ;;

                esac

                if [[ $p_scm ]]; then
                    local modifications="${scm_info#*$'\n'-----$'\n'}" # substring after '-----'
                    modifications=( ${modifications// /} )
                    if [[ ${#modifications[@]} != "0" ]]; then
                        p_scm="svn:$p_scm${C_FG_WHITE}(${#modifications[@]})"
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
    if [[ ${BASH_FUNK_PROMPT_DATE:-} ]]; then
        p_date="| ${BASH_FUNK_PROMPT_DATE:-} "
    else
        p_date="| \t "
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

    if [[ ${#BASH_FUNK_PROMPT_DIRENV_TRUSTED_DIRS[@]:-} -gt 0 ]]; then
        if [[ ${__resetDirRC:-} != "" ]]; then
            # unset previously set directory-scoped environment variables
            eval "$__resetDirRC"
            unset __resetDirRC
        fi
        # search for trusted .bash_funk_direnv.sh files upwards recursively
        local dirEnvFile trustedDirPattern trustedDirEnvFiles=( ) currDir=$PWD
        local unset_extglob=true
        if ! shopt -q extglob; then
            shopt -s extglob
            unset_extglob="shopt -u extglob"
        fi
        while [[ $currDir ]]; do
            dirEnvFile=$currDir/.bash_funk_dir_rc
            if [[ -f "$dirEnvFile" ]]; then
                for trustedDirPattern in "${BASH_FUNK_PROMPT_DIRENV_TRUSTED_DIRS[@]:-}"; do
                    # convert "**" to "*" and "*" to "+([!/])", see http://wiki.bash-hackers.org/syntax/pattern
                    trustedDirPattern="${trustedDirPattern//\*\*/ANY_SUB_DIRECTORY}"
                    trustedDirPattern="${trustedDirPattern//\*/+([!/])}"
                    trustedDirPattern="${trustedDirPattern//ANY_SUB_DIRECTORY/*}"
                    if [[ "$currDir" == $trustedDirPattern ]]; then
                        trustedDirEnvFiles=("$dirEnvFile" "${trustedDirEnvFiles[@]}")
                        export __resetDirEnv="true"
                    fi
                done
            fi
            currDir=${currDir%/*}
        done
        eval ${unset_extglob}

        # evaluate each .bash_funk_direnv.sh starting with the one from the most top-level directory
        for dirEnvFile in "${trustedDirEnvFiles[@]}"; do
            local ORIG_IFS=$IFS IFS=$'\n' line
            for line in $(sh "$dirEnvFile"); do
               case $line in
                  export\ ?*=*)
                     local varAssignment=${line:7}
                     local varName=${varAssignment%%=*}
                     local varValue=${varAssignment#*=}
                     if eval ${!varName+false}; then
                        # var does not yet exist
                        __resetDirRC="$__resetDirEnv; unset $varName"
                     else
                        # var already exists
                        __resetDirRC="$__resetDirEnv; $varName='${!varName}'"
                     fi
                     eval $line
                   ;;
               esac
            done
            IFS=$ORIG_IFS
        done
    fi

    local p_prefix
    if [[ ${BASH_FUNK_PROMPT_PREFIX:-} ]]; then
        p_prefix="${C_RESET}${BASH_FUNK_PROMPT_PREFIX:-}${C_RESET}${p_bg} "
    else
        p_prefix="${C_RESET}${p_bg}"
    fi

    local LINE1="${p_prefix}${p_lastRC}${p_user}${p_host}${p_date}${p_scm}${p_jobs}${p_screens}${p_tty}${C_RESET}"
    local LINE2="[\033[${BASH_FUNK_DIRS_COLOR}m${pwd}${C_RESET}]"
    local LINE3="$ "
    PS1="\n$LINE1\n$LINE2\n$LINE3"
}
