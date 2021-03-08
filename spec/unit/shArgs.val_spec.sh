Describe 'shArg'
  Include scripts/shArg.sh

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
