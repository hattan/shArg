 
Describe 'shArg'
  Include scripts/shArg.sh

Context "Argument Parsing"
    urlHook(){
      URL_HOOK_CALLED=true
      URL_HOOK_VALUE=$1
    }

    setup() { 
      # argument registration used by the specs that follow.
      shArgs.arg "MESSAGE" -m --message                  #1
      shArgs.arg "DEBUG" -d --debug                      #2
      shArgs.arg "USER" -u                               #3
      shArgs.arg "OUTPUT" --output                       #4
      shArgs.arg "FILE" -f --file                        #5
      shArgs.arg "URL" -l --url urlHook                  #6
      shArgs.arg "NAME" -nm --name                       #7
      shArgs.arg "RESOURCE_GROUP" -rgp --resource-group  #8
      URL_HOOK_CALLED=false
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

    It 'should set a global variable by default(#5)'
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

    It 'should call a hook method when a binding occurs #7'
      When call shArgs.parse --message "test123" -u bob --output table --file test1.txt -l http://fake.com -d
      The value "$URL_HOOK_CALLED" should equal true
    End 

    It 'should call a hook method with input parameter when a binding occurs #8'
      When call shArgs.parse -l http://fake.com 
      The value "$URL_HOOK_VALUE" should equal "http://fake.com"
    End 

    It 'should not call a hook method when the bound argument is not passed in #7'
      When call shArgs.parse --message "test123"
      The value "$URL_HOOK_CALLED" should equal false
    End 

    It 'should allow short name with two characters #8'
      When call shArgs.parse -nm "some name"
      The value "$NAME" should equal "some name"
    End 

    It 'should allow short name with three characters #9'
      When call shArgs.parse -rgp "my-test-group"
      The value "$RESOURCE_GROUP" should equal "my-test-group"
    End     
  End 

  Context "Argument Parsing (Legacy)"
    urlHook_legacy(){
      URL_HOOK_CALLED=true
      URL_HOOK_VALUE=$1
    }

    setup_legacy() { 
      # argument registration used by the specs that follow.
      shArgs.arg "MESSAGE" -m --message PARAMETER                       #1
      shArgs.arg "DEBUG" -d --debug FLAG                                #2
      shArgs.arg "USER" -u                                              #3
      shArgs.arg "OUTPUT" --output                                      #4
      shArgs.arg "FILE" -f --file PARAMETER true                        #5
      shArgs.arg "URL" -l --url PARAMETER true urlHook_legacy           #6
      shArgs.arg "NAME" -nm --name PARAMETER true                       #7
      shArgs.arg "RESOURCE_GROUP" -rgp --resource-group PARAMETER true  #8
      URL_HOOK_CALLED=false
    }
    BeforeEach 'setup_legacy'

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

    It 'should call a hook method when a binding occurs #7'
      When call shArgs.parse --message "test123" -u bob --output table --file test1.txt -l http://fake.com -d
      The value "$URL_HOOK_CALLED" should equal true
    End 

    It 'should call a hook method with input parameter when a binding occurs #8'
      When call shArgs.parse -l http://fake.com 
      The value "$URL_HOOK_VALUE" should equal "http://fake.com"
    End 

    It 'should not call a hook method when the bound argument is not passed in #7'
      When call shArgs.parse --message "test123"
      The value "$URL_HOOK_CALLED" should equal false
    End 

    It 'should allow short name with two characters #8'
      When call shArgs.parse -nm "some name"
      The value "$NAME" should equal "some name"
    End 

    It 'should allow short name with three characters #9'
      When call shArgs.parse -rgp "my-test-group"
      The value "$RESOURCE_GROUP" should equal "my-test-group"
    End     
  End 
End