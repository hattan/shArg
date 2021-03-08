 Describe 'shArg'
  Include spec/integration/harness/runner.sh

  Context "Simple Script Tests"
    It 'should parse a parameter with short name and no quotes'
      When call run_file "spec/integration/harness/simple.sh"  "-m hello"
      The output should equal "The message is hello DEBUG is false"
    End

    It 'should parse a parameter with short name, no quotes and equals assignment'
      When call run_file "spec/integration/harness/simple.sh"  "-m=hello"
      The output should equal "The message is hello DEBUG is false"
    End
    
    It 'should parse a parameter with short name and double quotes'
      When call run_file "spec/integration/harness/simple.sh"  "-m \"world\""
      The output should equal "The message is world DEBUG is false"
    End

    It 'should parse a parameter with short name, double quotes and equals assignment'
      When call run_file "spec/integration/harness/simple.sh"  '-m="hello"'
      The output should equal "The message is hello DEBUG is false"
    End    

    It 'should parse a parameter with short name and single quotes'
      When call run_file "spec/integration/harness/simple.sh"  "-m 'world'"
      The output should equal "The message is world DEBUG is false"
    End

    It 'should parse a parameter with short name, single quotes and equals assignment'
      When call run_file "spec/integration/harness/simple.sh"  "-m='hello'"
      The output should equal "The message is hello DEBUG is false"
    End   

    It 'should parse a parameter with long name and no quotes'
      When call run_file "spec/integration/harness/simple.sh"  "--message hello"
      The output should equal "The message is hello DEBUG is false"
    End

    It 'should parse a parameter with long name, no quotes and equals assignment'
      When call run_file "spec/integration/harness/simple.sh"  "--message=hello"
      The output should equal "The message is hello DEBUG is false"
    End  

    It 'should parse a parameter with long name and double quotes'
      When call run_file "spec/integration/harness/simple.sh"  "--message \"world\""
      The output should equal "The message is world DEBUG is false"
    End

    It 'should parse a parameter with long name, double quotes and equals assignment'
      When call run_file "spec/integration/harness/simple.sh"  '--message="hello"'
      The output should equal "The message is hello DEBUG is false"
    End      

    It 'should parse a parameter with long name and single quotes'
      When call run_file "spec/integration/harness/simple.sh"  "--message 'world'"
      The output should equal "The message is world DEBUG is false"
    End

    It 'should parse a parameter with long name, single quotes and equals assignment'
      When call run_file "spec/integration/harness/simple.sh"  "--message='hello'"
      The output should equal "The message is hello DEBUG is false"
    End  

    It 'should parse a parameter with long name and spaces. Single param only'
      When call run_file "spec/integration/harness/simple.sh"  "--message=hi there"
      The output should equal "The message is hi there DEBUG is false"
    End  

    It 'should parse a parameter with long name and spaces. Multiple params'
      When call run_file "spec/integration/harness/simple.sh"  "--message=hi there -d"
      The output should equal "The message is hi there DEBUG is true!"
    End  

    It 'should parse a parameter with short name and spaces. Equals assignment. Single param only'
      When call run_file "spec/integration/harness/simple.sh"  "-m=hi there"
      The output should equal "The message is hi there DEBUG is false"
    End  

    It 'should parse a parameter with long name and spaces. Equals assignment. Multiple params'
      When call run_file "spec/integration/harness/simple.sh"  "-m=hi there -d"
      The output should equal "The message is hi there DEBUG is true!"
    End  

    It 'should parse a parameter with short name and spaces. Positional assignment. Single param only'
      When call run_file "spec/integration/harness/simple.sh"  "-m hi there"
      The output should equal "The message is hi there DEBUG is false"
    End  

    It 'should parse a parameter with long name and spaces. Positional assignment. Multiple params'
      When call run_file "spec/integration/harness/simple.sh"  "-m hi there -d"
      The output should equal "The message is hi there DEBUG is true!"
    End  
  End
End