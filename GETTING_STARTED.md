# shArg

## Getting Started

This guide will walk you through setting up a simple script to use shArg and highlight some of the features of the tool.

### Set up a test folder

* `mkdir -p "test"`
* `cd "test"`

### Install shArg using the setup script

* `curl -L https://raw.githubusercontent.com/hattan/shArg/setup.sh | bash`

### Create a new example.sh file to test.

* `touch example.sh`
* chmod +x example.sh
* Open example.sh in your favorite editor and the following :

  ```bash
  #!/usr/bin/env bash
  # load shArg
  source .sh_arg/shArg.sh

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

### Run the example script

* Invoke example.sh with the following commands:
  * `./example.sh -m hello world`
  * `./example.sh -m=hello there`
  * `./example.sh -m hi -d`

### Docs

* See the project [README.](README.md)
* Explore the [provided examples.](./examples)
