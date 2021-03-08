 
Describe 'shArg'
  Include scripts/shArg.sh

  Context "Argument Parsing"
    setup() { 
      # argument registration used by the specs that follow.
      shArgs.arg "RESOURCE_GROUP" -g --resource PARAMETER true
    }
    BeforeEach 'setup'

    It 'should parse an argument value with dashes in the text'
      When call shArgs.parse -g "my-test-group"
      The value "$RESOURCE_GROUP" should equal "my-test-group"
    End
  End 
End