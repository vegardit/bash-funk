# Bash-Funk "ssh" module

[//]: # (THIS FILE IS GENERATED BY BASH-FUNK GENERATOR)

The following commands are available when this module is loaded:

1. [-ssh-agent-add-key](#-ssh-agent-add-key)
1. [-ssh-gen-keypair](#-ssh-gen-keypair)
1. [-ssh-pubkey](#-ssh-pubkey)
1. [-ssh-reconnect](#-ssh-reconnect)
1. [-ssh-trust-host](#-ssh-trust-host)
1. [-ssh-with-pass](#-ssh-with-pass)
1. [-test-all-ssh](#-test-all-ssh)


## <a name="license"></a>License

```
SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com)
SPDX-License-Identifier: Apache-2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```


## <a name="-ssh-agent-add-key"></a>-ssh-agent-add-key

```
Usage: -ssh-agent-add-key [OPTION]... KEY_FILE PASSWORD

Adds the private key to the ssh-agent.

Requirements:
  + Command 'ssh-add' must be available.
  + Command 'ssh-agent' must be available.
  + Command 'expect' must be available.

Parameters:
  KEY_FILE (required, file)
      Path to the key file.
  PASSWORD (required)
      Password to open the key file.

Options:
    --help
        Prints this help.
    --tracecmd
        Enables bash debug mode (set -x).
    --selftest
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
eval $(ssh-agent)

expect << EOF
   spawn ssh-add $_KEY_FILE
   expect "Enter passphrase"
   send "$_PASSWORD\r"
   expect eof
EOF
```


## <a name="-ssh-gen-keypair"></a>-ssh-gen-keypair

```
Usage: -ssh-gen-keypair [OPTION]... FILENAME

Creates an private/public SSH keypair.

Requirements:
  + Command 'ssh-keygen' must be available.

Parameters:
  FILENAME (required, file)
      Private key filename.

Options:
-C, --comment COMMENT
        Comment.
    --keysize SIZE (integer: 1-?)
        Number of bits of the private key. Default is 4096.
-p, --password PASSWORD
        Password to protect the private key file.
    -----------------------------
    --help
        Prints this help.
    --tracecmd
        Enables bash debug mode (set -x).
    --selftest
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
local opts
# if password is specified and new OpenSSH key format is supported by ssh-keygen, then enable it
if [[ ${_password:-} ]] && ssh-keygen --help 2>&1 | grep -q -- " -o "; then
   opts=-o -a 500
fi
ssh-keygen -t rsa -f $_FILENAME -N "${_password:-}" -b ${_keysize:-4096} -C "${_comment:-}" $opts
```


## <a name="-ssh-pubkey"></a>-ssh-pubkey

```
Usage: -ssh-pubkey [OPTION]... PRIVATE_KEY_FILE

Prints the public key for the given private key.

Requirements:
  + Command 'ssh-keygen' must be available.

Parameters:
  PRIVATE_KEY_FILE (required, file)
      Private key file.

Options:
    --help
        Prints this help.
    --tracecmd
        Enables bash debug mode (set -x).
    --selftest
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
ssh-keygen -y -f $_PRIVATE_KEY_FILE
```


## <a name="-ssh-reconnect"></a>-ssh-reconnect

```
Usage: -ssh-reconnect [OPTION]... [GREP_PATTERN]...

Dialog that displays the last 10 issued SSH commands to execute one of them.

Parameters:
  GREP_PATTERN
      Only show SSH commands that contain the given patterns.

Options:
    --help
        Prints this help.
    --tracecmd
        Enables bash debug mode (set -x).
    --selftest
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
local filter=
if [[ ${_GREP_PATTERN:-} ]]; then
   local p
   for p in "${_GREP_PATTERN[@]}"; do
      filter="$filter | grep \"$p\""
   done
fi
ssh_hist="$(eval -- "-tail-reverse "$HISTFILE" -u | grep \"^ssh \" $filter | head -10")"
ssh_hist="${ssh_hist//\"/\\\"}"
local ssh_cmd
echo Please select the SSH command to execute and press [ENTER]. Press [ESC] or [CTRL]+[C] to abort:
echo
eval -- -choose --assign ssh_cmd "\"${ssh_hist//$'\n'/\" \"}\"" || return 1
echo
echo "Press Enter when ready. [CTRL]+[C] to abort."
read -e -p "$ " -i "$ssh_cmd" ssh_cmd
echo -e "Executing command [\033[35m$ssh_cmd\033[0m]..."
history -s -- "$ssh_cmd"
eval -- $ssh_cmd
```


## <a name="-ssh-trust-host"></a>-ssh-trust-host

```
Usage: -ssh-trust-host [OPTION]... HOSTNAME [PORT]

Adds the public key of the given host to the ~/.ssh/known_hosts file.

Requirements:
  + Command 'ssh-keyscan' must be available.

Parameters:
  HOSTNAME (required)
      Remote SSH Hostname.
  PORT (default: '22', integer: 0-65535)
      Remote SSH port.

Options:
    --help
        Prints this help.
    --tracecmd
        Enables bash debug mode (set -x).
    --selftest
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
touch ~/.ssh/known_hosts
ssh-keyscan -t rsa,dsa -p $_PORT $_HOSTNAME 2>/dev/null | sort -u - ~/.ssh/known_hosts > ~/.ssh/known_hosts.tmp
mv ~/.ssh/known_hosts.tmp ~/.ssh/known_hosts
```


## <a name="-ssh-with-pass"></a>-ssh-with-pass

```
Usage: -ssh-with-pass [OPTION]... SSH_OPTION1 [SSH_OPTION]...

Executes SSH with non-interactive password-based login. The password must either specified via --password <VALUE> or is read from stdin.

Requirements:
  + Command 'ssh' must be available.

Parameters:
  SSH_OPTION (1 or more required)
      SSH command line options.

Options:
    --password PASSWORD
        The password to be used.
    -----------------------------
    --help
        Prints this help.
    --tracecmd
        Enables bash debug mode (set -x).
    --selftest
        Performs a self-test.
    --
        Terminates the option list.

Examples:
$  -ssh-with-pass --password myPassword user1@myHost whoami
user1
$  -ssh-with-pass --password myPassword -- user1@myHost -o ServerAliveInterval=5 -o ServerAliveCountMax=1 whoami
user1
$  echo myPassword | -ssh-with-pass user1@myHost whoami
user1
```

*Implementation:*
```bash
local askPassPW
if [[ ${_password:-} ]]; then
   askPassPW=$_password
else
   if ! read -s -t 2 askPassPW; then
      echo 'No password provided!'
      return 1
   fi
fi

local askPassFile=~/.ssh-askpass-$(-random-string 8 [:alnum:]).sh
echo "#!/usr/bin/env bash
   echo '$askPassPW'
   rm -f $askPassFile >/dev/null
" > $askPassFile
chmod 770 $askPassFile

SSH_ASKPASS=$askPassFile DISPLAY=${DISPLAY:-:0} setsid -w -- ssh ${_SSH_OPTION[@]} </dev/null
```


## <a name="-test-all-ssh"></a>-test-all-ssh

```
Usage: -test-all-ssh [OPTION]...

Performs a selftest of all functions of this module by executing each function with option '--selftest'.

Options:
    --help
        Prints this help.
    --tracecmd
        Enables bash debug mode (set -x).
    --selftest
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
-ssh-agent-add-key --selftest && echo || return 1
-ssh-gen-keypair --selftest && echo || return 1
-ssh-pubkey --selftest && echo || return 1
-ssh-reconnect --selftest && echo || return 1
-ssh-trust-host --selftest && echo || return 1
-ssh-with-pass --selftest && echo || return 1
```
