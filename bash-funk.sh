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

# TODO provide way to control which modules are loaded

if [[ $_ == $0 ]]; then
    echo "The bash-funk script must be sourced"'!'" See the 'source' command."
    false
else
    # not using a-zA-Z in regex as this seems to match German umlaute too
    if ! [[ ${BASH_FUNK_PREFIX:-} =~ ^[0-9abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]*$ ]]; then
        echo "The variable BASH_FUNK_PREFIX may only contain ASCII alphanumeric characters (a-z, A-Z, 0-9), dash (-) and underscore (_)"
    else

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

        if ! declare -p BASH_FUNK_PREFIX &>/dev/null; then
            BASH_FUNK_PREFIX=-
        fi
        export BASH_FUNK_PREFIX

        __BASH_FUNK_FUNCS=()

        case "${BASH_SOURCE[0]}" in
            /*)
                __BASH_FUNK_ROOT="${BASH_SOURCE[0]%/*}" ;;
            */*)
                __BASH_FUNK_ROOT="$PWD/${BASH_SOURCE[0]%/*}" ;;
            *)
                __BASH_FUNK_ROOT="$PWD" ;;
        esac

        # load all modules
        for __module in "${__BASH_FUNK_ROOT}"/modules/*.sh; do
            # don't load the test module automatically
            if [[ $__module == *test.sh ]]; then
                continue;
            fi

            echo "* Loading [modules/${__module##*/}]..."
            # rename the functions based on the given BASH_FUNK_PREFIX
            if [[ $BASH_FUNK_PREFIX == "-" ]]; then
                source "${__module}"
            else
                eval "$(sed -r "s/function -/function ${BASH_FUNK_PREFIX}/g; s/function __([^-]*)-/function __\1${BASH_FUNK_PREFIX}/g" ${__module})"
            fi
        done
        unset __module

        # export all functions
        echo "* Exporting functions..."
        for __fname in ${__BASH_FUNK_FUNCS[@]}; do
            export -f -- ${BASH_FUNK_PREFIX}${__fname}
        done
        unset __fname __fnames

        if [[ ! ${BASH_FUNK_NO_TWEAK_BASH:-} ]] && declare -F -- ${BASH_FUNK_PREFIX}tweak-bash &>/dev/null; then
            echo "* Executing '${BASH_FUNK_PREFIX}tweak-bash'..."
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

        echo
        echo "You are ready to go. Enjoy"'!'

    fi
 fi
