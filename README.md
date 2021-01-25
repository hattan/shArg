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

## Running the tests

* Install [ShellSpec](https://github.com/shellspec/shellspec#installation)
  
  ```curl -fsSL https://git.io/shellspec | sh```

* Run Shellspec using the bash command ```shellspec -f d```