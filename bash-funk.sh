#!/usr/bin/env bash
#
# Copyright (c) 2015-2017 Vegard IT GmbH, http://vegardit.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @author Patrick Spielmann, Vegard IT GmbH
# @author Sebastian Thomschke, Vegard IT GmbH
#

if [[ $_ == $0 ]]; then
    echo "The bash-funk script must be sourced"'!'" See the 'source' command."
    false
else
    if [[ -e ~/.bash_funk_rc ]]; then
        echo "Sourcing [~/.bash_funk_rc]..."
        source ~/.bash_funk_rc
    else
        cat >~/.bash_funk_rc <<EOL
# Uncomment the settings you want to change:
#BASH_FUNK_PREFIX=-            # if specified, the names of all bash-funk commands will be prefixed with this value. Must only contain alphanumeric characters a-z, A-Z, 0-9) and underscore _.
#BASH_FUNK_DIRS_COLOR=94       # ANSI color code to be used by the bash prompt to highlight directories, default is 94 which will be transformed to \e[94m
#BASH_FUNK_NO_TWEAK_BASH=1     # if set to any value bash-funk will not automatically invoke the -tweak-bash command when loading.

# Bash prompt customizations:
#BASH_FUNK_NO_PROMPT=1         # if set to any value bash-funk will not install it's Bash prompt function.
#BASH_FUNK_PROMPT_PREFIX=      # text that shall be shown at the beginning of the Bash prompt, e.g. a stage identifier (DEV/TEST/PROD)
#BASH_FUNK_PROMPT_NO_DATE=1    # if set to any value the Bash prompt will not display the current date and time.
#BASH_FUNK_PROMPT_NO_GIT=1     # if set to any value the Bash prompt will not display GIT branch and modification information.
#BASH_FUNK_PROMPT_NO_JOBS=1    # if set to any value the Bash prompt will not display the number of shell jobs.
#BASH_FUNK_PROMPT_NO_SCREENS=1 # if set to any value the Bash prompt will not display the number of detached screens
#BASH_FUNK_PROMPT_NO_SVN=1     # if set to any value the Bash prompt will not display SVN branch and modification information.- BASH_FUNK_NO_PROMPT_TTY - if set to any value the Bash prompt will not display the current tty.

# other user settings below here

EOL
    fi

    # not using a-zA-Z in regex as this seems to match German umlaute too
    if ! [[ ${BASH_FUNK_PREFIX:-} =~ ^[0-9abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]*$ ]]; then
        echo "The variable BASH_FUNK_PREFIX may only contain ASCII alphanumeric characters (a-z, A-Z, 0-9), dash (-) and underscore (_)"
    else

        case "${BASH_SOURCE[0]}" in
            /*)
                __BASH_FUNK_ROOT="${BASH_SOURCE[0]%/*}" ;;
            */*)
                __BASH_FUNK_ROOT="$PWD/${BASH_SOURCE[0]%/*}" ;;
            *)
                __BASH_FUNK_ROOT="$PWD" ;;
        esac

        if [[ -d ${__BASH_FUNK_ROOT}/.git ]]; then
            __BASH_FUNK_VERSION=$(git log -1 --format=%ci 2>/dev/null || true)
        elif [[ -d ${__BASH_FUNK_ROOT}/.svn ]]; then
            __BASH_FUNK_VERSION=$(svn info "${__BASH_FUNK_ROOT}" 2>/dev/null || true)
            if [[ $__BASH_FUNK_VERSION ]]; then
                __BASH_FUNK_VERSION="${__BASH_FUNK_VERSION#*$'\n'Last Changed Date: }" # substring after 'Last Changed Date: '
                __BASH_FUNK_VERSION="${__BASH_FUNK_VERSION%% (*}"                  # substring before ' ('
            fi
        else
            __BASH_FUNK_VERSION=
        fi

        # if no SCM was used, we assume installation via curl/wget, thus we take the last modification date of the oldest file
        if [[ ! $__BASH_FUNK_VERSION ]]; then
            __BASH_FUNK_VERSION=$(find ${__BASH_FUNK_ROOT} -not -path '*/\.*' -type f -printf "%TY.%Tm.%Td %TT %TZ\n" | sort | head -n 1)
            __BASH_FUNK_VERSION="${__BASH_FUNK_VERSION%.*} ${__BASH_FUNK_VERSION#${__BASH_FUNK_VERSION% *} }"
        fi

        if [[ $TERM == "cygwin" ]]; then
            echo -en "\033[1;34m"
        else
            echo -en "\033[0;94m"
        fi
        echo " _               _            __             _"
        echo "| |__   __ _ ___| |__        / _|_   _ _ __ | | __"
        echo "| '_ \ / _\` / __| '_ \  ____| |_| | | | '_ \| |/ /"
        echo "| |_) | (_| \__ \ | | |/___/|  _| |_| | | | |   <"
        echo "|_.__/ \__,_|___/_| |_|     |_|  \__,_|_| |_|_|\_\\"
        echo -en "\033[0m"
        echo "                  by Vegard IT GmbH (vegardit.com)"
        echo

        echo "Local Version: $__BASH_FUNK_VERSION"
        echo

        if ! declare -p BASH_FUNK_PREFIX &>/dev/null; then
            BASH_FUNK_PREFIX=-
        fi
        export BASH_FUNK_PREFIX

        __BASH_FUNK_FUNCS=()

        # load all modules
        for __module in "${__BASH_FUNK_ROOT}"/modules/*.sh; do
            # don't load the test module automatically
            if [[ $__module == *test.sh ]]; then
                continue;
            fi

            echo -n "* Loading [modules/${__module##*/}]... "
            # rename the functions based on the given BASH_FUNK_PREFIX
            if [[ $BASH_FUNK_PREFIX == "-" ]]; then
                source "${__module}"
            else
                eval "$(sed -E "s/function -/function ${BASH_FUNK_PREFIX}/g; s/function __([^-]*)-/function __\1${BASH_FUNK_PREFIX}/g" ${__module})"
            fi
            echo
        done
        unset __module

        # export all functions
        echo "* Exporting functions..."
        for __fname in ${__BASH_FUNK_FUNCS[@]}; do
            export -f -- ${BASH_FUNK_PREFIX}${__fname}
        done
        unset __fname __fnames

        if [[ ! ${BASH_FUNK_NO_TWEAK_BASH:-} ]] && declare -F -- ${BASH_FUNK_PREFIX}tweak-bash &>/dev/null; then
            echo "* Executing command '${BASH_FUNK_PREFIX}tweak-bash'..."
            ${BASH_FUNK_PREFIX}tweak-bash
        fi

        if [[ ! ${BASH_FUNK_NO_PROMPT:-} ]]; then
            echo "* Setting custom bash prompt..."
            PROMPT_COMMAND=__${BASH_FUNK_PREFIX}bash-prompt

            # load directory history from ~/.bash_funk_dirs
            if [[ -s ~/.bash_funk_dirs ]]; then

                # the awk command corresponds to '-tail-reverse -u -n 100 ~/.bash_funk_dirs'
                IFS=$'\n' read -rd '' -a __dirs <<<"$(awk "{lines[len++]=\$0} END {for(i=len-1;i>=0;i--) if(occurrences[lines[i]]++ == 0) {print lines[i]; count++; if (count>=100) break}}" ~/.bash_funk_dirs)"
                # $_dirs now contains the latest used directory first
                if [[ $__dirs ]]; then
                    echo "* Loading directory history..."
                    dirs -c
                    {
                        for (( __i=${#__dirs[@]}-1 ; __i>=0 ; __i-- )) ; do
                            pushd -n "${__dirs[__i]}" >/dev/null
                            echo "${__dirs[__i]}"
                        done
                    } >~/.bash_funk_dirs
                    unset __i
                fi
                unset __dirs
            fi

            # installing a prompt that prints line numbers in debug mode
            __BASH_FUNK_OLD_PS4="$PS4"
            PS4='\033[0;35m+ ($0:${LINENO}) \033[0m'
        fi

    fi

    echo
    echo "You are ready to go. Enjoy"'!'

    # show information about detached screens
    if hash screen &>/dev/null; then
        __screens="$(screen -list | grep "etached)" | sort | sed -En "s/\s+(.*)\s+.*/  screen -r \1/p")"
        if [[ $__screens ]]; then
            echo
            echo "The following detached screens have been detected:"

            if [[ $TERM == "cygwin" ]]; then
                echo -e "\033[1m\033[30m${__screens}\033[0m"
            else
                echo -e "\033[93m${__screens}\033[0m"
            fi
        fi
        unset __screens
    fi
 fi
