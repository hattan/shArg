 Describe 'shArg'
  Include spec/integration/harness/runner.sh

  Context "Simple Script Tests"
    It 'should parse a csv parameter'
      When call run_file "spec/integration/harness/list.sh"  "-i 123,456"
      The output should equal "ip: 123 ip: 456"
    End

    It 'should parse a space delimited parameter'
      When call run_file "spec/integration/harness/list.sh"  "-i 888 777"
      The output should equal "ip: 888 ip: 777"
    End    

  End
End