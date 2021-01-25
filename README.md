# shArg
argument parsing library for .sh files.

## Getting Started

* Copy shArg.sh to your project.
* source shArg in your bash script.
  ```source shArg.sh```
* Register arguments
  ```shArgs.arg "<key: string>" "<short flag name: -string>" "<long flag name: --string>" "<type: PARAMETER | FLAG>" "<auto export: true | false"```

* ```shArgs.parse $@```

 * If arguments are autoexported they will be accessible via global variables.
*  If not autoexported (default) then you can explicility read the values using either of these mechanisms:

    * using shArg.val

      ``` declare message=`shArgs.val "MESSAGE"` ```
      ``` echo $message ```

    * using the _SH_ARGUMENTS array
      ``` echo "MESSAGE = ${_SH_ARGUMENTS["MESSAGE"]}" ```

Simple Example:
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

```
