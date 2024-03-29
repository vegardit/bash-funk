#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com)
# SPDX-License-Identifier: Apache-2.0
#
# @author Sebastian Thomschke, Vegard IT GmbH
# @author Patrick Spielmann, Vegard IT GmbH
#
# THIS FILE IS GENERATED BY BASH-FUNK GENERATOR
#
# documentation: https://github.com/vegardit/bash-funk/tree/main/docs/ssh.md
#

function -ssh-agent-add-key() {
   if [[ "$-" == *x* ]]; then set +x; local opts="set -x"; else local opts=""; fi

   local opt rc __fn=${FUNCNAME[0]}
   for opt in a u H t; do
      [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
   done
   shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
   for opt in nullglob extglob nocasematch nocaseglob; do
      shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
   done

   set +auHtx -o pipefail

   local _ps4=$PS4
   PS4='+\033[90m[$?] $BASH_SOURCE:$LINENO ${FUNCNAME[0]}()\033[0m '
   __impl$__fn "$@" && rc=0 || rc=$?
   PS4=$_ps4

   if [[ $rc == 64 && -t 1 ]]; then
      echo -e "\nUsage: $__fn [OPTION]... KEY_FILE PASSWORD\n\nType '$__fn --help' for more details."
   fi
   eval $opts
   return $rc
}
function __impl-ssh-agent-add-key() {
   local __args=() __arg __idx __noMoreFlags __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _tracecmd _KEY_FILE _PASSWORD
   [ -t 1 ] && __interactive=1 || true
         for __arg in "$@"; do
         case "$__arg" in
            --) __noMoreFlags=1; __args+=("--") ;;
            -|--*) __args+=("$__arg") ;;
            -*) [[ $__noMoreFlags == "1" ]] && __args+=("$__arg") || for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
         esac
      done
   for __arg in "${__args[@]}"; do
      if [[ $__optionWithValue == "--" ]]; then
         __params+=("$__arg")
         continue
      fi
      case "$__arg" in

         --help)
            echo "Usage: $__fn [OPTION]... KEY_FILE PASSWORD"
            echo
            echo "Adds the private key to the ssh-agent."
            echo
            echo "Requirements:"
            echo "  + Command 'ssh-add' must be available."
            echo "  + Command 'ssh-agent' must be available."
            echo "  + Command 'expect' must be available."
            echo
            echo "Parameters:"
            echo -e "  \033[1mKEY_FILE\033[22m (required, file)"
            echo "      Path to the key file."
            echo -e "  \033[1mPASSWORD\033[22m (required)"
            echo "      Password to open the key file."
            echo
            echo "Options:"
            echo -e "\033[1m    --help\033[22m"
            echo "        Prints this help."
            echo -e "\033[1m    --tracecmd\033[22m"
            echo "        Enables bash debug mode (set -x)."
            echo -e "\033[1m    --selftest\033[22m"
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

         --tracecmd) _tracecmd=1 ;;

         --)
            __optionWithValue="--"
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
      if [[ ! $_KEY_FILE ]]; then
         _KEY_FILE=$__param
         continue
      fi
      if [[ ! $_PASSWORD ]]; then
         _PASSWORD=$__param
         continue
      fi
      echo "$__fn: Error: too many parameters: '$__param'"
      return 64
   done

   if [[ $_KEY_FILE ]]; then
      if [[ ! -e "$_KEY_FILE" ]]; then echo "$__fn: Error: File '$_KEY_FILE' for parameter KEY_FILE does not exist."; return 64; fi
      if [[ -e "$_KEY_FILE" && ! -f "$_KEY_FILE" ]]; then echo "$__fn: Error: Path '$_KEY_FILE' for parameter KEY_FILE is not a file."; return 64; fi
      if [[ ! -r "$_KEY_FILE" ]]; then echo "$__fn: Error: File '$_KEY_FILE' for parameter KEY_FILE is not readable by user '$USER'."; return 64; fi
   else
      echo "$__fn: Error: Parameter KEY_FILE must be specified."; return 64
   fi
   if [[ $_PASSWORD ]]; then
      true
   else
      echo "$__fn: Error: Parameter PASSWORD must be specified."; return 64
   fi

   if ! hash "ssh-add" &>/dev/null; then echo "$__fn: Error: Required command 'ssh-add' not found on this system."; return 64; fi
   if ! hash "ssh-agent" &>/dev/null; then echo "$__fn: Error: Required command 'ssh-agent' not found on this system."; return 64; fi
   if ! hash "expect" &>/dev/null; then echo "$__fn: Error: Required command 'expect' not found on this system."; return 64; fi

####### ssh-agent-add-key ####### START
[[ $_tracecmd ]] && set -x || true
eval $(ssh-agent)

expect << EOF
   spawn ssh-add $_KEY_FILE
   expect "Enter passphrase"
   send "$_PASSWORD\r"
   expect eof
EOF
[[ $_tracecmd ]] && set +x || true
####### ssh-agent-add-key ####### END
}
function __complete-ssh-agent-add-key() {
   local curr=${COMP_WORDS[COMP_CWORD]}
   if [[ ${curr} == -* ]]; then
      local options=" --help --tracecmd "
      for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
      COMPREPLY=($(compgen -o default -W '$options' -- $curr))
   else
      COMPREPLY=($(compgen -o default -- $curr))
   fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}ssh-agent-add-key -- ${BASH_FUNK_PREFIX:--}ssh-agent-add-key

function -ssh-gen-keypair() {
   if [[ "$-" == *x* ]]; then set +x; local opts="set -x"; else local opts=""; fi

   local opt rc __fn=${FUNCNAME[0]}
   for opt in a u H t; do
      [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
   done
   shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
   for opt in nullglob extglob nocasematch nocaseglob; do
      shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
   done

   set +auHtx -o pipefail

   local _ps4=$PS4
   PS4='+\033[90m[$?] $BASH_SOURCE:$LINENO ${FUNCNAME[0]}()\033[0m '
   __impl$__fn "$@" && rc=0 || rc=$?
   PS4=$_ps4

   if [[ $rc == 64 && -t 1 ]]; then
      echo -e "\nUsage: $__fn [OPTION]... FILENAME\n\nType '$__fn --help' for more details."
   fi
   eval $opts
   return $rc
}
function __impl-ssh-gen-keypair() {
   local __args=() __arg __idx __noMoreFlags __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _comment _password _keysize _help _selftest _tracecmd _FILENAME
   [ -t 1 ] && __interactive=1 || true
         for __arg in "$@"; do
         case "$__arg" in
            --) __noMoreFlags=1; __args+=("--") ;;
            -|--*) __args+=("$__arg") ;;
            -*) [[ $__noMoreFlags == "1" ]] && __args+=("$__arg") || for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
         esac
      done
   for __arg in "${__args[@]}"; do
      if [[ $__optionWithValue == "--" ]]; then
         __params+=("$__arg")
         continue
      fi
      case "$__arg" in

         --help)
            echo "Usage: $__fn [OPTION]... FILENAME"
            echo
            echo "Creates an private/public SSH keypair."
            echo
            echo "Requirements:"
            echo "  + Command 'ssh-keygen' must be available."
            echo
            echo "Parameters:"
            echo -e "  \033[1mFILENAME\033[22m (required, file)"
            echo "      Private key filename."
            echo
            echo "Options:"
            echo -e "\033[1m-C, --comment COMMENT\033[22m"
            echo "        Comment."
            echo -e "\033[1m    --keysize SIZE\033[22m (integer: 1-?)"
            echo "        Number of bits of the private key. Default is 4096."
            echo -e "\033[1m-p, --password PASSWORD\033[22m"
            echo "        Password to protect the private key file."
            echo "    -----------------------------"
            echo -e "\033[1m    --help\033[22m"
            echo "        Prints this help."
            echo -e "\033[1m    --tracecmd\033[22m"
            echo "        Enables bash debug mode (set -x)."
            echo -e "\033[1m    --selftest\033[22m"
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

         --tracecmd) _tracecmd=1 ;;

         --comment|-C)
            _comment="@@##@@"
            __optionWithValue=comment
         ;;

         --password|-p)
            _password="@@##@@"
            __optionWithValue=password
         ;;

         --keysize)
            _keysize="@@##@@"
            __optionWithValue=keysize
         ;;

         --)
            __optionWithValue="--"
           ;;
         -*)
            echo "$__fn: invalid option: '$__arg'"
            return 64
           ;;

         *)
            case $__optionWithValue in
               comment)
                  _comment=$__arg
                  __optionWithValue=
                 ;;
               password)
                  _password=$__arg
                  __optionWithValue=
                 ;;
               keysize)
                  _keysize=$__arg
                  __optionWithValue=
                 ;;
               *)
                  __params+=("$__arg")
            esac
           ;;
      esac
   done

   for __param in "${__params[@]}"; do
      if [[ ! $_FILENAME ]]; then
         _FILENAME=$__param
         continue
      fi
      echo "$__fn: Error: too many parameters: '$__param'"
      return 64
   done

   if [[ $_comment ]]; then
      if [[ $_comment == "@@##@@" ]]; then echo "$__fn: Error: Value COMMENT for option --comment must be specified."; return 64; fi
   fi
   if [[ $_password ]]; then
      if [[ $_password == "@@##@@" ]]; then echo "$__fn: Error: Value PASSWORD for option --password must be specified."; return 64; fi
   fi
   if [[ $_keysize ]]; then
      if [[ $_keysize == "@@##@@" ]]; then echo "$__fn: Error: Value SIZE for option --keysize must be specified."; return 64; fi
      if [[ ! "$_keysize" =~ ^-?[0-9]*$ ]]; then echo "$__fn: Error: Value '$_keysize' for option --keysize is not a numeric value."; return 64; fi
      if [[ $_keysize -lt 1 ]]; then echo "$__fn: Error: Value '$_keysize' for option --keysize is too low. Must be >= 1."; return 64; fi
   fi

   if [[ $_FILENAME ]]; then
      if [[ -e "$_FILENAME" ]]; then echo "$__fn: Error: File '$_FILENAME' for parameter FILENAME already exists."; return 64; fi
   else
      echo "$__fn: Error: Parameter FILENAME must be specified."; return 64
   fi

   if ! hash "ssh-keygen" &>/dev/null; then echo "$__fn: Error: Required command 'ssh-keygen' not found on this system."; return 64; fi

####### ssh-gen-keypair ####### START
[[ $_tracecmd ]] && set -x || true
local opts
# if password is specified and new OpenSSH key format is supported by ssh-keygen, then enable it
if [[ ${_password:-} ]] && ssh-keygen --help 2>&1 | grep -q -- " -o "; then
   opts=-o -a 500
fi
ssh-keygen -t rsa -f $_FILENAME -N "${_password:-}" -b ${_keysize:-4096} -C "${_comment:-}" $opts
[[ $_tracecmd ]] && set +x || true
####### ssh-gen-keypair ####### END
}
function __complete-ssh-gen-keypair() {
   local curr=${COMP_WORDS[COMP_CWORD]}
   if [[ ${curr} == -* ]]; then
      local options=" --comment -C --password -p --keysize --help --tracecmd "
      for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
      COMPREPLY=($(compgen -o default -W '$options' -- $curr))
   else
      COMPREPLY=($(compgen -o default -- $curr))
   fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}ssh-gen-keypair -- ${BASH_FUNK_PREFIX:--}ssh-gen-keypair

function -ssh-pubkey() {
   if [[ "$-" == *x* ]]; then set +x; local opts="set -x"; else local opts=""; fi

   local opt rc __fn=${FUNCNAME[0]}
   for opt in a u H t; do
      [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
   done
   shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
   for opt in nullglob extglob nocasematch nocaseglob; do
      shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
   done

   set +auHtx -o pipefail

   local _ps4=$PS4
   PS4='+\033[90m[$?] $BASH_SOURCE:$LINENO ${FUNCNAME[0]}()\033[0m '
   __impl$__fn "$@" && rc=0 || rc=$?
   PS4=$_ps4

   if [[ $rc == 64 && -t 1 ]]; then
      echo -e "\nUsage: $__fn [OPTION]... PRIVATE_KEY_FILE\n\nType '$__fn --help' for more details."
   fi
   eval $opts
   return $rc
}
function __impl-ssh-pubkey() {
   local __args=() __arg __idx __noMoreFlags __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _tracecmd _PRIVATE_KEY_FILE
   [ -t 1 ] && __interactive=1 || true
         for __arg in "$@"; do
         case "$__arg" in
            --) __noMoreFlags=1; __args+=("--") ;;
            -|--*) __args+=("$__arg") ;;
            -*) [[ $__noMoreFlags == "1" ]] && __args+=("$__arg") || for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
         esac
      done
   for __arg in "${__args[@]}"; do
      if [[ $__optionWithValue == "--" ]]; then
         __params+=("$__arg")
         continue
      fi
      case "$__arg" in

         --help)
            echo "Usage: $__fn [OPTION]... PRIVATE_KEY_FILE"
            echo
            echo "Prints the public key for the given private key."
            echo
            echo "Requirements:"
            echo "  + Command 'ssh-keygen' must be available."
            echo
            echo "Parameters:"
            echo -e "  \033[1mPRIVATE_KEY_FILE\033[22m (required, file)"
            echo "      Private key file."
            echo
            echo "Options:"
            echo -e "\033[1m    --help\033[22m"
            echo "        Prints this help."
            echo -e "\033[1m    --tracecmd\033[22m"
            echo "        Enables bash debug mode (set -x)."
            echo -e "\033[1m    --selftest\033[22m"
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

         --tracecmd) _tracecmd=1 ;;

         --)
            __optionWithValue="--"
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
      if [[ ! $_PRIVATE_KEY_FILE ]]; then
         _PRIVATE_KEY_FILE=$__param
         continue
      fi
      echo "$__fn: Error: too many parameters: '$__param'"
      return 64
   done

   if [[ $_PRIVATE_KEY_FILE ]]; then
      if [[ ! -e "$_PRIVATE_KEY_FILE" ]]; then echo "$__fn: Error: File '$_PRIVATE_KEY_FILE' for parameter PRIVATE_KEY_FILE does not exist."; return 64; fi
      if [[ -e "$_PRIVATE_KEY_FILE" && ! -f "$_PRIVATE_KEY_FILE" ]]; then echo "$__fn: Error: Path '$_PRIVATE_KEY_FILE' for parameter PRIVATE_KEY_FILE is not a file."; return 64; fi
      if [[ ! -r "$_PRIVATE_KEY_FILE" ]]; then echo "$__fn: Error: File '$_PRIVATE_KEY_FILE' for parameter PRIVATE_KEY_FILE is not readable by user '$USER'."; return 64; fi
   else
      echo "$__fn: Error: Parameter PRIVATE_KEY_FILE must be specified."; return 64
   fi

   if ! hash "ssh-keygen" &>/dev/null; then echo "$__fn: Error: Required command 'ssh-keygen' not found on this system."; return 64; fi

####### ssh-pubkey ####### START
[[ $_tracecmd ]] && set -x || true
ssh-keygen -y -f $_PRIVATE_KEY_FILE
[[ $_tracecmd ]] && set +x || true
####### ssh-pubkey ####### END
}
function __complete-ssh-pubkey() {
   local curr=${COMP_WORDS[COMP_CWORD]}
   if [[ ${curr} == -* ]]; then
      local options=" --help --tracecmd "
      for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
      COMPREPLY=($(compgen -o default -W '$options' -- $curr))
   else
      COMPREPLY=($(compgen -o default -- $curr))
   fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}ssh-pubkey -- ${BASH_FUNK_PREFIX:--}ssh-pubkey

function -ssh-reconnect() {
   if [[ "$-" == *x* ]]; then set +x; local opts="set -x"; else local opts=""; fi

   local opt rc __fn=${FUNCNAME[0]}
   for opt in a u H t; do
      [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
   done
   shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
   for opt in nullglob extglob nocasematch nocaseglob; do
      shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
   done

   set +auHtx -o pipefail

   local _ps4=$PS4
   PS4='+\033[90m[$?] $BASH_SOURCE:$LINENO ${FUNCNAME[0]}()\033[0m '
   __impl$__fn "$@" && rc=0 || rc=$?
   PS4=$_ps4

   if [[ $rc == 64 && -t 1 ]]; then
      echo -e "\nUsage: $__fn [OPTION]... [GREP_PATTERN]...\n\nType '$__fn --help' for more details."
   fi
   eval $opts
   return $rc
}
function __impl-ssh-reconnect() {
   local __args=() __arg __idx __noMoreFlags __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _tracecmd _GREP_PATTERN=()
   [ -t 1 ] && __interactive=1 || true
         for __arg in "$@"; do
         case "$__arg" in
            --) __noMoreFlags=1; __args+=("--") ;;
            -|--*) __args+=("$__arg") ;;
            -*) [[ $__noMoreFlags == "1" ]] && __args+=("$__arg") || for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
         esac
      done
   for __arg in "${__args[@]}"; do
      if [[ $__optionWithValue == "--" ]]; then
         __params+=("$__arg")
         continue
      fi
      case "$__arg" in

         --help)
            echo "Usage: $__fn [OPTION]... [GREP_PATTERN]..."
            echo
            echo "Dialog that displays the last 10 issued SSH commands to execute one of them."
            echo
            echo "Parameters:"
            echo -e "  \033[1mGREP_PATTERN\033[22m"
            echo "      Only show SSH commands that contain the given patterns."
            echo
            echo "Options:"
            echo -e "\033[1m    --help\033[22m"
            echo "        Prints this help."
            echo -e "\033[1m    --tracecmd\033[22m"
            echo "        Enables bash debug mode (set -x)."
            echo -e "\033[1m    --selftest\033[22m"
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

         --tracecmd) _tracecmd=1 ;;

         --)
            __optionWithValue="--"
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
      _GREP_PATTERN+=("$__param")
      continue
      echo "$__fn: Error: too many parameters: '$__param'"
      return 64
   done

####### ssh-reconnect ####### START
[[ $_tracecmd ]] && set -x || true
local filter=
if [[ ${_GREP_PATTERN:-} ]]; then
   local p
   for p in "${_GREP_PATTERN[@]}"; do
      filter="$filter | grep \"$p\""
   done
fi
ssh_hist="$(eval -- "${BASH_FUNK_PREFIX:--}tail-reverse "$HISTFILE" -u | grep \"^ssh \" $filter | head -10")"
ssh_hist="${ssh_hist//\"/\\\"}"
local ssh_cmd
echo Please select the SSH command to execute and press [ENTER]. Press [ESC] or [CTRL]+[C] to abort:
echo
eval -- ${BASH_FUNK_PREFIX:--}choose --assign ssh_cmd "\"${ssh_hist//$'\n'/\" \"}\"" || return 1
echo
echo "Press Enter when ready. [CTRL]+[C] to abort."
read -e -p "$ " -i "$ssh_cmd" ssh_cmd
echo -e "Executing command [\033[35m$ssh_cmd\033[0m]..."
history -s -- "$ssh_cmd"
eval -- $ssh_cmd
[[ $_tracecmd ]] && set +x || true
####### ssh-reconnect ####### END
}
function __complete-ssh-reconnect() {
   local curr=${COMP_WORDS[COMP_CWORD]}
   if [[ ${curr} == -* ]]; then
      local options=" --help --tracecmd "
      for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
      COMPREPLY=($(compgen -o default -W '$options' -- $curr))
   else
      COMPREPLY=($(compgen -o default -- $curr))
   fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}ssh-reconnect -- ${BASH_FUNK_PREFIX:--}ssh-reconnect

function -ssh-trust-host() {
   if [[ "$-" == *x* ]]; then set +x; local opts="set -x"; else local opts=""; fi

   local opt rc __fn=${FUNCNAME[0]}
   for opt in a u H t; do
      [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
   done
   shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
   for opt in nullglob extglob nocasematch nocaseglob; do
      shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
   done

   set +auHtx -o pipefail

   local _ps4=$PS4
   PS4='+\033[90m[$?] $BASH_SOURCE:$LINENO ${FUNCNAME[0]}()\033[0m '
   __impl$__fn "$@" && rc=0 || rc=$?
   PS4=$_ps4

   if [[ $rc == 64 && -t 1 ]]; then
      echo -e "\nUsage: $__fn [OPTION]... HOSTNAME [PORT]\n\nType '$__fn --help' for more details."
   fi
   eval $opts
   return $rc
}
function __impl-ssh-trust-host() {
   local __args=() __arg __idx __noMoreFlags __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _tracecmd _HOSTNAME _PORT
   [ -t 1 ] && __interactive=1 || true
         for __arg in "$@"; do
         case "$__arg" in
            --) __noMoreFlags=1; __args+=("--") ;;
            -|--*) __args+=("$__arg") ;;
            -*) [[ $__noMoreFlags == "1" ]] && __args+=("$__arg") || for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
         esac
      done
   for __arg in "${__args[@]}"; do
      if [[ $__optionWithValue == "--" ]]; then
         __params+=("$__arg")
         continue
      fi
      case "$__arg" in

         --help)
            echo "Usage: $__fn [OPTION]... HOSTNAME [PORT]"
            echo
            echo "Adds the public key of the given host to the ~/.ssh/known_hosts file."
            echo
            echo "Requirements:"
            echo "  + Command 'ssh-keyscan' must be available."
            echo
            echo "Parameters:"
            echo -e "  \033[1mHOSTNAME\033[22m (required)"
            echo "      Remote SSH Hostname."
            echo -e "  \033[1mPORT\033[22m (default: '22', integer: 0-65535)"
            echo "      Remote SSH port."
            echo
            echo "Options:"
            echo -e "\033[1m    --help\033[22m"
            echo "        Prints this help."
            echo -e "\033[1m    --tracecmd\033[22m"
            echo "        Enables bash debug mode (set -x)."
            echo -e "\033[1m    --selftest\033[22m"
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

         --tracecmd) _tracecmd=1 ;;

         --)
            __optionWithValue="--"
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
      if [[ ! $_HOSTNAME ]]; then
         _HOSTNAME=$__param
         continue
      fi
      if [[ ! $_PORT ]]; then
         _PORT=$__param
         continue
      fi
      echo "$__fn: Error: too many parameters: '$__param'"
      return 64
   done

   if [[ ! $_PORT ]]; then _PORT="22"; fi

   if [[ $_HOSTNAME ]]; then
      true
   else
      echo "$__fn: Error: Parameter HOSTNAME must be specified."; return 64
   fi
   if [[ $_PORT ]]; then
      if [[ ! "$_PORT" =~ ^-?[0-9]*$ ]]; then echo "$__fn: Error: Value '$_PORT' for parameter PORT is not a numeric value."; return 64; fi
      if [[ $_PORT -lt 0 ]]; then echo "$__fn: Error: Value '$_PORT' for parameter PORT is too low. Must be >= 0."; return 64; fi
      if [[ $_PORT -gt 65535 ]]; then echo "$__fn: Error: Value '$_PORT' for parameter PORT is too high. Must be <= 65535."; return 64; fi
   fi

   if ! hash "ssh-keyscan" &>/dev/null; then echo "$__fn: Error: Required command 'ssh-keyscan' not found on this system."; return 64; fi

####### ssh-trust-host ####### START
[[ $_tracecmd ]] && set -x || true
touch ~/.ssh/known_hosts
ssh-keyscan -t rsa,dsa -p $_PORT $_HOSTNAME 2>/dev/null | sort -u - ~/.ssh/known_hosts > ~/.ssh/known_hosts.tmp
mv ~/.ssh/known_hosts.tmp ~/.ssh/known_hosts
[[ $_tracecmd ]] && set +x || true
####### ssh-trust-host ####### END
}
function __complete-ssh-trust-host() {
   local curr=${COMP_WORDS[COMP_CWORD]}
   if [[ ${curr} == -* ]]; then
      local options=" --help --tracecmd "
      for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
      COMPREPLY=($(compgen -o default -W '$options' -- $curr))
   else
      COMPREPLY=($(compgen -o default -- $curr))
   fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}ssh-trust-host -- ${BASH_FUNK_PREFIX:--}ssh-trust-host

function -ssh-with-pass() {
   if [[ "$-" == *x* ]]; then set +x; local opts="set -x"; else local opts=""; fi

   local opt rc __fn=${FUNCNAME[0]}
   for opt in a u H t; do
      [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
   done
   shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
   for opt in nullglob extglob nocasematch nocaseglob; do
      shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
   done

   set +auHtx -o pipefail

   local _ps4=$PS4
   PS4='+\033[90m[$?] $BASH_SOURCE:$LINENO ${FUNCNAME[0]}()\033[0m '
   __impl$__fn "$@" && rc=0 || rc=$?
   PS4=$_ps4

   if [[ $rc == 64 && -t 1 ]]; then
      echo -e "\nUsage: $__fn [OPTION]... SSH_OPTION1 [SSH_OPTION]...\n\nType '$__fn --help' for more details."
   fi
   eval $opts
   return $rc
}
function __impl-ssh-with-pass() {
   local __args=() __arg __idx __noMoreFlags __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _password _help _selftest _tracecmd _SSH_OPTION=()
   [ -t 1 ] && __interactive=1 || true
         for __arg in "$@"; do
         case "$__arg" in
            --) __noMoreFlags=1; __args+=("--") ;;
            -|--*) __args+=("$__arg") ;;
            -*) [[ $__noMoreFlags == "1" ]] && __args+=("$__arg") || for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
         esac
      done
   for __arg in "${__args[@]}"; do
      if [[ $__optionWithValue == "--" ]]; then
         __params+=("$__arg")
         continue
      fi
      case "$__arg" in

         --help)
            echo "Usage: $__fn [OPTION]... SSH_OPTION1 [SSH_OPTION]..."
            echo
            echo "Executes SSH with non-interactive password-based login. The password must either specified via --password <VALUE> or is read from stdin."
            echo
            echo "Requirements:"
            echo "  + Command 'ssh' must be available."
            echo
            echo "Parameters:"
            echo -e "  \033[1mSSH_OPTION\033[22m (1 or more required)"
            echo "      SSH command line options."
            echo
            echo "Options:"
            echo -e "\033[1m    --password PASSWORD\033[22m"
            echo "        The password to be used."
            echo "    -----------------------------"
            echo -e "\033[1m    --help\033[22m"
            echo "        Prints this help."
            echo -e "\033[1m    --tracecmd\033[22m"
            echo "        Enables bash debug mode (set -x)."
            echo -e "\033[1m    --selftest\033[22m"
            echo "        Performs a self-test."
            echo -e "    \033[1m--\033[22m"
            echo "        Terminates the option list."
            echo
            echo "Examples:"
            echo -e "$ \033[1m ${BASH_FUNK_PREFIX:--}ssh-with-pass --password myPassword user1@myHost whoami\033[22m"
            echo "user1"
            echo -e "$ \033[1m ${BASH_FUNK_PREFIX:--}ssh-with-pass --password myPassword -- user1@myHost -o ServerAliveInterval=5 -o ServerAliveCountMax=1 whoami\033[22m"
            echo "user1"
            echo -e "$ \033[1m echo myPassword | ${BASH_FUNK_PREFIX:--}ssh-with-pass user1@myHost whoami\033[22m"
            echo "user1"
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

         --tracecmd) _tracecmd=1 ;;

         --password)
            _password="@@##@@"
            __optionWithValue=password
         ;;

         --)
            __optionWithValue="--"
           ;;
         -*)
            echo "$__fn: invalid option: '$__arg'"
            return 64
           ;;

         *)
            case $__optionWithValue in
               password)
                  _password=$__arg
                  __optionWithValue=
                 ;;
               *)
                  __params+=("$__arg")
            esac
           ;;
      esac
   done

   for __param in "${__params[@]}"; do
      _SSH_OPTION+=("$__param")
      continue
      echo "$__fn: Error: too many parameters: '$__param'"
      return 64
   done

   if [[ $_password ]]; then
      if [[ $_password == "@@##@@" ]]; then echo "$__fn: Error: Value PASSWORD for option --password must be specified."; return 64; fi
   fi

   if [[ ${#_SSH_OPTION[@]} -lt 1 ]]; then echo "$__fn: Error: For parameter SSH_OPTION at least 1 value must be specified. Found: ${#_SSH_OPTION[@]}."; return 64; fi

   if ! hash "ssh" &>/dev/null; then echo "$__fn: Error: Required command 'ssh' not found on this system."; return 64; fi

####### ssh-with-pass ####### START
[[ $_tracecmd ]] && set -x || true
local askPassPW
if [[ ${_password:-} ]]; then
   askPassPW=$_password
else
   if ! read -s -t 2 askPassPW; then
      echo 'No password provided!'
      return 1
   fi
fi

local askPassFile=~/.ssh-askpass-$(${BASH_FUNK_PREFIX:--}random-string 8 [:alnum:]).sh
echo "#!/usr/bin/env bash
   echo '$askPassPW'
   rm -f $askPassFile >/dev/null
" > $askPassFile
chmod 770 $askPassFile

SSH_ASKPASS=$askPassFile DISPLAY=${DISPLAY:-:0} setsid -w -- ssh ${_SSH_OPTION[@]} </dev/null
[[ $_tracecmd ]] && set +x || true
####### ssh-with-pass ####### END
}
function __complete-ssh-with-pass() {
   local curr=${COMP_WORDS[COMP_CWORD]}
   if [[ ${curr} == -* ]]; then
      local options=" --password --help --tracecmd "
      for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
      COMPREPLY=($(compgen -o default -W '$options' -- $curr))
   else
      COMPREPLY=($(compgen -o default -- $curr))
   fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}ssh-with-pass -- ${BASH_FUNK_PREFIX:--}ssh-with-pass

function -test-all-ssh() {
   if [[ "$-" == *x* ]]; then set +x; local opts="set -x"; else local opts=""; fi

   local opt rc __fn=${FUNCNAME[0]}
   for opt in a u H t; do
      [[ $- =~ $opt ]] && opts="set -$opt; $opts" || opts="set +$opt; $opts"
   done
   shopt -q -o pipefail && opts="set -o pipefail; $opts" || opts="set +o pipefail; $opts"
   for opt in nullglob extglob nocasematch nocaseglob; do
      shopt -q $opt && opts="shopt -s $opt; $opts" || opts="shopt -u $opt; $opts"
   done

   set +auHtx -o pipefail

   local _ps4=$PS4
   PS4='+\033[90m[$?] $BASH_SOURCE:$LINENO ${FUNCNAME[0]}()\033[0m '
   __impl$__fn "$@" && rc=0 || rc=$?
   PS4=$_ps4

   if [[ $rc == 64 && -t 1 ]]; then
      echo -e "\nUsage: $__fn [OPTION]...\n\nType '$__fn --help' for more details."
   fi
   eval $opts
   return $rc
}
function __impl-test-all-ssh() {
   local __args=() __arg __idx __noMoreFlags __optionWithValue __params=() __interactive __fn=${FUNCNAME[0]/__impl/} _help _selftest _tracecmd
   [ -t 1 ] && __interactive=1 || true
         for __arg in "$@"; do
         case "$__arg" in
            --) __noMoreFlags=1; __args+=("--") ;;
            -|--*) __args+=("$__arg") ;;
            -*) [[ $__noMoreFlags == "1" ]] && __args+=("$__arg") || for ((__idx=1; __idx<${#__arg}; __idx++)); do __args+=("-${__arg:$__idx:1}"); done ;;
            *) __args+=("$__arg") ;;
         esac
      done
   for __arg in "${__args[@]}"; do
      if [[ $__optionWithValue == "--" ]]; then
         __params+=("$__arg")
         continue
      fi
      case "$__arg" in

         --help)
            echo "Usage: $__fn [OPTION]..."
            echo
            echo "Performs a selftest of all functions of this module by executing each function with option '--selftest'."
            echo
            echo "Options:"
            echo -e "\033[1m    --help\033[22m"
            echo "        Prints this help."
            echo -e "\033[1m    --tracecmd\033[22m"
            echo "        Enables bash debug mode (set -x)."
            echo -e "\033[1m    --selftest\033[22m"
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

         --tracecmd) _tracecmd=1 ;;

         --)
            __optionWithValue="--"
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

####### test-all-ssh ####### START
[[ $_tracecmd ]] && set -x || true
${BASH_FUNK_PREFIX:--}ssh-agent-add-key --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}ssh-gen-keypair --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}ssh-pubkey --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}ssh-reconnect --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}ssh-trust-host --selftest && echo || return 1
${BASH_FUNK_PREFIX:--}ssh-with-pass --selftest && echo || return 1
[[ $_tracecmd ]] && set +x || true
####### test-all-ssh ####### END
}
function __complete-test-all-ssh() {
   local curr=${COMP_WORDS[COMP_CWORD]}
   if [[ ${curr} == -* ]]; then
      local options=" --help --tracecmd "
      for o in "${COMP_WORDS[@]}"; do options=${options/ $o / }; done
      COMPREPLY=($(compgen -o default -W '$options' -- $curr))
   else
      COMPREPLY=($(compgen -o default -- $curr))
   fi
}
complete -F __complete${BASH_FUNK_PREFIX:--}test-all-ssh -- ${BASH_FUNK_PREFIX:--}test-all-ssh


function -help-ssh() {
   local p="\033[1m${BASH_FUNK_PREFIX:--}"
   echo -e "${p}ssh-agent-add-key KEY_FILE PASSWORD\033[0m  -  Adds the private key to the ssh-agent."
   echo -e "${p}ssh-gen-keypair FILENAME\033[0m  -  Creates an private/public SSH keypair."
   echo -e "${p}ssh-pubkey PRIVATE_KEY_FILE\033[0m  -  Prints the public key for the given private key."
   echo -e "${p}ssh-reconnect [GREP_PATTERN]...\033[0m  -  Dialog that displays the last 10 issued SSH commands to execute one of them."
   echo -e "${p}ssh-trust-host HOSTNAME [PORT]\033[0m  -  Adds the public key of the given host to the ~/.ssh/known_hosts file."
   echo -e "${p}ssh-with-pass SSH_OPTION1 [SSH_OPTION]...\033[0m  -  Executes SSH with non-interactive password-based login. The password must either specified via --password <VALUE> or is read from stdin."
   echo -e "${p}test-all-ssh\033[0m  -  Performs a selftest of all functions of this module by executing each function with option '--selftest'."
}
__BASH_FUNK_FUNCS+=( ssh-agent-add-key ssh-gen-keypair ssh-pubkey ssh-reconnect ssh-trust-host ssh-with-pass test-all-ssh )
