
Describe 'shArg'
  Include scripts/shArg.sh

  Context "Argument Registration"
    It 'should add to _SH_ARGUMENTS'
      When call shArgs.arg "MESSAGE" -m --message PARAMETER 
      The value "${#_SH_ARGUMENTS[@]}" should equal 1
    End

    It 'should add empty string to _SH_ARGUMENTS[MESSAGE] if PARAMETER'
      When call shArgs.arg "MESSAGE" -m --message PARAMETER 
      The value "${_SH_ARGUMENTS['MESSAGE']}" should equal ""
    End

    It 'should add false to _SH_ARGUMENTS[MESSAGE] if FLAG'
      When call shArgs.arg "MESSAGE" -m --message FLAG 
      The value "${_SH_ARGUMENTS['MESSAGE']}" should equal false
    End

    It 'should add -m to _SH_SWITCHES'
      When call shArgs.arg "MESSAGE" -m --message PARAMETER 
      The value "${_SH_SWITCHES['-m']}" should equal "MESSAGE"
    End

    It 'should add --message to _SH_SWITCHES'
      When call shArgs.arg "MESSAGE" -m --message PARAMETER 
      The value "${_SH_SWITCHES['--message']}" should equal "MESSAGE"
    End

    It 'should add PARAMETER to _SH_TYPES if specified'
      When call shArgs.arg "MESSAGE" -m --message PARAMETER 
      The value "${_SH_TYPES['MESSAGE']}" should equal "PARAMETER"
    End

    It 'should default to PARAMETER if omitted'
      When call shArgs.arg "MESSAGE" -m --message  
      The value "${_SH_TYPES['MESSAGE']}" should equal "PARAMETER"
    End

    It 'should add FLAG to _SH_TYPES if specified'
      When call shArgs.arg "MESSAGE" -m --message FLAG 
      The value "${_SH_TYPES['MESSAGE']}" should equal "FLAG"
    End

    It 'should set auto export to true, if specified'
      When call shArgs.arg "MESSAGE" -m --message FLAG true
      The value "${_SH_AUTOS['MESSAGE']}" should equal true
    End

    It 'should set auto export to false, if not specified'
      When call shArgs.arg "MESSAGE" -m --message FLAG 
      The value "${_SH_AUTOS['MESSAGE']}" should equal false
    End

    It 'should allow only short name to be specified'
      When call shArgs.arg "MESSAGE" -m  
      The value "${_SH_ARGUMENTS['MESSAGE']}" should equal ""
      The value "${_SH_SWITCHES['-m']}" should equal "MESSAGE"
    End

    It 'should allow only long name to be specified'
      When call shArgs.arg "MESSAGE" --message
      The value "${_SH_ARGUMENTS['MESSAGE']}" should equal ""
      The value "${_SH_SWITCHES['--message']}" should equal "MESSAGE"
    End
  End

  Context "Argument Parsing"
    setup() { 
      # argument registration used by the specs that follow.
      shArgs.arg "MESSAGE" -m --message PARAMETER   #1
      shArgs.arg "DEBUG" -d --debug FLAG            #2
      shArgs.arg "USER" -u                          #3
      shArgs.arg "OUTPUT" --output                  #4
      shArgs.arg "FILE" -f --file PARAMETER true    #5
    }
    BeforeEach 'setup'

    It 'should parse an argument with short name (#1)'
      When call shArgs.parse -m "hello"
      The value "${_SH_ARGUMENTS['MESSAGE']}" should equal "hello"
    End

    It 'should parse an argument with long name (#1)'
      When call shArgs.parse --message "test123"
      The value "${_SH_ARGUMENTS['MESSAGE']}" should equal "test123"
    End

    It 'should parse flags with boolean values (#2)'
      When call shArgs.parse --message "test123" -d
      The value "${_SH_ARGUMENTS['DEBUG']}" should equal true
    End

    It 'should parse parameters with only short name defined (#3)'
      When call shArgs.parse --message "test123" -u bob -d
      The value "${_SH_ARGUMENTS['USER']}" should equal "bob"
    End

    It 'should parse parameters with only long name defined (#4)'
      When call shArgs.parse --message "test123" -u bob --output table -d
      The value "${_SH_ARGUMENTS['OUTPUT']}" should equal "table"
    End

    It 'should set a global variable if auto export is true (#5)'
      When call shArgs.parse --message "test123" -u bob --output table --file test.txt -d
      The value "$FILE" should equal "test.txt"
    End

    It 'should still set _SH_ARGUMENTS if auto export is true (#5)'
      When call shArgs.parse --message "test123" -u bob --output table --file test1.txt -d
      The value "${_SH_ARGUMENTS['FILE']}" should equal "test1.txt"
    End

    It 'should still set _SH_ARGUMENTS if auto export is true (#5)'
      When call shArgs.parse --message "test123" -u bob --output table --file test1.txt -d
      The value "${_SH_ARGUMENTS['FILE']}" should equal "test1.txt"
    End

    It 'should set several values at once'
      When call shArgs.parse --message "abcd" -u picard --output json -f input.dat -d
      The value "${_SH_ARGUMENTS['MESSAGE']}" should equal "abcd"
      The value "${_SH_ARGUMENTS['USER']}" should equal "picard"
      The value "${_SH_ARGUMENTS['OUTPUT']}" should equal "json"
      The value "${_SH_ARGUMENTS['DEBUG']}" should equal "true"
      The value "${_SH_ARGUMENTS['FILE']}" should equal "input.dat"
      The value "$FILE" should equal "input.dat" 
    End
  End 

  Context "val helper method"
    setup() { 
      shArgs.arg "MESSAGE" -m --message PARAMETER  
      shArgs.arg "DEBUG" -d --debug FLAG            
      shArgs.arg "USER" -u                          
      shArgs.arg "OUTPUT" --output                  
      shArgs.arg "FILE" -f --file PARAMETER true    

      shArgs.parse --message "efghij" -u picard --output json -f input.dat -d
    }
    BeforeEach 'setup'

    It 'should return the correct value when shArg.val is called'
      When call shArgs.val "MESSAGE"
      The output should equal "efghij"
    End

    It 'should return empty string when an invalid key is passed to val'
      When call shArgs.val "INVALID"
      The output should equal ""
    End

  End 
End
