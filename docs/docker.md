# Bash-Funk "docker" module

[//]: # (THIS FILE IS GENERATED BY BASH-FUNK GENERATOR)

This module contains functions related to docker. It only loads if docker is installed.

The following statements are automatically executed when this module loads:

```bash
function -docker-slim() {
   # https://github.com/docker-slim/docker-slim
   if [ $# -eq 0 ]; then
      sudo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim help
   else
      sudo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim "$@"
    fi
}
```

The following commands are available when this module is loaded:

1. [-docker-log](#-docker-log)
1. [-docker-sh](#-docker-sh)
1. [-docker-top](#-docker-top)
1. [-swarm-cluster-id](#-swarm-cluster-id)
1. [-test-docker](#-test-docker)


## <a name="license"></a>License

```
Copyright 2015-2020 by Vegard IT GmbH (https://vegardit.com)
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


## <a name="-docker-log"></a>-docker-log

```
Usage: -docker-log [OPTION]...

Displays dockerd's log messages in realtime.

Options:
    --help 
        Prints this help.
    --selftest 
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
sudo journalctl -u docker.service -f -n20
```


## <a name="-docker-sh"></a>-docker-sh

```
Usage: -docker-sh [OPTION]...

Displays a list of all running containers and starts an interactive shell (/bin/sh) for the selected one.

Options:
-u, --user USER 
        Login user.
    -----------------------------
    --help 
        Prints this help.
    --selftest 
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
local containers=$(docker container ls --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.ID}}' | sort)
echo "   $containers" | head -1
local selection
eval -- "-choose --assign selection $(echo "$containers" | tail +2 | while read line; do printf "%s" "'$line' "; done)" || return 1
echo "Entering [$(-substr-before "$selection" " ")]..."
if [[ $_user ]]; then
    sudo docker exec -u $_user -it $(-substr-after-last "$selection" " ") /bin/sh
else
    sudo docker exec -it $(-substr-after-last "$selection" " ") /bin/sh
fi
```


## <a name="-docker-top"></a>-docker-top

```
Usage: -docker-top [OPTION]...

Starts Dockly (https://lirantal.github.io/dockly/).

Options:
    --help 
        Prints this help.
    --selftest 
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
sudo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly
```


## <a name="-swarm-cluster-id"></a>-swarm-cluster-id

```
Usage: -swarm-cluster-id [OPTION]...

Prints the Swarm cluster ID.

Options:
    --help 
        Prints this help.
    --selftest 
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
sudo docker info 2>/dev/null | grep --color=never -oP '(?<=ClusterID: ).*'
```


## <a name="-test-docker"></a>-test-docker

```
Usage: -test-docker [OPTION]...

Performs a selftest of all functions of this module by executing each function with option '--selftest'.

Options:
    --help 
        Prints this help.
    --selftest 
        Performs a self-test.
    --
        Terminates the option list.
```

*Implementation:*
```bash
-docker-log --selftest && echo || return 1
-docker-sh --selftest && echo || return 1
-docker-top --selftest && echo || return 1
-swarm-cluster-id --selftest && echo || return 1
```