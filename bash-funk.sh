#!/bin/bash
#
# Copyright (c) 2013-2017 Vegard IT GmbH, http://vegardit.com
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
    if ! [[ ${BASH_FUNK_PREFIX:-} =~ ^[0-9abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_]*$ ]]; then
        echo "The variable BASH_FUNK_PREFIX may only contain ASCII alphanumeric characters (a-z, A-Z, 0-9) and underscore (_)"
    else

        if [[ $TERM == "cygwin" ]]; then
            echo -en "\e[1;34m"
        else
            echo -en "\e[0;94m"
        fi
        echo " _               _            __             _"
        echo "| |__   __ _ ___| |__        / _|_   _ _ __ | | __"
        echo "| '_ \ / _\` / __| '_ \  ____| |_| | | | '_ \| |/ /"
        echo "| |_) | (_| \__ \ | | |/___/|  _| |_| | | | |   <"
        echo "|_.__/ \__,_|___/_| |_|     |_|  \__,_|_| |_|_|\_\\"
        if [[ $TERM == "cygwin" ]]; then
            echo -en "\e[0m"
            echo -en "\e[1;27m"
        else
            echo -en "\e[0;97m"
        fi
        echo "                  by Vegard IT GmbH (vegardit.com)"
        echo -e "\e[0m"

        export BASH_FUNK_PREFIX=${BASH_FUNK_PREFIX:-}

        script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

        # load all modules
        for module in $(command ls ${script_dir}/modules/*.sh | sort); do
            # don't load the test module automatically
            if [[ $(basename ${module}) == "test.sh" ]]; then
                continue;
            fi

            echo "Loading [modules/$(basename ${module})]..."
            # rename the functions based on the given BASH_FUNK_PREFIX
            if [[ $BASH_FUNK_PREFIX == "" ]]; then
                source "${module}"
            else
                eval "$(sed "s/function -/function ${BASH_FUNK_PREFIX}-/g; s/function _-/function _${BASH_FUNK_PREFIX}-/g" ${module})"
            fi
        done
        unset module

        # export all functions
        echo "Exporting functions..."
        for fname in $(compgen -A function ${BASH_FUNK_PREFIX}-); do
            export -f -- ${fname}
        done
        unset fname

        unset script_dir

        if [[ ${BASH_FUNK_PROMPT:-yes} == "yes" ]]; then
            PROMPT_COMMAND=${BASH_FUNK_PREFIX}-bash-prompt
        fi

        echo
        echo "You are ready to go. Enjoy"'!'

    fi
 fi
