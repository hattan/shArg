 Describe 'shArg'
  Include spec/integration/harness/runner.sh

  Context "Simple Script Tests"
    It 'should parse a csv parameter'
      When call run_file "spec/integration/harness/hook.sh"  "-m great123"
      The output should equal "message hooked invoked with great123 Global variable is still available great123"
    End

  End
End