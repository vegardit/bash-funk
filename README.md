# bash-funk - Spice up your Bash!

1. [What is it?](#what-is-it)
1. [Installation](#install)
1. [Usage](#usage)
1. [License](#license)


## <a name="what-is-it"></a>What is it?

bash-funk is a collection of useful Bash functions for everyday use.

See the markdown files of the different [Bash modules](https://github.com/vegardit/bash-funk/tree/master/modules) for detailed information about the provided functions.


## <a name="install"></a>Installation

###  Using Git

check-out the master branch
```
$ git clone https://github.com/vegardit/bash-funk --branch master --single-branch ~/bash-funk
```


###  Using Subversion

check-out the trunk
```
$ svn checkout https://github.com/vegardit/bash-funk/trunk ~/bash-funk
```


## <a name="usage"></a>Usage

Once bash-funk is installed, it can be used by sourcing the `bash-funk.sh` script which will then load all modules.

```
$ source ~/bash-funk/bash-funk.sh
```

All bash-funk functions are prefixed with a `-` by default and support the `--help` option.

Bash completion for options is supported by all functions too, simply type a dash (-) and hit the [TAB] key twice.

The following environment variables can be set before bash-funk is loaded to customize it's behaviour:

- `BASH_FUNK_PREFIX` - if specified, the names of all bash-funk functions will be prefixed with this value. Must only contain alphanumeric characters `a-z`, `A-Z`, `0-9`) and underscore `_`.
- `BASH_FUNK_PROMPT` - if set to anything else than `"yes"` bash-funk will not install it's Bash prompt function.
- `BASH_FUNK_DIRS_COLOR` - ANSI color code to be used by the bash prompt to highlight directories, default is `94` which will be transformed to `\e[94m`


## <a name="license"></a>License

All files are released under the [Apache License 2.0](https://github.com/vegardit/bash-funk/blob/master/LICENSE.txt).
