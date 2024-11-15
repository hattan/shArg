![CI](https://github.com/hattan/shArg/workflows/CI/badge.svg)

# shArg
argument parsing library for .sh files. 

## Dependencies

Bash 4 or greater.

If running on MacOs, please ensure you are using a newer version of bash.

To find the bash version you have installed `bash --version`

To upgrade bash on MacOs `brew install bash`

## Simple Example:

```shell
# load shArg
source shArg.sh

declare MESSAGE
declare DEBUG

# register arguments
shArgs.arg "MESSAGE" -m --message
shArgs.arg "DEBUG" -d --debug

# parse inputs
shArgs.parse "$@"

echo "The message is $MESSAGE"

if [ "$DEBUG" == true ]; then
  echo "DEBUG is true!"
else
  echo "DEBUG is false"
fi

# Run from the command line via
# ./example.sh -m "TEST" -d
# ./example.sh --message "hello" -d
```

## Getting Started

* include shArg.sh in your project:
  * Option 1) Copy [shArg.sh](scripts/shArg.sh) to your project. 
  * Option 2) Easy install - run the following from a bash shell 
  
    `curl -L https://raw.githubusercontent.com/hattan/shArg/main/scripts/setup.sh | bash`

    This creates a folder called .sh_arg and downloads shArg to the path .sh_arg/shArg.sh. You can include in your scripts via `source .sh_arg/shArgs.sh`

* source shArg in your bash script.
  ```source shArg.sh```
* Register arguments
  ```shArgs.arg "<key: string>" "<short flag name: -string>" "<long flag name: --string>" "<type: PARAMETER | FLAG>"```

  example: ```shArgs.arg "MESSAGE" -m --message```

* Parse inputs: ```shArgs.parse "$@"```

* By default arguments are auto exported and will be accessible via global variables.

* If not auto exported (default) then you can explicitly read the values using either of these mechanisms:

  * using shArg.val

      ``` declare message=`shArgs.val "MESSAGE"` ```
      ``` echo $message ```

  * using the _SH_ARGUMENTS array
      ``` echo "MESSAGE = ${_SH_ARGUMENTS["MESSAGE"]}" ```

* Checkout the [guided walk through](GETTING_STARTED.md) on setting up shArg.

## Simple walk through

Please see the following [guided walk through](GETTING_STARTED.md) on setting up shArg.


## Parameter Types

shArg has two main input types; PARAMETER and FLAG. 

* PARAMETER:

  A parameter is defined as an input that has an associated value.

  For example: 

  ```shell
  # arg
  shArgs.arg "MESSAGE" -m --message PARAMETER true

  # invoke with
  ./myscript.sh --message "hello world"
  ```

  hello world is the value specified for the message parameter.

  Parameters can be a single value or a comma separated value (csv.) You can pass a csv in and it will be automatically converted to a bash array.

  ```shell
  #arg 
  shArgs.arg "IPS" -i --ips PARAMETER true 

  # invoke with
  ./list.sh -i 1.1.1.1,2.2.2.2
  ```

  ***Note:*** For csv inputs, please ensure that there is no space between elements and associated commas. This applies even with quoted inputs.

  ```shell
  # This will work
  ./list.sh -i 1.1.1.1,2.2.2.2

  # This will not work
  ./list.sh -i 1.1.1.1, 2.2.2.2

  # This will not work, even with quotes
  ./list.sh -i "1.1.1.1, 2.2.2.2"
  ```

* FLAG:
  shArg also supports FLAG, which is a boolean input that does not require a value.

  For example:

  ```shell
  # arg 
  shArgs.arg "DEBUG" -d --debug FLAG true

  # invoke with
  ./myscript.sh --debug
  ```

  In this case including --debug when calling the script will set the DEBUG variable to true. Omitting it, sets DEBUG to false. There isn't a need to pass a value after debug.

## Assigning values with equals sign

shArg supports two methods for accepting input for parameters.

* Space separated: -key value  e.g. `-m hello world`
* Equals separated: -key=value e.g. `-m=hello world`

Both parameter input methods behave in a similar manner and provide the flexibility to use either depending on project requirements. You can even mix and match! e.g. `-m=hello world -u user1`

## shArgs.arg reference

shArgs.arg is the method used to register command line parameters or flags.

  ```shArgs.arg "<key> <short name> <long name> <type> <auto export>"```

|parameter| descriptions| example|
|----------|-------------|--------|
| key | unique name for your variable. Note if auto export is true ,then this is the variable name that will set in the global scope| "MESSAGE"|
| short name | the short command line flag and should start with one single dash.| -m
| long name | the long version command line flag and should start with two dashes | --messages
|type| either PARAMETER (for inputs with values) or FLAG (for boolean inputs which do not require a value) | -d
|auto export| either true or false . If true, then the key is exported to the global scope as a variable with the input value.| true|
|hook method name| Name of a method to invoke when the argument is found (see hooks section below)| "hookMethod"

## Hook methods

shArg supports hook functions, which are bash functions that get invoked when the parse method finds an input that matches an argument. Hook method bindings are useful for setting other values or side effects when an input is found.

example:

```shell

source ../scripts/shArg.sh

declare AZURE_DEVOPS_ORG
declare AZURE_DEVOPS_URL

orgHook() {
  local org=$1

  # Build url from bound value
  AZURE_DEVOPS_URL="https://dev.azure.com/$org"

  echo "Azure DevOps Url      : $AZURE_DEVOPS_URL"
  echo "Azure DevOps Org Name : $AZURE_DEVOPS_ORG"

}

# register arguments
shArgs.arg "AZURE_DEVOPS_ORG" -o --orgName PARAMETER true orgHook

# parse inputs
shArgs.parse "$@"


```

## Unknown arguments

Passing in an unknown argument will result in a warning that will notify the user that the supplied command line argument is unknown and not handled.

To disable warnings set the following environment variable to true `SHARG_DISABLE_WARNINGS=true`

## Running the tests

* Install [ShellSpec](https://github.com/shellspec/shellspec#installation)
  
  ```curl -fsSL https://git.io/shellspec | sh```

* Run Shellspec using the bash command ```shellspec -f d```

## Environment Variables

* SHARG_DISABLE_WARNINGS = true/false (default)

  Disables all shArg related warnings.