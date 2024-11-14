 Describe 'shArg'
  Include spec/integration/harness/runner.sh

  Context "Hook Tests"
    It 'should invoke a hook function'
      When call run_file "spec/integration/harness/hook.sh"  "-m great123"
      The output should equal "message hooked invoked with great123 Global variable is still available great123"
    End

    It 'should invoke a hook function using the legacy registration'
      When call run_file "spec/integration/harness/hook_legacy.sh"  "-m great123"
      The output should equal "message hooked invoked with great123 Global variable is still available great123"
    End

  End
End