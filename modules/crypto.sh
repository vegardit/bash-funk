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

function -md5sum() {

    [[ -p /dev/stdout ]] && local _in_pipe=1 || local _in_pipe=
    [ -t 1 ] && local _in_subshell= || local _in_subshell=1
    local fn=${FUNCNAME[0]}
    [[ $_in_pipe || $_in_subshell ]] && local hint= || local hint="

Usage: $fn [OPTION]... PATH_TO_FILE

Type '$fn --help' for more details."
    local arg optionWithValue params=() _help _selftest _PATH_TO_FILE
    for arg in "$@"; do
        case $arg in
    
            --help)
                echo "Usage: $fn [OPTION]... PATH_TO_FILE"
                echo 
                echo "Calculates the MD5 hash of the given file."
                echo 
                echo "Parameters:"
                echo -e "  \033[1mPATH_TO_FILE\033[22m (required)"
                echo "      The file."
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
        if [[ ! $_PATH_TO_FILE ]]; then
            _PATH_TO_FILE=$param
            continue
        fi
        echo "$fn: Error: too many parameters: '$param'$hint"
        return 1
    done
    unset param params leftoverParams
    
    
    if [[ $_PATH_TO_FILE ]]; then
        true
    else
        echo "$fn: Error: Parameter PATH_TO_FILE must be specified.$hint"; return 1
    fi
    
    
    ######################################################


# use md5sum if available
if hash md5sum &>/dev/null; then
    md5sum $_PATH_TO_FILE | cut -d ' ' -f1

# use perl if available
elif hash perl &> /dev/null; then
    perl << EOF
use Digest::MD5;
open(my \$FILE, '$_PATH_TO_FILE');
binmode(\$FILE);
print Digest::MD5->new->addfile(\$FILE)->hexdigest, "\n";
close(\$FILE);
EOF

# use python as last resort
else
    python -c "import hashlib
print hashlib.md5(open('$_PATH_TO_FILE').read()).hexdigest()"
fi


}
function _-md5sum() {
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    if [[ ${currentWord} == -* ]]; then
        local options=" --help --selftest "
        for o in ${COMP_WORDS[@]}; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $currentWord))
    else
        COMPREPLY=($(compgen -o default -- $currentWord))
    fi
}
complete -F _${BASH_FUNK_PREFIX:-}-md5sum -- ${BASH_FUNK_PREFIX:-}-md5sum

function -sha256sum() {

    [[ -p /dev/stdout ]] && local _in_pipe=1 || local _in_pipe=
    [ -t 1 ] && local _in_subshell= || local _in_subshell=1
    local fn=${FUNCNAME[0]}
    [[ $_in_pipe || $_in_subshell ]] && local hint= || local hint="

Usage: $fn [OPTION]... PATH_TO_FILE

Type '$fn --help' for more details."
    local arg optionWithValue params=() _help _selftest _PATH_TO_FILE
    for arg in "$@"; do
        case $arg in
    
            --help)
                echo "Usage: $fn [OPTION]... PATH_TO_FILE"
                echo 
                echo "Calculates the SHA256 hash of the given file."
                echo 
                echo "Parameters:"
                echo -e "  \033[1mPATH_TO_FILE\033[22m (required)"
                echo "      The file."
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
        if [[ ! $_PATH_TO_FILE ]]; then
            _PATH_TO_FILE=$param
            continue
        fi
        echo "$fn: Error: too many parameters: '$param'$hint"
        return 1
    done
    unset param params leftoverParams
    
    
    if [[ $_PATH_TO_FILE ]]; then
        true
    else
        echo "$fn: Error: Parameter PATH_TO_FILE must be specified.$hint"; return 1
    fi
    
    
    ######################################################


# use sha256 if available
if hash sha256 &>/dev/null; then
    sha256 $_PATH_TO_FILE | cut -d ' ' -f1

# use perl if available
elif hash perl &> /dev/null; then
    perl << EOF
use Digest::SHA;
open(my \$FILE, '$_PATH_TO_FILE');
binmode(\$FILE);
print Digest::SHA->new(256)->addfile(\$FILE)->hexdigest, "\n";
close(\$FILE);
EOF

# use python as last resort
else
    python -c "import hashlib
print hashlib.sha256(open('$_PATH_TO_FILE').read()).hexdigest()"
fi


}
function _-sha256sum() {
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    if [[ ${currentWord} == -* ]]; then
        local options=" --help --selftest "
        for o in ${COMP_WORDS[@]}; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $currentWord))
    else
        COMPREPLY=($(compgen -o default -- $currentWord))
    fi
}
complete -F _${BASH_FUNK_PREFIX:-}-sha256sum -- ${BASH_FUNK_PREFIX:-}-sha256sum

function -test-crypto() {

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

${BASH_FUNK_PREFIX:-}-md5sum --selftest && echo || return 1
${BASH_FUNK_PREFIX:-}-sha256sum --selftest && echo || return 1
}
function _-test-crypto() {
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    if [[ ${currentWord} == -* ]]; then
        local options=" --help --selftest "
        for o in ${COMP_WORDS[@]}; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $currentWord))
    else
        COMPREPLY=($(compgen -o default -- $currentWord))
    fi
}
complete -F _${BASH_FUNK_PREFIX:-}-test-crypto -- ${BASH_FUNK_PREFIX:-}-test-crypto

function -help-crypto() {

    echo -e "\033[1m${BASH_FUNK_PREFIX:-}-md5sum PATH_TO_FILE\033[0m  -  Calculates the MD5 hash of the given file."
    echo -e "\033[1m${BASH_FUNK_PREFIX:-}-sha256sum PATH_TO_FILE\033[0m  -  Calculates the SHA256 hash of the given file."
    echo -e "\033[1m${BASH_FUNK_PREFIX:-}-test-crypto\033[0m  -  Performs a selftest of all functions of this module by executing each function with option '--selftest'."

}

