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
function -help() {
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
function __impl-help() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]..."
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

    ######### help ######### START

for helpfunc in $(compgen -A function -- ${BASH_FUNK_PREFIX:--}help-); do
    $helpfunc
done | sort

    ######### help ######### END
}
function __complete-help() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}help -- ${BASH_FUNK_PREFIX:--}help

function -please() {
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
function __impl-please() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest _verbose
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]..."
                echo
                echo "Re-runs the previously entered command with sudo."
                echo
                echo "Requirements:"
                echo "  + Command 'sudo' must be available."
                echo
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "\033[1m-v, --verbose\033[22m "
                echo "        Prints additional information during command execution."
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

            --verbose|-v)
                _verbose=1
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

    if ! hash "sudo" &>/dev/null; then echo "$__fn: Error: Required command 'sudo' not found on this system."; return 64; fi

    ######### please ######### START

local cmd=$(fc -ln -1)
[[ $_verbose ]] && echo "sudo \"$BASH\" -c \"$cmd\"" || true
sudo "$BASH" -c "$cmd"

    ######### please ######### END
}
function __complete-please() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest --verbose -v "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}please -- ${BASH_FUNK_PREFIX:--}please

function -reload() {
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
function __impl-reload() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]..."
                echo
                echo "Reloads bash-funk."
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

    ######### reload ######### START

if [[ ! ${__BASH_FUNK_ROOT} ]]; then
    echo "$__fn: Error: __BASH_FUNK_ROOT variable is not defined."
    return 1
fi

if [[ ! -r ${__BASH_FUNK_ROOT}/bash-funk.sh ]]; then
    echo "$__fn: Error: File [${__BASH_FUNK_ROOT}/bash-funk.sh] is not readable by user [$USER]."
    return 1
fi

source ${__BASH_FUNK_ROOT}/bash-funk.sh

    ######### reload ######### END
}
function __complete-reload() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}reload -- ${BASH_FUNK_PREFIX:--}reload

function -test-all() {
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
function __impl-test-all() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]..."
                echo
                echo "Executes the selftests of all loaded bash-funk commands."
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

    ######### test-all ######### START

for testfunc in $(compgen -A function -- ${BASH_FUNK_PREFIX:--}test-); do
    if [[ $testfunc != "${BASH_FUNK_PREFIX:--}test-all" ]]; then
        $testfunc || return 1
    fi
done

    ######### test-all ######### END
}
function __complete-test-all() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}test-all -- ${BASH_FUNK_PREFIX:--}test-all

function -test-misc() {
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
function __impl-test-misc() {
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

    ######### test-misc ######### START

${BASH_FUNK_PREFIX:--}help --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}please --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}reload --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}test-all --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}tweak-bash --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}update --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}var-exists --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}wait --selftest && echo || return 1

    ######### test-misc ######### END
}
function __complete-test-misc() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}test-misc -- ${BASH_FUNK_PREFIX:--}test-misc

function -tweak-bash() {
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
function __impl-tweak-bash() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest _verbose
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]..."
                echo
                echo "Performs some usability configurations of Bash."
                echo
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "\033[1m-v, --verbose\033[22m "
                echo "        Prints additional information during command execution."
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

            --verbose|-v)
                _verbose=1
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

    ######### tweak-bash ######### START


# enable and configure command history
set -o history
export HISTFILE=~/.bash_funk_history
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignorespace:ignoredups
export HISTTIMEFORMAT="%F %T "
export HISTIGNORE="&:?:??:clear:exit:pwd"
history -r

# http://wiki.bash-hackers.org/internals/shell_options
local opt opts=(autocd checkwinsize dirspell direxpand extglob globstar histappend)
for opt in ${opts[@]}; do
    if shopt -s $opt &>/dev/null; then
        [[ $_verbose ]] && echo "shopt -s $opt => ENABLED"
    else
        [[ $_verbose ]] && echo "shopt -s $opt => UNSUPPORTED"
    fi
done

    ######### tweak-bash ######### END
}
function __complete-tweak-bash() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest --verbose -v "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}tweak-bash -- ${BASH_FUNK_PREFIX:--}tweak-bash

function -update() {
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
function __impl-update() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _yes _reload _help _selftest
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]..."
                echo
                echo "Updates bash-funk with the latest code from the github repo."
                echo
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m-r, --reload\033[22m "
                echo "        Reloads the bash-funk after updating."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "\033[1m-y, --yes\033[22m "
                echo "        Answer interactive prompts with 'yes'."
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

            --yes|-y)
                _yes=1
            ;;

            --reload|-r)
                _reload=1
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

    ######### update ######### START

if [[ ! ${__BASH_FUNK_ROOT} ]]; then
    echo "$__fn: Error: __BASH_FUNK_ROOT variable is not defined."
    return 1
fi

if [[ ! -w ${__BASH_FUNK_ROOT} ]]; then
    echo "$__fn: Error: Directory [${__BASH_FUNK_ROOT}] is not writeable by user [$USER]."
    return 1
fi

if [[ ! $_yes ]]; then
    read -p "Are you sure you want to update bash-funk located in [${__BASH_FUNK_ROOT}]? (y) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "$__fn: Aborting on user request."
        return 0
    fi
fi

# update via SVN
if [[ -e "${__BASH_FUNK_ROOT}/.svn" ]]; then
    svn update "${__BASH_FUNK_ROOT}" || return
    [[ $_reload ]] && ${__BASH_FUNK_PREFIX:--}reload || true
    return
fi

# update via Git
if [[ -e "${__BASH_FUNK_ROOT}/.git" ]]; then
    ( cd "${__BASH_FUNK_ROOT}" && git fetch && git merge ) || return
    [[ $_reload ]] && ${__BASH_FUNK_PREFIX:--}reload || true
    return
fi

# update via curl/wget
local get
if hash curl &>/dev/null; then
    get="curl -#L"
else
    if wget --help | grep -- --show-progress &>/dev/null; then
        get="wget -qO- --show-progress"
    else
        get="wget -qO-"
    fi
fi
( cd "${__BASH_FUNK_ROOT}" && $get https://github.com/vegardit/bash-funk/tarball/master | tar -xzv --strip-components 1 ) || return
[[ $_reload ]] && ${__BASH_FUNK_PREFIX:--}reload || true
return

    ######### update ######### END
}
function __complete-update() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --yes -y --reload -r --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}update -- ${BASH_FUNK_PREFIX:--}update

function -var-exists() {
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
        echo; echo "Usage: $__fn [OPTION]... VARIABLE_NAME"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-var-exists() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest _verbose _VARIABLE_NAME
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]... VARIABLE_NAME"
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
                echo -e "$ \033[1m$__fn USER\033[22m"
                echo
                echo -e "$ \033[1m$__fn -v USER\033[22m"
                echo "Bash variable 'USER' exists."
                echo -e "$ \033[1m$__fn -v NON_EXISTANT_VARIABLE\033[22m"
                echo "Bash variable 'NON_EXISTANT_VARIABLE' does not exist."
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
                echo -e "$ \033[1m$__fn USER\033[22m"
                __stdout="$($__fn USER)"; __rc=$?
                echo "$__stdout"
                if [[ $__rc != 0 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [0]."; return 64; fi
                __regex="^$"
                if [[ ! "$__stdout" =~ $__regex ]]; then echo -e "--> \033[31mFAILED\033[0m - stdout [$__stdout] does not match required pattern []."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo -e "$ \033[1m$__fn -v USER\033[22m"
                __stdout="$($__fn -v USER)"; __rc=$?
                echo "$__stdout"
                if [[ $__rc != 0 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [0]."; return 64; fi
                __regex="^Bash variable 'USER' exists.$"
                if [[ ! "$__stdout" =~ $__regex ]]; then echo -e "--> \033[31mFAILED\033[0m - stdout [$__stdout] does not match required pattern [Bash variable 'USER' exists.]."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo -e "$ \033[1m$__fn -v NON_EXISTANT_VARIABLE\033[22m"
                __stdout="$($__fn -v NON_EXISTANT_VARIABLE)"; __rc=$?
                echo "$__stdout"
                if [[ $__rc != 1 ]]; then echo -e "--> \033[31mFAILED\033[0m - exit code [$__rc] instead of expected [1]."; return 64; fi
                __regex="Bash variable 'NON_EXISTANT_VARIABLE' does not exist."
                if [[ ! "$__stdout" =~ $__regex ]]; then echo -e "--> \033[31mFAILED\033[0m - stdout [$__stdout] does not match required pattern [Bash variable 'NON_EXISTANT_VARIABLE' does not exist.]."; return 64; fi
                echo -e "--> \033[32mOK\033[0m"
                echo "Testing function [$__fn]...DONE"
                return 0
              ;;

            --verbose|-v)
                _verbose=1
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
        if [[ ! $_VARIABLE_NAME ]]; then
            _VARIABLE_NAME=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ $_VARIABLE_NAME ]]; then
        true
    else
        echo "$__fn: Error: Parameter VARIABLE_NAME must be specified."; return 64
    fi

    ######### var-exists ######### START

if declare -p $_VARIABLE_NAME &>/dev/null; then
    [[ $_verbose ]] && echo "Bash variable '$_VARIABLE_NAME' exists." || true
    return 0
else
    [[ $_verbose ]] && echo "Bash variable '$_VARIABLE_NAME' does not exist." || true
    return 1
fi

    ######### var-exists ######### END
}
function __complete-var-exists() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest --verbose -v "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}var-exists -- ${BASH_FUNK_PREFIX:--}var-exists

function -wait() {
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
        echo; echo "Usage: $__fn [OPTION]... SECONDS"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-wait() {
    local __arg __optionWithValue __params=() __in_subshell __in_pipe __fn=${FUNCNAME[0]/__impl/} _help _selftest _SECONDS
    [ -p /dev/stdout ] && __in_pipe=1 || true
    [ -t 1 ] || __in_subshell=1
    for __arg in "$@"; do
        case $__arg in

            --help)
                echo "Usage: $__fn [OPTION]... SECONDS"
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
        if [[ ! $_SECONDS ]]; then
            _SECONDS=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ $_SECONDS ]]; then
        true
    else
        echo "$__fn: Error: Parameter SECONDS must be specified."; return 64
    fi

    ######### wait ######### START

local green="\033[1;32m"
local reset="\033[0m"
local saveCursor="\033[s"
local restoreCursor="\033[u"
local cursor9Right="\033[9C"
local cursor9Left="\033[9D"

echo -ne "Waiting for [$(date +%T --date=@$(($_SECONDS - 3600)))] until $(date +%T --date=@$(($(date +%s) + $_SECONDS))). Press [s] to skip: $cursor9Right"
for (( i = 0; i < _SECONDS; i++ )); do
    if [[ $__in_pipe || $__in_subshell ]]; then
        # adding a \n new line character to the end of the line to make the output parseable by sed which is line oriented
        local newLine="$saveCursor\n$restoreCursor"
    else
        local newLine
    fi
    echo -ne "$cursor9Left$green$(date +%T --date=@$(($_SECONDS - ${i} - 3600))) $reset$newLine"
    local char=
    read -s -n1 -t1 char || :
    [[ $char == "s" ]] && break
done
echo

    ######### wait ######### END
}
function __complete-wait() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help --selftest "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}wait -- ${BASH_FUNK_PREFIX:--}wait


function -help-misc() {
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}help\033[0m  -  Prints the online help of all bash-funk commands."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}please\033[0m  -  Re-runs the previously entered command with sudo."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}reload\033[0m  -  Reloads bash-funk."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}test-all\033[0m  -  Executes the selftests of all loaded bash-funk commands."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}test-misc\033[0m  -  Performs a selftest of all functions of this module by executing each function with option '--selftest'."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}tweak-bash\033[0m  -  Performs some usability configurations of Bash."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}update\033[0m  -  Updates bash-funk with the latest code from the github repo."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}var-exists VARIABLE_NAME\033[0m  -  Determines if the given variable is declared."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}wait SECONDS\033[0m  -  Waits for the given number of seconds or until the key 's' pressed."

}
__BASH_FUNK_FUNCS+=( help please reload test-all test-misc tweak-bash update var-exists wait )

alias gh='command history|command grep'
alias grep="command grep --colour=auto"

function -timeout() {
    if [[ $# < 2 || ${1:-} == "--help" ]]; then
        echo "Usage: ${FUNCNAME[0]} TIMEOUT COMMAND [ARG]..."
        echo "Executes the COMMAND and aborts if it does not finish within the given TIMEOUT in seconds."
        [[ ${1:-} == "--help" ]] && return 0 || return 1
    fi
    # see: http://mywiki.wooledge.org/BashFAQ/068
    perl -e 'alarm shift; exec @ARGV' "$@";
}
