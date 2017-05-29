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

#
# THIS FILE IS GENERATED BY BASH-FUNK GENERATOR
#

function -help() {

    [[ -p /dev/stdout ]] && local _in_pipe=1 || local _in_pipe=
    [ -t 1 ] && local _in_subshell= || local _in_subshell=1
    local fn=${FUNCNAME[0]}
    [[ $_in_pipe || $_in_subshell ]] && local hint= || local hint="

Usage: $fn [OPTION]...

Type '$fn --help' for more details."
    local arg optionWithValue params=() _help _selftest
    for arg in "$@"; do
        case $arg in
    
            --help)
                echo "Usage: $fn [OPTION]..."
                echo 
                echo "Prints the online help of all bash-funk commands."
                echo 
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo 
                return 0
              ;;
    
            --selftest)
                echo "Testing function [$fn]..."
                echo -e "$ \033[1m$fn --help\033[22m"
                local regex stdout rc
                stdout=$($fn --help); rc=$?
                if [[ $rc != 0 ]]; then echo "--> FAILED - exit code [$rc] instead of expected [0].$hint"; return 1; fi
                echo "--> OK"
                echo "Testing function [$fn]...DONE"
                return 0
              ;;
    
    
    
            -*)
                echo "$fn: invalid option: '$arg'"
                echo Type \'$fn --help\' for usage.
                return 1
              ;;
    
            *)
                case $optionWithValue in
                    *)
                        params+=("$arg")
                esac
              ;;
        esac
    done
    unset arg optionWithValue
    
    for param in "${params[@]}"; do
        echo "$fn: Error: too many parameters: '$param'$hint"
        return 1
    done
    unset param params leftoverParams
    
    
    
    
    ######################################################

for helpfunc in $(compgen -A function -- ${BASH_FUNK_PREFIX}-help-); do
    $helpfunc
done | sort

}
function _-help() {
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    if [[ ${currentWord} == -* ]]; then
        local options=" --help --selftest "
        for o in ${COMP_WORDS[@]}; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $currentWord))
    else
        COMPREPLY=($(compgen -o default -- $currentWord))
    fi
}
complete -F _${BASH_FUNK_PREFIX:-}-help -- ${BASH_FUNK_PREFIX:-}-help

function -test-misc() {

    [[ -p /dev/stdout ]] && local _in_pipe=1 || local _in_pipe=
    [ -t 1 ] && local _in_subshell= || local _in_subshell=1
    local fn=${FUNCNAME[0]}
    [[ $_in_pipe || $_in_subshell ]] && local hint= || local hint="

Usage: $fn [OPTION]...

Type '$fn --help' for more details."
    local arg optionWithValue params=() _help _selftest
    for arg in "$@"; do
        case $arg in
    
            --help)
                echo "Usage: $fn [OPTION]..."
                echo 
                echo "Performs a selftest of all functions of this module by executing each function with option '--selftest'."
                echo 
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo 
                return 0
              ;;
    
            --selftest)
                echo "Testing function [$fn]..."
                echo -e "$ \033[1m$fn --help\033[22m"
                local regex stdout rc
                stdout=$($fn --help); rc=$?
                if [[ $rc != 0 ]]; then echo "--> FAILED - exit code [$rc] instead of expected [0].$hint"; return 1; fi
                echo "--> OK"
                echo "Testing function [$fn]...DONE"
                return 0
              ;;
    
    
    
            -*)
                echo "$fn: invalid option: '$arg'"
                echo Type \'$fn --help\' for usage.
                return 1
              ;;
    
            *)
                case $optionWithValue in
                    *)
                        params+=("$arg")
                esac
              ;;
        esac
    done
    unset arg optionWithValue
    
    for param in "${params[@]}"; do
        echo "$fn: Error: too many parameters: '$param'$hint"
        return 1
    done
    unset param params leftoverParams
    
    
    
    
    ######################################################

${BASH_FUNK_PREFIX:-}-help --selftest && echo || return 1
${BASH_FUNK_PREFIX:-}-var-exists --selftest && echo || return 1
${BASH_FUNK_PREFIX:-}-wait --selftest && echo || return 1
}
function _-test-misc() {
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    if [[ ${currentWord} == -* ]]; then
        local options=" --help --selftest "
        for o in ${COMP_WORDS[@]}; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $currentWord))
    else
        COMPREPLY=($(compgen -o default -- $currentWord))
    fi
}
complete -F _${BASH_FUNK_PREFIX:-}-test-misc -- ${BASH_FUNK_PREFIX:-}-test-misc

function -var-exists() {

    [[ -p /dev/stdout ]] && local _in_pipe=1 || local _in_pipe=
    [ -t 1 ] && local _in_subshell= || local _in_subshell=1
    local fn=${FUNCNAME[0]}
    [[ $_in_pipe || $_in_subshell ]] && local hint= || local hint="

Usage: $fn [OPTION]... VARIABLE_NAME

Type '$fn --help' for more details."
    local arg optionWithValue params=() _help _selftest _verbose _VARIABLE_NAME
    for arg in "$@"; do
        case $arg in
    
            --help)
                echo "Usage: $fn [OPTION]... VARIABLE_NAME"
                echo 
                echo "Determines if the given variable is declared."
                echo 
                echo "Parameters:"
                echo -e "  \033[1mVARIABLE_NAME\033[22m (required)"
                echo "      Name of the Bash variable to check."
                echo 
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "\033[1m-v, --verbose\033[22m "
                echo "        Prints additional information during command execution."
                echo 
                echo "Examples:"
                echo -e "$ \033[1m$fn USER\033[22m"
                echo 
                echo -e "$ \033[1m$fn -v USER\033[22m"
                echo "Bash variable 'USER' is exists."
                echo -e "$ \033[1m$fn -v NON_EXISTANT_VARIABLE\033[22m"
                echo "Bash variable 'NON_EXISTANT_VARIABLE' does not exist."
                echo 
                return 0
              ;;
    
            --selftest)
                echo "Testing function [$fn]..."
                echo -e "$ \033[1m$fn --help\033[22m"
                local regex stdout rc
                stdout=$($fn --help); rc=$?
                if [[ $rc != 0 ]]; then echo "--> FAILED - exit code [$rc] instead of expected [0].$hint"; return 1; fi
                echo "--> OK"
                echo -e "$ \033[1m$fn USER\033[22m"
                stdout=$($fn USER); rc=$?
                echo $stdout
                if [[ $rc != 0 ]]; then echo "--> FAILED - exit code [$rc] instead of expected [0].$hint"; return 1; fi
                regex="^$"
                if [[ ! "$stdout" =~ $regex ]]; then echo "--> FAILED - stdout [$stdout] does not match required pattern [].$hint"; return 1; fi
                echo "--> OK"
                echo -e "$ \033[1m$fn -v USER\033[22m"
                stdout=$($fn -v USER); rc=$?
                echo $stdout
                if [[ $rc != 0 ]]; then echo "--> FAILED - exit code [$rc] instead of expected [0].$hint"; return 1; fi
                regex="^Bash variable 'USER' is exists.$"
                if [[ ! "$stdout" =~ $regex ]]; then echo "--> FAILED - stdout [$stdout] does not match required pattern [Bash variable 'USER' is exists.].$hint"; return 1; fi
                echo "--> OK"
                echo -e "$ \033[1m$fn -v NON_EXISTANT_VARIABLE\033[22m"
                stdout=$($fn -v NON_EXISTANT_VARIABLE); rc=$?
                echo $stdout
                if [[ $rc != 1 ]]; then echo "--> FAILED - exit code [$rc] instead of expected [1].$hint"; return 1; fi
                regex="^Bash variable 'NON_EXISTANT_VARIABLE' does not exist.$"
                if [[ ! "$stdout" =~ $regex ]]; then echo "--> FAILED - stdout [$stdout] does not match required pattern [Bash variable 'NON_EXISTANT_VARIABLE' does not exist.].$hint"; return 1; fi
                echo "--> OK"
                echo "Testing function [$fn]...DONE"
                return 0
              ;;
    
    
    
            --verbose|-v)
                _verbose=true
            ;;
    
            -*)
                echo "$fn: invalid option: '$arg'"
                echo Type \'$fn --help\' for usage.
                return 1
              ;;
    
            *)
                case $optionWithValue in
                    *)
                        params+=("$arg")
                esac
              ;;
        esac
    done
    unset arg optionWithValue
    
    for param in "${params[@]}"; do
        if [[ ! $_VARIABLE_NAME ]]; then
            _VARIABLE_NAME=$param
            continue
        fi
        echo "$fn: Error: too many parameters: '$param'$hint"
        return 1
    done
    unset param params leftoverParams
    
    
    if [[ $_VARIABLE_NAME ]]; then
        true
    else
        echo "$fn: Error: Parameter VARIABLE_NAME must be specified.$hint"; return 1
    fi
    
    
    ######################################################

if declare -p ${_VARIABLE_NAME} &>/dev/null; then
    [[ $_verbose ]] && echo "Bash variable '${_VARIABLE_NAME}' is exists." || true
    return 0
else
    [[ $_verbose ]] && echo "Bash variable '${_VARIABLE_NAME}' does not exists." || true
    return 1
fi

}
function _-var-exists() {
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    if [[ ${currentWord} == -* ]]; then
        local options=" --help --selftest --verbose -v "
        for o in ${COMP_WORDS[@]}; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $currentWord))
    else
        COMPREPLY=($(compgen -o default -- $currentWord))
    fi
}
complete -F _${BASH_FUNK_PREFIX:-}-var-exists -- ${BASH_FUNK_PREFIX:-}-var-exists

function -wait() {

    [[ -p /dev/stdout ]] && local _in_pipe=1 || local _in_pipe=
    [ -t 1 ] && local _in_subshell= || local _in_subshell=1
    local fn=${FUNCNAME[0]}
    [[ $_in_pipe || $_in_subshell ]] && local hint= || local hint="

Usage: $fn [OPTION]... SECONDS

Type '$fn --help' for more details."
    local arg optionWithValue params=() _help _selftest _SECONDS
    for arg in "$@"; do
        case $arg in
    
            --help)
                echo "Usage: $fn [OPTION]... SECONDS"
                echo 
                echo "Waits for the given number of seconds or until the key 's' pressed."
                echo 
                echo "Parameters:"
                echo -e "  \033[1mSECONDS\033[22m (required)"
                echo "      Number of seconds to wait."
                echo 
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo 
                return 0
              ;;
    
            --selftest)
                echo "Testing function [$fn]..."
                echo -e "$ \033[1m$fn --help\033[22m"
                local regex stdout rc
                stdout=$($fn --help); rc=$?
                if [[ $rc != 0 ]]; then echo "--> FAILED - exit code [$rc] instead of expected [0].$hint"; return 1; fi
                echo "--> OK"
                echo "Testing function [$fn]...DONE"
                return 0
              ;;
    
    
    
            -*)
                echo "$fn: invalid option: '$arg'"
                echo Type \'$fn --help\' for usage.
                return 1
              ;;
    
            *)
                case $optionWithValue in
                    *)
                        params+=("$arg")
                esac
              ;;
        esac
    done
    unset arg optionWithValue
    
    for param in "${params[@]}"; do
        if [[ ! $_SECONDS ]]; then
            _SECONDS=$param
            continue
        fi
        echo "$fn: Error: too many parameters: '$param'$hint"
        return 1
    done
    unset param params leftoverParams
    
    
    if [[ $_SECONDS ]]; then
        true
    else
        echo "$fn: Error: Parameter SECONDS must be specified.$hint"; return 1
    fi
    
    
    ######################################################

echo -ne "Waiting for [$(date +%T --date=@$(($_SECONDS - 3600)))] until $(date +%T --date=@$(($(date +%s) + $_SECONDS))). Press [s] to skip: \033[9C"
for i in $(seq 0 $_SECONDS); do
    # adding a \n new line character to the end of the line to make the output parseable by sed which is line oriented
    echo -ne "\033[9D\033[1;32m$(date +%T --date=@$(($_SECONDS - ${i} - 3600))) \033[0m\033[s\n\033[u"
    local char=
    read -s -n1 -t1 char || :
    [[ $char == "s" ]] && break
done
echo

}
function _-wait() {
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    if [[ ${currentWord} == -* ]]; then
        local options=" --help --selftest "
        for o in ${COMP_WORDS[@]}; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $currentWord))
    else
        COMPREPLY=($(compgen -o default -- $currentWord))
    fi
}
complete -F _${BASH_FUNK_PREFIX:-}-wait -- ${BASH_FUNK_PREFIX:-}-wait

function -help-misc() {

    echo -e "\033[1m${BASH_FUNK_PREFIX:-}-help\033[0m  -  Prints the online help of all bash-funk commands."
    echo -e "\033[1m${BASH_FUNK_PREFIX:-}-test-misc\033[0m  -  Performs a selftest of all functions of this module by executing each function with option '--selftest'."
    echo -e "\033[1m${BASH_FUNK_PREFIX:-}-var-exists VARIABLE_NAME\033[0m  -  Determines if the given variable is declared."
    echo -e "\033[1m${BASH_FUNK_PREFIX:-}-wait SECONDS\033[0m  -  Waits for the given number of seconds or until the key 's' pressed."

}


function -timeout() {
    if [[ $# < 2 || ${1:-} == "--help" ]]; then
        echo "Usage: ${FUNCNAME[0]} TIMEOUT COMMAND [ARG]..."
        echo "Executes the COMMAND and aborts if it does not finish within the given TIMEOUT in seconds."
        [[ ${1:-} == "--help" ]] && return 0 || return 1
    fi
    # see: http://mywiki.wooledge.org/BashFAQ/068
    perl -e 'alarm shift; exec @ARGV' "$@";
}

