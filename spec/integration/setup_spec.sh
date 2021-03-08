 Describe 'shArg'

  Context "Setup script tests"
    It 'should create a .sh_arg folder'
      When run script scripts/setup.sh  
      Path shArg-file=.sh_arg/shArg.sh
      The path shArg-file should be exist
    End
  End
End