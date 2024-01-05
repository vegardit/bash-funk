#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com)
# SPDX-License-Identifier: Apache-2.0
#
# @author Patrick Spielmann, Vegard IT GmbH
# @author Sebastian Thomschke, Vegard IT GmbH
#

if ! (return 0 2>/dev/null); then # https://stackoverflow.com/a/28776166/5116073
   echo "The bash-funk script must be sourced"'!'" See the 'source' command."
   false
else
   if [[ $- != *i* ]]; then
      # if non-interactive suppress stdout during bash-funk initialization
      exec 8>&1 >/dev/null
   fi

   if [[ -e ~/.bash_funk_rc ]]; then
      echo "Sourcing [~/.bash_funk_rc]..."
      source ~/.bash_funk_rc
   else
      cat >~/.bash_funk_rc <<EOL
# Uncomment the settings you want to change:
#BASH_FUNK_PREFIX=-              # if specified, the names of all bash-funk commands will be prefixed with this value. Must only contain alphanumeric characters a-z, A-Z, 0-9) and underscore _.
#BASH_FUNK_DIRS_COLOR=94         # ANSI color code to be used by the bash prompt to highlight directories, default is 94 which will be transformed to \e[94m
#BASH_FUNK_NO_EXPORT_FUNCTIONS=1 # if set bash-funk commands are not exported to sub-shells, thus will not be available in your own shell scripts.
#BASH_FUNK_NO_TWEAK_BASH=1       # if set to any value bash-funk will not automatically invoke the -tweak-bash command when loading.

# Bash prompt customizations:
#BASH_FUNK_NO_PROMPT=1           # if set to any value bash-funk will not install it's Bash prompt function.
#BASH_FUNK_PROMPT_PREFIX=        # text that shall be shown at the beginning of the Bash prompt, e.g. a stage identifier (DEV/TEST/PROD)
#BASH_FUNK_PROMPT_DATE="\d \t"   # prompt escape sequence for the date section, default is "\t", which displays current time. See http://tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
#BASH_FUNK_PROMPT_NO_JOBS=1      # if set to any value the Bash prompt will not display the number of shell jobs.
#BASH_FUNK_PROMPT_NO_SCREENS=1   # if set to any value the Bash prompt will not display the number of detached screens
#BASH_FUNK_PROMPT_NO_TTY=1       # if set to any value the Bash prompt will not display the current tty.
#BASH_FUNK_PROMPT_NO_KUBECTL=1   # if set to any value the Bash prompt will not display kubectl's current context
#BASH_FUNK_PROMPT_NO_GIT=1       # if set to any value the Bash prompt will not display GIT branch and modification information.
#BASH_FUNK_PROMPT_NO_SVN=1       # if set to any value the Bash prompt will not display SVN branch and modification information.
#BASH_FUNK_PROMPT_DIRENV_TRUSTED_DIRS=() # Bash array of directory paths where found .bash_funk_auto_rc files automatically executed.

# other user settings below here

EOL
   fi

   # not using a-zA-Z in regex as this seems to match German umlaute too
   if ! [[ ${BASH_FUNK_PREFIX:-} =~ ^[0-9abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]*$ ]]; then
      echo "The variable BASH_FUNK_PREFIX may only contain ASCII alphanumeric characters (a-z, A-Z, 0-9), dash (-) and underscore (_)"
   else

      case "$OSTYPE" in
         cygwin|msys) BASH_FUNK_ROOT="$(cygpath ${BASH_SOURCE[0]})" ;;
         *)           BASH_FUNK_ROOT="${BASH_SOURCE[0]}" ;;
      esac

      case "${BASH_FUNK_ROOT}" in
         /*) BASH_FUNK_ROOT="${BASH_FUNK_ROOT%/*}" ;;
         */*)BASH_FUNK_ROOT="$PWD/${BASH_FUNK_ROOT%/*}" ;;
         *)  BASH_FUNK_ROOT="$PWD" ;;
      esac
      export BASH_FUNK_ROOT

      if [[ -d ${BASH_FUNK_ROOT}/.git ]]; then
         __BASH_FUNK_VERSION=$(cd ${BASH_FUNK_ROOT}/.git && git log -1 --format=%ci 2>/dev/null || true)
      elif [[ -d ${BASH_FUNK_ROOT}/.svn ]]; then
         __BASH_FUNK_VERSION=$(svn info "${BASH_FUNK_ROOT}" 2>/dev/null || true)
         if [[ $__BASH_FUNK_VERSION ]]; then
            __BASH_FUNK_VERSION="${__BASH_FUNK_VERSION#*$'\n'Last Changed Date: }" # substring after 'Last Changed Date: '
            __BASH_FUNK_VERSION="${__BASH_FUNK_VERSION%% (*}"                  # substring before ' ('
         fi
      else
         __BASH_FUNK_VERSION=
      fi

      # if no SCM was used, we assume installation via curl/wget, thus we take the last modification date of the oldest file
      if [[ ! $__BASH_FUNK_VERSION ]]; then
         __BASH_FUNK_VERSION=$(find ${BASH_FUNK_ROOT} -not -path '*/\.*' -type f -printf "%TY.%Tm.%Td %TT %TZ\n" | sort | head -n 1)
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
      echo "                     github.com/vegardit/bash-funk"
      echo

      echo "Local Version: $__BASH_FUNK_VERSION"
      echo

      if ! declare -p BASH_FUNK_PREFIX &>/dev/null; then
         BASH_FUNK_PREFIX=-
      fi
      export BASH_FUNK_PREFIX

      __BASH_FUNK_FUNCS=()

      # defining some aliases before loading modules to be used by them https://askubuntu.com/questions/1123186/how-can-i-use-an-alias-in-a-function
      if [[ $OSTYPE == "cygwin" || $OSTYPE == "msys" || $OSTYPE == "darwin"* ]]; then
         shopt -s expand_aliases

         # prevent: find: The environment is too large for exec()
         alias -- find='env -i HOME="$HOME" LC_CTYPE="${LC_ALL:-${LC_CTYPE:-$LANG}}" PATH="$PATH" TERM="${TERM:-}" USER="$USER" find'

         # prevent: xargs: environment is too large for exec
         alias -- xargs='env -i HOME="$HOME" LC_CTYPE="${LC_ALL:-${LC_CTYPE:-$LANG}}" PATH="$PATH" TERM="${TERM:-}" USER="$USER" xargs'
      fi

      # load all modules
      for __module in "${BASH_FUNK_ROOT}"/modules/*.sh; do
         # don't load the test module automatically
         if [[ $__module == *test.sh ]]; then
            continue;
         fi

         echo -en "\033[K" # clear current line
         echo -n "* Loading [modules/${__module##*/}]... "
         # rename the functions based on the given BASH_FUNK_PREFIX
         if [[ $BASH_FUNK_PREFIX == "-" ]]; then
            source "${__module}"
         else
            eval "$(sed -E "s/function -/function ${BASH_FUNK_PREFIX}/g; s/function __([^-]*)-/function __\1${BASH_FUNK_PREFIX}/g" ${__module})"
         fi
         echo -en "\n\033[1A" # cursor up
      done
      unset __module
      echo "* Finished loading applicable modules."

      # export all functions
      if [[ ! ${BASH_FUNK_NO_EXPORT_FUNCTIONS:-} ]]; then
         echo "* Exporting functions..."
         for __fname in ${__BASH_FUNK_FUNCS[@]}; do
            export -f -- ${BASH_FUNK_PREFIX}${__fname}
            export -f -- __impl${BASH_FUNK_PREFIX}${__fname}
         done
         unset __fname __fnames
      fi

      if [[ ! ${BASH_FUNK_NO_TWEAK_BASH:-} ]] && declare -F -- ${BASH_FUNK_PREFIX}tweak-bash &>/dev/null; then
         echo "* Executing command '${BASH_FUNK_PREFIX}tweak-bash'..."
         ${BASH_FUNK_PREFIX}tweak-bash
      fi

      if [[ $- == *i* ]] && [[ ! ${BASH_FUNK_NO_PROMPT:-} ]]; then
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

   if [[ $- == *i* ]]; then
      echo
      echo "You are ready to go. Enjoy"'!'

      # show information about detached screens
      if [[ -z $STY && -z $TMUX ]]; then
         if hash screen &>/dev/null; then
            __screens=$(screen -list | grep "etached)" | sort | sed -En "s/\s+(.*)\s+.*/  screen -r \1/p")
         fi
         if hash tmux &>/dev/null; then
            # https://github.com/tmux/tmux/wiki/Formats#summary-of-modifiers
            [[ -z $__screens ]] || __screens+="\n"
            __screens+=$(tmux list-sessions -f "#{==:#{session_attached},0}" -F "  tmux attach-session -t #{session_name}" 2>/dev/null)
         fi

         if [[ -n $__screens ]]; then
            echo
            echo "The following detached sessions have been detected:"

            if [[ $TERM == "cygwin" ]]; then
               echo -e "\033[1m\033[30m${__screens}\033[0m"
            else
               echo -e "\033[93m${__screens}\033[0m"
            fi
         fi
         unset __screens
      fi
   else
      # restoring stdout handle
      exec 1>&8
   fi
fi
