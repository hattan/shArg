![CI](https://github.com/hattan/shArg/workflows/CI/badge.svg)

# shArg
argument parsing library for .sh files. 


## Simple Example:

```shell
# load shArg
source shArg.sh

declare MESSAGE
declare DEBUG

# register arguments
shArgs.arg "MESSAGE" -m --message PARAMETER true
shArgs.arg "DEBUG" -d --debug FLAG true

# parse inputs
shArgs.parse $@

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

* Copy shArg.sh to your project.
* source shArg in your bash script.
  ```source shArg.sh```
* Register arguments
  ```shArgs.arg "<key: string>" "<short flag name: -string>" "<long flag name: --string>" "<type: PARAMETER | FLAG>" "<auto export: true | false"```

  example: ```shArgs.arg "MESSAGE" -m --message PARAMETER true```

* Parse inputs: ```shArgs.parse $@```

 * If arguments are autoexported they will be accessible via global variables.
*  If not autoexported (default) then you can explicility read the values using either of these mechanisms:

    * using shArg.val

      ``` declare message=`shArgs.val "MESSAGE"` ```
      ``` echo $message ```

    * using the _SH_ARGUMENTS array
      ``` echo "MESSAGE = ${_SH_ARGUMENTS["MESSAGE"]}" ```

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

  ***Note:*** For csv inputs, please ensure that there is no space between elements and associated commas. This applies event with quotes inputs.

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

shArgs.arg is the method used to register commnd line parameters or flags.

  ```shArgs.arg "<key> <short name> <long name> <type> <auto export>"```

|parameter| descriptions| example|
----------|-------------|--------|
| key | unique name for your variable. Note if auto export is true ,then this is the variable name that will set in the global scope| "MESSAGE"
| short name | the short command line flag and should start with one single dash.| -m
| long name | the long version command line flag and should start with two dashes | --messages
|type| either PARAMETER (for inputs with values) or FLAG (for boolean inputs which do not require a value) | -d
|auto export| either true or false . If true, then the key is exported to the global scope as a variable with the input value.| true
|hook method name| Name of a method to invoke when the argument is found (see hooks section below)| "hookMethod"

## Hook methods

shArg support hook functions, which are bash functions that get invoked when the parse method finds an input that matches an argument. Hook method binding are useful for setting other values or side effects when an input is found.

examle:

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
shArgs.parse $@


```

## Running the tests

* Install [ShellSpec](https://github.com/shellspec/shellspec#installation)
  
  ```curl -fsSL https://git.io/shellspec | sh```

* Run Shellspec using the bash command ```shellspec -f d```