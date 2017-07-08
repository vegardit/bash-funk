# bash-funk - Spice up your Bash!

1. [What is it?](#what-is-it)
1. [Installation](#install)
    1. [Using git](#install-with-git)
    1. [Using subversion](#install-with-svn)
    1. [Using curl](#install-with-curl)
    1. [Using wget](#install-with-wget)
    1. [Portable on Windows](#install-win-portable)
1. [Usage](#usage)
1. [Updating](#update)
1. [License](#license)


## <a name="what-is-it"></a>What is it?

bash-funk is a collection of useful commands for Bash 3.2 or higher.

See the markdown files of the different [Bash modules](https://github.com/vegardit/bash-funk/tree/master/modules) for detailed information about the provided commands.

An adaptive bash prompt is provided too:

![console](docs/img/console.png)

All bash-funk commands have a descriptive online help:

![function_help](docs/img/function_help.png)

The command [-help](https://github.com/vegardit/bash-funk/blob/master/modules/misc.md#-help) shows a list of all available commands

![help](docs/img/help.png)


## <a name="install"></a>Installation

### <a name="install-with-git"></a>Using Git

Execute:
```bash
git clone https://github.com/vegardit/bash-funk --branch master --single-branch ~/bash-funk
```

### <a name="install-with-svn"></a>Using Subversion

Execute:
```bash
svn checkout https://github.com/vegardit/bash-funk/trunk ~/bash-funk
```

### <a name="install-with-curl"></a>Using Curl

Execute:
```bash
mkdir ~/bash-funk && \
cd ~/bash-funk && \
curl -#L https://github.com/vegardit/bash-funk/tarball/master | tar -xzv --strip-components 1
```

### <a name="install-with-wget"></a>Using wget

Execute:
```bash
mkdir ~/bash-funk && \
cd ~/bash-funk && \
wget -qO- --show-progress https://github.com/vegardit/bash-funk/tarball/master | tar -xzv --strip-components 1
```

### <a name="install-win-portable"></a>Portable on Windows

For your convenience we created a simple bootstrap Windows batch file that sets up a portable [Cygwin](http://cygwin.org) installation pre-configured with bash-funk.

For more details see https://github.com/vegardit/cygwin-portable-installer#install.


## <a name="usage"></a>Usage

Once bash-funk is installed, it can be used by sourcing the `bash-funk.sh` script which will then load all modules.

```bash
$ source ~/bash-funk/bash-funk.sh
```

All bash-funk commands are prefixed with a `-` by default and support the `--help` option.

Bash completion for options is supported by all commands too, simply type a dash (-) and hit the [TAB] key twice.

### Customization

The following environment variables can be set in `~/.bash_funk_rc` to customize bash-funk's behavior. This file will be sourced automatically.

- `BASH_FUNK_PREFIX` - if specified, the names of all bash-funk commands will be prefixed with this value. Must only contain alphanumeric characters `a-z`, `A-Z`, `0-9`) and underscore `_`.
- `BASH_FUNK_DIRS_COLOR` - ANSI color code to be used by the bash prompt to highlight directories, default is `94` which will be transformed to `\e[94m`
- `BASH_FUNK_NO_TWEAK_BASH`     - if set to any value bash-funk will not automatically invoke the [-tweak-bash](https://github.com/vegardit/bash-funk/blob/master/modules/misc.md#-tweak-bash) command when loading.
- `BASH_FUNK_NO_PROMPT`         - if set to any value bash-funk will not install it's Bash prompt function.
- `BASH_FUNK_PROMPT_PREFIX`     - text that shall be shown at the beginning of the Bash prompt, e.g. a stage identifier (DEV/TEST/PROD)
- `BASH_FUNK_PROMPT_DATE`       - prompt escape sequence for the date section, default is "\t", which displays current time. See http://tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html
- `BASH_FUNK_PROMPT_NO_GIT`     - if set to any value the Bash prompt will not display GIT branch and modification information.
- `BASH_FUNK_PROMPT_NO_JOBS`    - if set to any value the Bash prompt will not display the number of shell jobs.
- `BASH_FUNK_PROMPT_NO_SCREENS` - if set to any value the Bash prompt will not display the number of detached screens
- `BASH_FUNK_PROMPT_NO_SVN`     - if set to any value the Bash prompt will not display SVN branch and modification information.- `BASH_FUNK_NO_PROMPT_TTY`    - if set to any value the Bash prompt will not display the current tty.

### Using bash-funk modules separately

All bash-funk modules are self-containing. This means, if you are only interested in the commands provided by one module, you can also directly source that particular module located in the `modules` folder and do not use the `bash-funk.sh` loader script.


## <a name="update"></a>Updating

Once loaded, you can easily update your bash-funk installation to the latest code base by using the [-update](https://github.com/vegardit/bash-funk/blob/master/modules/misc.md#-update) command:

```bash
-update -yr
```

or:

```bash
-update --yes --reload
```


## <a name="license"></a>License

All files are released under the [Apache License 2.0](https://github.com/vegardit/bash-funk/blob/master/LICENSE.txt).
