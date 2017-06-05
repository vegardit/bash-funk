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

#
# THIS FILE IS GENERATED BY BASH-FUNK GENERATOR
#
function -get-child-pids() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a e u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -e
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... [PARENT_PID]"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-get-child-pids() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _printPPID _help _selftest _PARENT_PID
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]... [PARENT_PID]"
                echo
                echo "Recursively prints all child PIDs of the process with the given PID."
                echo
                echo "Parameters:"
                echo -e "  \033[1mPARENT_PID\033[22m (default: '$$', integer: 0-?)"
                echo "      The process ID of the parent process. If not specified the PID of the current Bash process is used."
                echo
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --printPPID\033[22m "
                echo "        Specifies to also print the PID of the parent process."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo
                return 0
              ;;

            --selftest)
                echo "Testing function [$__fn]..."
                echo -e "$ \033[1m$__fn --help\033[22m"
                local __stdout __rc
                __stdout="$($__fn --help)"; __rc=$?
                if [[ $__rc != 0 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [0]."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo "Testing function [$__fn]...DONE"
                return 0
              ;;

            --printPPID)
                _printPPID=1
            ;;

            -*)
                echo "$__fn: invalid option: '$__arg'"
                return 64
              ;;

            *)
                case $__optionWithValue in
                    *)
                        __params+=("$__arg")
                esac
              ;;
        esac
    done

    for __param in "${__params[@]}"; do
        if [[ ! $_PARENT_PID && ${#__params[@]} > 0 ]]; then
            _PARENT_PID=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ ! $_PARENT_PID ]]; then _PARENT_PID="$$"; fi

    if [[ $_PARENT_PID ]]; then
        if [[ ! "$_PARENT_PID" =~ ^-?[0-9]*$ ]]; then echo "$__fn: Error: Value '$_PARENT_PID' for parameter PARENT_PID is not a numeric value."; return 64; fi
        if [[ $_PARENT_PID -lt 0 ]]; then echo "$__fn: Error: Value '$_PARENT_PID' for parameter PARENT_PID is too low. Must be >= 0."; return 64; fi
    fi

    ######### get-child-pids ######### START

local CHILD_PIDS # intentional declaration in a separate line, see http://stackoverflow.com/a/42854176
childPids=$(command ps -o pid --no-headers --ppid $_PARENT_PID 2>/dev/null | sed -e 's!\s!!g'; exit ${PIPESTATUS[0]})
if [[ $? != 0 ]]; then
    echo "No process with PID ${1} found"'!'
    return 1
fi
for childPid in $childPids; do
    $__fn --printPPID $childPid
done
if [[ $_printPPID ]]; then
    echo $_PARENT_PID
fi

    ######### get-child-pids ######### END
}
function __complete-get-child-pids() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --printPPID --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}get-child-pids -- ${BASH_FUNK_PREFIX:--}get-child-pids

function -get-parent-pid() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a e u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -e
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... [CHILD_PID]"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-get-parent-pid() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest _CHILD_PID
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]... [CHILD_PID]"
                echo
                echo "Prints the PID of the parent process of the child process with the given PID."
                echo
                echo "Parameters:"
                echo -e "  \033[1mCHILD_PID\033[22m (default: '$$', integer: 0-?)"
                echo "      The process ID of the child process. If not specified the PID of the current Bash process is used."
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
                echo "Testing function [$__fn]..."
                echo -e "$ \033[1m$__fn --help\033[22m"
                local __stdout __rc
                __stdout="$($__fn --help)"; __rc=$?
                if [[ $__rc != 0 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [0]."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo "Testing function [$__fn]...DONE"
                return 0
              ;;

            -*)
                echo "$__fn: invalid option: '$__arg'"
                return 64
              ;;

            *)
                case $__optionWithValue in
                    *)
                        __params+=("$__arg")
                esac
              ;;
        esac
    done

    for __param in "${__params[@]}"; do
        if [[ ! $_CHILD_PID && ${#__params[@]} > 0 ]]; then
            _CHILD_PID=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ ! $_CHILD_PID ]]; then _CHILD_PID="$$"; fi

    if [[ $_CHILD_PID ]]; then
        if [[ ! "$_CHILD_PID" =~ ^-?[0-9]*$ ]]; then echo "$__fn: Error: Value '$_CHILD_PID' for parameter CHILD_PID is not a numeric value."; return 64; fi
        if [[ $_CHILD_PID -lt 0 ]]; then echo "$__fn: Error: Value '$_CHILD_PID' for parameter CHILD_PID is too low. Must be >= 0."; return 64; fi
    fi

    ######### get-parent-pid ######### START

local parentPid # intentional declaration in a separate line, see http://stackoverflow.com/a/42854176
parentPid=$(cat /proc/${_CHILD_PID}/stat 2>/dev/null | awk '{print $4}'; exit ${PIPESTATUS[0]})
if [[ $? != 0 ]]; then
    echo "No process with PID ${_CHILD_PID} found"'!'
    return 1
fi
echo $parentPid

    ######### get-parent-pid ######### END
}
function __complete-get-parent-pid() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}get-parent-pid -- ${BASH_FUNK_PREFIX:--}get-parent-pid

function -get-toplevel-parent-pid() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a e u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -e
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... [CHILD_PID]"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-get-toplevel-parent-pid() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest _CHILD_PID
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]... [CHILD_PID]"
                echo
                echo "Prints the PID of the top-level parent process of the child process with the given PID."
                echo
                echo "Parameters:"
                echo -e "  \033[1mCHILD_PID\033[22m (default: '$$', integer: 0-?)"
                echo "      The process ID of the child process. If not specified the PID of the current Bash process is used."
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
                echo "Testing function [$__fn]..."
                echo -e "$ \033[1m$__fn --help\033[22m"
                local __stdout __rc
                __stdout="$($__fn --help)"; __rc=$?
                if [[ $__rc != 0 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [0]."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo "Testing function [$__fn]...DONE"
                return 0
              ;;

            -*)
                echo "$__fn: invalid option: '$__arg'"
                return 64
              ;;

            *)
                case $__optionWithValue in
                    *)
                        __params+=("$__arg")
                esac
              ;;
        esac
    done

    for __param in "${__params[@]}"; do
        if [[ ! $_CHILD_PID && ${#__params[@]} > 0 ]]; then
            _CHILD_PID=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ ! $_CHILD_PID ]]; then _CHILD_PID="$$"; fi

    if [[ $_CHILD_PID ]]; then
        if [[ ! "$_CHILD_PID" =~ ^-?[0-9]*$ ]]; then echo "$__fn: Error: Value '$_CHILD_PID' for parameter CHILD_PID is not a numeric value."; return 64; fi
        if [[ $_CHILD_PID -lt 0 ]]; then echo "$__fn: Error: Value '$_CHILD_PID' for parameter CHILD_PID is too low. Must be >= 0."; return 64; fi
    fi

    ######### get-toplevel-parent-pid ######### START

local pid=$_CHILD_PID
while [[ $pid != 0 ]]; do
    pid=$(${BASH_FUNK_PREFIX:--}get-parent-pid ${pid})
    if [[ $? != 0 ]]; then
        echo $pid
        return 1
    fi
done
echo ${pid}

    ######### get-toplevel-parent-pid ######### END
}
function __complete-get-toplevel-parent-pid() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}get-toplevel-parent-pid -- ${BASH_FUNK_PREFIX:--}get-toplevel-parent-pid

function -kill-childs() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a e u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -e
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... SIGNAL [PARENT_PID]"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-kill-childs() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest _SIGNAL _PARENT_PID
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]... SIGNAL [PARENT_PID]"
                echo
                echo "Sends the given kill signal to all child processes of the process with the given PID."
                echo
                echo "Parameters:"
                echo -e "  \033[1mSIGNAL\033[22m (required, integer: 1-64)"
                echo "      The kill signal to be send, eg. 9=KILL or 15=TERM."
                echo -e "  \033[1mPARENT_PID\033[22m (default: '$$', integer: 0-?)"
                echo "      The process ID of the parent process. If not specified the PID of the current bash process is used."
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
                echo "Testing function [$__fn]..."
                echo -e "$ \033[1m$__fn --help\033[22m"
                local __stdout __rc
                __stdout="$($__fn --help)"; __rc=$?
                if [[ $__rc != 0 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [0]."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo "Testing function [$__fn]...DONE"
                return 0
              ;;

            -*)
                echo "$__fn: invalid option: '$__arg'"
                return 64
              ;;

            *)
                case $__optionWithValue in
                    *)
                        __params+=("$__arg")
                esac
              ;;
        esac
    done

    for __param in "${__params[@]}"; do
        if [[ ! $_SIGNAL ]]; then
            _SIGNAL=$__param
            continue
        fi
        if [[ ! $_PARENT_PID ]]; then
            _PARENT_PID=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ ! $_PARENT_PID ]]; then _PARENT_PID="$$"; fi

    if [[ $_SIGNAL ]]; then
        if [[ ! "$_SIGNAL" =~ ^-?[0-9]*$ ]]; then echo "$__fn: Error: Value '$_SIGNAL' for parameter SIGNAL is not a numeric value."; return 64; fi
        if [[ $_SIGNAL -lt 1 ]]; then echo "$__fn: Error: Value '$_SIGNAL' for parameter SIGNAL is too low. Must be >= 1."; return 64; fi
        if [[ $_SIGNAL -gt 64 ]]; then echo "$__fn: Error: Value '$_SIGNAL' for parameter SIGNAL is too high. Must be <= 64."; return 64; fi
    else
        echo "$__fn: Error: Parameter SIGNAL must be specified."; return 64
    fi
    if [[ $_PARENT_PID ]]; then
        if [[ ! "$_PARENT_PID" =~ ^-?[0-9]*$ ]]; then echo "$__fn: Error: Value '$_PARENT_PID' for parameter PARENT_PID is not a numeric value."; return 64; fi
        if [[ $_PARENT_PID -lt 0 ]]; then echo "$__fn: Error: Value '$_PARENT_PID' for parameter PARENT_PID is too low. Must be >= 0."; return 64; fi
    fi

    ######### kill-childs ######### START

local childPids=$(${BASH_FUNK_PREFIX:--}get-child-pids $_PARENT_PID)
if [[ $? != 0 ]]; then
    echo $childPids
    return 1
fi
for childPid in $childPids; do
    echo "Killing process with PID $childPid..."
    kill -s $_SIGNAL $childPid 2> /dev/null || :
done

    ######### kill-childs ######### END
}
function __complete-kill-childs() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}kill-childs -- ${BASH_FUNK_PREFIX:--}kill-childs

function -test-processes() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a e u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -e
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]..."
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-test-processes() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]..."
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
                echo "Testing function [$__fn]..."
                echo -e "$ \033[1m$__fn --help\033[22m"
                local __stdout __rc
                __stdout="$($__fn --help)"; __rc=$?
                if [[ $__rc != 0 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [0]."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo "Testing function [$__fn]...DONE"
                return 0
              ;;

            -*)
                echo "$__fn: invalid option: '$__arg'"
                return 64
              ;;

            *)
                case $__optionWithValue in
                    *)
                        __params+=("$__arg")
                esac
              ;;
        esac
    done

    for __param in "${__params[@]}"; do
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    ######### test-processes ######### START

${BASH_FUNK_PREFIX:--}get-child-pids --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}get-parent-pid --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}get-toplevel-parent-pid --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}kill-childs --selftest && echo || return 1

    ######### test-processes ######### END
}
function __complete-test-processes() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}test-processes -- ${BASH_FUNK_PREFIX:--}test-processes


function -help-processes() {
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}get-child-pids [PARENT_PID]\033[0m  -  Recursively prints all child PIDs of the process with the given PID."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}get-parent-pid [CHILD_PID]\033[0m  -  Prints the PID of the parent process of the child process with the given PID."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}get-toplevel-parent-pid [CHILD_PID]\033[0m  -  Prints the PID of the top-level parent process of the child process with the given PID."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}kill-childs SIGNAL [PARENT_PID]\033[0m  -  Sends the given kill signal to all child processes of the process with the given PID."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}test-processes\033[0m  -  Performs a selftest of all functions of this module by executing each function with option '--selftest'."

}
__BASH_FUNK_FUNCS+=( get-child-pids get-parent-pid get-toplevel-parent-pid kill-childs test-processes )
