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

function -is-loadable() {
    if hash git &>/dev/null; then
    return 0
else
    return 1
fi

}

if ${BASH_FUNK_PREFIX:--}is-loadable; then
function -git-branch-name() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... [PATH]"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-git-branch-name() {
    local __args=() __arg __idx __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _PATH
    [ -t 1 ] && __interactive=1 || true
    
    for __arg in "$@"; do
        case "$__arg" in
            -|--*) __args+=("$__arg") ;;
            -*) for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
        esac
    done
    for __arg in "${__args[@]}"; do
        case "$__arg" in

            --help)
                echo "Usage: $__fn [OPTION]... [PATH]"
                echo
                echo "Prints the name of the currently checked out git branch."
                echo
                echo "Parameters:"
                echo -e "  \033[1mPATH\033[22m (default: '.', directory)"
                echo "      The path to check."
                echo
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "    \033[1m--\033[22m"
                echo "        Terminates the option list."
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

            --)
                __optionWithValue=--
              ;;
            -*)
                if [[ $__optionWithValue == '--' ]]; then
                        __params+=("$__arg")
                else
                    echo "$__fn: invalid option: '$__arg'"
                    return 64
                fi
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
        if [[ ! $_PATH && ${#__params[@]} > 0 ]]; then
            _PATH=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ ! $_PATH ]]; then _PATH="."; fi

    if [[ $_PATH ]]; then
        if [[ ! -e "$_PATH" ]]; then echo "$__fn: Error: Directory '$_PATH' for parameter PATH does not exist."; return 64; fi
        if [[ -e "$_PATH" && ! -d "$_PATH" ]]; then echo "$__fn: Error: Path '$_PATH' for parameter PATH is not a directory."; return 64; fi
        if [[ ! -r "$_PATH" ]]; then echo "$__fn: Error: Directory '$_PATH' for parameter PATH is not readable by user '$USER'."; return 64; fi
    fi

    ######### git-branch-name ######### START

git -C "$_PATH" rev-parse --symbolic-full-name --abbrev-ref HEAD

    ######### git-branch-name ######### END
}
function __complete-git-branch-name() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}git-branch-name -- ${BASH_FUNK_PREFIX:--}git-branch-name

function -git-switch-remote-protocol() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... REMOTE_NAME1 [REMOTE_NAME]... PROTOCOL"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-git-switch-remote-protocol() {
    local __args=() __arg __idx __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _REMOTE_NAME=() _PROTOCOL
    [ -t 1 ] && __interactive=1 || true
    
    for __arg in "$@"; do
        case "$__arg" in
            -|--*) __args+=("$__arg") ;;
            -*) for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
        esac
    done
    for __arg in "${__args[@]}"; do
        case "$__arg" in

            --help)
                echo "Usage: $__fn [OPTION]... REMOTE_NAME1 [REMOTE_NAME]... PROTOCOL"
                echo
                echo "Switches the protocol of the given remote(s) between HTTPS and SSH."
                echo
                echo "Parameters:"
                echo -e "  \033[1mREMOTE_NAME\033[22m (1 or more required)"
                echo "      The name of the remote, e.g. 'origin', 'upstream'. If not specified all remotes are changed."
                echo -e "  \033[1mPROTOCOL\033[22m (required, one of: [https,ssh])"
                echo "      The new protocol to use."
                echo
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "    \033[1m--\033[22m"
                echo "        Terminates the option list."
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

            --)
                __optionWithValue=--
              ;;
            -*)
                if [[ $__optionWithValue == '--' ]]; then
                        __params+=("$__arg")
                else
                    echo "$__fn: invalid option: '$__arg'"
                    return 64
                fi
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
        if [[ ${#_REMOTE_NAME[@]} -lt 1 ]]; then
            _REMOTE_NAME+=("$__param")
            continue
        fi
        local __leftoverParams=$(( ${#__params[@]} - 2 - ${#_REMOTE_NAME[@]} ))
        if [[ $__leftoverParams -gt 0 ]]; then
            _REMOTE_NAME+=("$__param")
            continue
        fi
        if [[ ! $_PROTOCOL ]]; then
            _PROTOCOL=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ ${#_REMOTE_NAME[@]} -lt 1 ]]; then echo "$__fn: Error: For parameter REMOTE_NAME 1 value(s) must be specified. Found: ${#_REMOTE_NAME[@]}."; return 64; fi
    if [[ $_PROTOCOL ]]; then
        if [[ $_PROTOCOL != 'https' && $_PROTOCOL != 'ssh' ]]; then echo "$__fn: Error: Value '$_PROTOCOL' for parameter PROTOCOL is not one of the allowed values [https,ssh]."; return 64; fi
    else
        echo "$__fn: Error: Parameter PROTOCOL must be specified."; return 64
    fi

    ######### git-switch-remote-protocol ######### START

local url remote

for remote in "${_REMOTE_NAME[@]}"; do
    if url=$(git remote get-url $_REMOTE_NAME); then
        case "$_PROTOCOL" in
            ssh)
                case "$url" in
                    https://*)
                        echo "Switching protocol of remote [$remote] to SSH..."
                        git remote set-url origin "git@${url#https://*}"
                        git remote -v | grep "^$remote"
                      ;;
                    git@*)
                        echo "Remote [$remote] already uses SSH: $url"
                      ;;
                    *)
                        echo "$__fn: URL [$url] for remote [$remote] starts with unknown protocol."
                        return 1
                      ;;
                esac
              ;;

            https)
                case "$url" in
                    https://*)
                        echo "Remote [$remote] already uses HTTPS: $url"
                      ;;
                    git@*)
                        echo "Switching protocol of remote [$remote] to HTTPS..."
                        git remote set-url origin "https://${url#git@*}"
                        git remote -v | grep "^$remote"
                      ;;
                    *)
                        echo "$__fn: URL [$url] for remote [$remote] starts with unknown protocol."
                        return 1
                      ;;
                esac
              ;;
        esac
    else
        return 1
    fi
done

    ######### git-switch-remote-protocol ######### END
}
function __complete-git-switch-remote-protocol() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}git-switch-remote-protocol -- ${BASH_FUNK_PREFIX:--}git-switch-remote-protocol

function -git-sync-fork() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]..."
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-git-sync-fork() {
    local __args=() __arg __idx __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _branch _upstream_branch _merge _push _help _selftest
    [ -t 1 ] && __interactive=1 || true
    
    for __arg in "$@"; do
        case "$__arg" in
            -|--*) __args+=("$__arg") ;;
            -*) for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
        esac
    done
    for __arg in "${__args[@]}"; do
        case "$__arg" in

            --help)
                echo "Usage: $__fn [OPTION]..."
                echo
                echo "Syncs the currently checked out branch of a forked repository with it's upstream repository. Uses 'git rebase -p' instead of 'git merge' by default to prevent an extra commit for the merge operation."
                echo
                echo "Options:"
                echo -e "\033[1m    --branch NAME\033[22m "
                echo "        Branch in the forked repository to sync."
                echo -e "\033[1m    --merge\033[22m "
                echo "        Use 'git merge' instead of 'git rebase -p'."
                echo -e "\033[1m    --push\033[22m "
                echo "        Push updates to origin after sync."
                echo -e "\033[1m    --upstream_branch NAME\033[22m "
                echo "        Branch in the upstream repository to sync with."
                echo "    -----------------------------"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "    \033[1m--\033[22m"
                echo "        Terminates the option list."
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

            --branch)
                _branch="@@##@@"
                __optionWithValue=branch
            ;;

            --upstream_branch)
                _upstream_branch="@@##@@"
                __optionWithValue=upstream_branch
            ;;

            --merge)
                _merge=1
            ;;

            --push)
                _push=1
            ;;

            --)
                __optionWithValue=--
              ;;
            -*)
                if [[ $__optionWithValue == '--' ]]; then
                        __params+=("$__arg")
                else
                    echo "$__fn: invalid option: '$__arg'"
                    return 64
                fi
              ;;

            *)
                case $__optionWithValue in
                    branch)
                        _branch=$__arg
                        __optionWithValue=
                      ;;
                    upstream_branch)
                        _upstream_branch=$__arg
                        __optionWithValue=
                      ;;
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

    if [[ $_branch ]]; then
        if [[ $_branch == "@@##@@" ]]; then echo "$__fn: Error: Value NAME for option --branch must be specified."; return 64; fi
    fi
    if [[ $_upstream_branch ]]; then
        if [[ $_upstream_branch == "@@##@@" ]]; then echo "$__fn: Error: Value NAME for option --upstream_branch must be specified."; return 64; fi
    fi

    ######### git-sync-fork ######### START

local currBranch currBranch_remote currBranch_remoteURL upstreamURL

# e.g. 'master'
if [[ ${_branch:-} ]]; then
    currBranch=$_branch
else
    currBranch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD) || return 1
fi

# e.g. 'origin'
currBranch_remote=$(git config branch.$currBranch.remote) || return 1
currBranch_remoteURL=$(git config --get remote.$currBranch_remote.url) || return 1

upstreamURL=$(git remote get-url "upstream" 2>/dev/null) || true
if [[ ! $upstreamURL ]]; then
    # if forked repo is on github try to get the upstream URL via github API
    if [[ ! $currBranch_remoteURL == *github.com/* ]] || ! upstreamURL="$(${BASH_FUNK_PREFIX:--}github-upstream-url "${currBranch_remoteURL#*github.com/}")"; then
        echo "$__fn: No remote 'upstream' defined. You can add it using 'git remote add upstream [REMOTE_URL]'."
        return 1
    fi
    echo "Adding remote 'upstream $upstreamURL'..."
    git remote add upstream $upstreamURL || return 1
fi

local _upstream_branch=${_upstream_branch:-$currBranch}

echo "Fetching updates from 'upstream/$_upstream_branch'..."
git fetch upstream $_upstream_branch || return 1

git checkout $_branch || return 1

echo "Incorporating updates from 'upstream/$_upstream_branch' into '$currBranch'..."
if [[ $_merge ]]; then
    git merge upstream/$_upstream_branch || return 1
else
    git rebase -p upstream/$_upstream_branch || return 1
fi

if [[ $_push ]]; then
    echo "Pushing updates to 'origin/$currBranch'..."
    git push --follow-tags --force origin $currBranch
fi

    ######### git-sync-fork ######### END
}
function __complete-git-sync-fork() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --branch --upstream_branch --merge --push --help "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}git-sync-fork -- ${BASH_FUNK_PREFIX:--}git-sync-fork

function -git-update-branch() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... [BRANCH] MASTER"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-git-update-branch() {
    local __args=() __arg __idx __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _merge _push _help _selftest _BRANCH _MASTER
    [ -t 1 ] && __interactive=1 || true
    
    for __arg in "$@"; do
        case "$__arg" in
            -|--*) __args+=("$__arg") ;;
            -*) for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
        esac
    done
    for __arg in "${__args[@]}"; do
        case "$__arg" in

            --help)
                echo "Usage: $__fn [OPTION]... [BRANCH] MASTER"
                echo
                echo "Updates the given branch using 'git rebase -p' by default."
                echo
                echo "Parameters:"
                echo -e "  \033[1mBRANCH\033[22m "
                echo "      Name of the branch to update."
                echo -e "  \033[1mMASTER\033[22m (required)"
                echo "      Name of the branch to get updates from."
                echo
                echo "Options:"
                echo -e "\033[1m    --merge\033[22m "
                echo "        Use 'git merge' instead of 'git rebase -p'. Rule of thumb: use 'git rebase -p' for personal branches and 'git merge' for shared branches with commits by others."
                echo -e "\033[1m    --push\033[22m "
                echo "        Push updates to origin after sync."
                echo "    -----------------------------"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "    \033[1m--\033[22m"
                echo "        Terminates the option list."
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

            --merge)
                _merge=1
            ;;

            --push)
                _push=1
            ;;

            --)
                __optionWithValue=--
              ;;
            -*)
                if [[ $__optionWithValue == '--' ]]; then
                        __params+=("$__arg")
                else
                    echo "$__fn: invalid option: '$__arg'"
                    return 64
                fi
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
        if [[ ! $_BRANCH && ${#__params[@]} > 1 ]]; then
            _BRANCH=$__param
            continue
        fi
        if [[ ! $_MASTER ]]; then
            _MASTER=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ $_MASTER ]]; then
        true
    else
        echo "$__fn: Error: Parameter MASTER must be specified."; return 64
    fi

    ######### git-update-branch ######### START

if [[ ! ${_BRANCH:-} ]]; then
    _BRANCH=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD) || return 1
fi

git checkout $_MASTER || return 1

git pull || return 1

git checkout $_BRANCH || return 1

echo "Incorporating updates from '$_MASTER' into '$_BRANCH'..."
if [[ $_merge ]]; then
    git merge $_MASTER || return 1
else
    git rebase -p $_MASTER || return 1
fi

if [[ $_push ]]; then
    echo "Pushing updates to 'origin/$_BRANCH'..."
    git push --follow-tags --force origin $_BRANCH
fi

    ######### git-update-branch ######### END
}
function __complete-git-update-branch() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --merge --push --help "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}git-update-branch -- ${BASH_FUNK_PREFIX:--}git-update-branch

function -github-upstream-url() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]... REPO"
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-github-upstream-url() {
    local __args=() __arg __idx __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _REPO
    [ -t 1 ] && __interactive=1 || true
    
    for __arg in "$@"; do
        case "$__arg" in
            -|--*) __args+=("$__arg") ;;
            -*) for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
        esac
    done
    for __arg in "${__args[@]}"; do
        case "$__arg" in

            --help)
                echo "Usage: $__fn [OPTION]... REPO"
                echo
                echo "Prints the upstream URL in case the given GitHub repository is a fork."
                echo
                echo "Parameters:"
                echo -e "  \033[1mREPO\033[22m (required)"
                echo "      The github repository to check, e.g. 'vegardit/bash-funk'."
                echo
                echo "Options:"
                echo -e "\033[1m    --help\033[22m "
                echo "        Prints this help."
                echo -e "\033[1m    --selftest\033[22m "
                echo "        Performs a self-test."
                echo -e "    \033[1m--\033[22m"
                echo "        Terminates the option list."
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

            --)
                __optionWithValue=--
              ;;
            -*)
                if [[ $__optionWithValue == '--' ]]; then
                        __params+=("$__arg")
                else
                    echo "$__fn: invalid option: '$__arg'"
                    return 64
                fi
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
        if [[ ! $_REPO ]]; then
            _REPO=$__param
            continue
        fi
        echo "$__fn: Error: too many parameters: '$__param'"
        return 64
    done

    if [[ $_REPO ]]; then
        true
    else
        echo "$__fn: Error: Parameter REPO must be specified."; return 64
    fi

    ######### github-upstream-url ######### START

hash wget &>/dev/null && local get="wget -qO-" || local get="curl -fs"

$get https://api.github.com/repos/$_REPO | grep -A100 '"parent":' | grep clone_url | head -n1 | cut -d'"' -f4
return ${PIPESTATUS[0]}

    ######### github-upstream-url ######### END
}
function __complete-github-upstream-url() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}github-upstream-url -- ${BASH_FUNK_PREFIX:--}github-upstream-url

function -test-git() {
    local opts="" opt rc __fn=${FUNCNAME[0]}
    for opt in a u H t; do
        [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
    done
    shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
    for opt in nullglob extglob nocasematch nocaseglob; do
        shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
    done

    set +auHt
    set -o pipefail

    __impl$__fn "$@" && rc=0 || rc=$?

    if [[ $rc == 64 && -t 1 ]]; then
        echo; echo "Usage: $__fn [OPTION]..."
        echo; echo "Type '$__fn --help' for more details."
    fi

    eval $opts

    return $rc
}
function __impl-test-git() {
    local __args=() __arg __idx __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest
    [ -t 1 ] && __interactive=1 || true
    
    for __arg in "$@"; do
        case "$__arg" in
            -|--*) __args+=("$__arg") ;;
            -*) for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
        esac
    done
    for __arg in "${__args[@]}"; do
        case "$__arg" in

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
                echo -e "    \033[1m--\033[22m"
                echo "        Terminates the option list."
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

            --)
                __optionWithValue=--
              ;;
            -*)
                if [[ $__optionWithValue == '--' ]]; then
                        __params+=("$__arg")
                else
                    echo "$__fn: invalid option: '$__arg'"
                    return 64
                fi
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

    ######### test-git ######### START

${BASH_FUNK_PREFIX:--}git-branch-name --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}git-switch-remote-protocol --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}git-sync-fork --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}git-update-branch --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}github-upstream-url --selftest && echo || return 1

    ######### test-git ######### END
}
function __complete-test-git() {
    local curr=${COMP_WORDS[COMP_CWORD]}
    if [[ ${curr} == -* ]]; then
        local options=" --help "
        for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
        COMPREPLY=($(compgen -o default -W '$options' -- $curr))
    else
        COMPREPLY=($(compgen -o default -- $curr))
    fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}test-git -- ${BASH_FUNK_PREFIX:--}test-git


function -help-git() {
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}git-branch-name [PATH]\033[0m  -  Prints the name of the currently checked out git branch."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}git-switch-remote-protocol REMOTE_NAME1 [REMOTE_NAME]... PROTOCOL\033[0m  -  Switches the protocol of the given remote(s) between HTTPS and SSH."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}git-sync-fork\033[0m  -  Syncs the currently checked out branch of a forked repository with it's upstream repository. Uses 'git rebase -p' instead of 'git merge' by default to prevent an extra commit for the merge operation."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}git-update-branch [BRANCH] MASTER\033[0m  -  Updates the given branch using 'git rebase -p' by default."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}github-upstream-url REPO\033[0m  -  Prints the upstream URL in case the given GitHub repository is a fork."
    echo -e "\033[1m${BASH_FUNK_PREFIX:--}test-git\033[0m  -  Performs a selftest of all functions of this module by executing each function with option '--selftest'."

}
__BASH_FUNK_FUNCS+=( git-branch-name git-switch-remote-protocol git-sync-fork git-update-branch github-upstream-url test-git )

else
    echo "SKIPPED"
fi
unset -f -- ${BASH_FUNK_PREFIX:--}is-loadable