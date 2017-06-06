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

        __script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

        # load all modules
        for __module in $(command ls ${__script_dir}/modules/*.sh | sort); do
            # don't load the test module automatically
            if [[ $(basename ${__module}) == "test.sh" ]]; then
                continue;
            fi

            echo "Loading [modules/$(basename ${__module})]..."
            # rename the functions based on the given BASH_FUNK_PREFIX
            if [[ $BASH_FUNK_PREFIX == "-" ]]; then
                source "${__module}"
            else
                eval "$(sed -r "s/function -/function ${BASH_FUNK_PREFIX}/g; s/function __([^-]*)-/function __\1${BASH_FUNK_PREFIX}/g" ${__module})"
            fi
        done
        unset __module

        # export all functions
        echo "Exporting functions..."
        for __fname in ${__BASH_FUNK_FUNCS[@]}; do
            export -f -- ${BASH_FUNK_PREFIX}${__fname}
        done
        unset __fname __fnames

        unset __script_dir

        if [[ ! ${BASH_FUNK_NO_PROMPT:-} ]]; then
            PROMPT_COMMAND=__${BASH_FUNK_PREFIX}bash-prompt

            # installing a prompt that prints line numbers in debug mode
            __BASH_FUNK_OLD_PS4="$PS4"
            PS4='\033[0;35m+ ($0:${LINENO}) \033[0m'
        fi

        echo
        echo "You are ready to go. Enjoy"'!'

    fi
 fi
