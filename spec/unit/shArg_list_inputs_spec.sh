Describe 'shArg'
  Include scripts/shArg.sh
  Context "csv inputs"
    setup() { 
      shArgs.arg "IPS" -i --ips PARAMETER true 
    }
    BeforeEach 'setup'

    assert_val_method() {
      local varName=$1
      local expectedValue=$2
      local value=$(shArgs.val "IPS")
      if [ "$value" == "$expectedValue" ]; then
        return 0
      else
        return 1
      fi
    }

    assert_global_ips() {
      local expectedValue=$1
      if [ "$IPS" == "$expectedValue" ]; then
        return 0
      else
        return 1
      fi
    }
    It 'should return an array of ips when shArg.val is called'
      When call shArgs.parse -i 10.10.10.1,10.10.10.2
      Assert assert_val_method "IPS" "10.10.10.1 10.10.10.2"
    End

    It 'should set the global variable IPS to an arra of ips'
      When call shArgs.parse -i 10.10.10.1,10.10.10.2
      Assert assert_global_ips  "10.10.10.1 10.10.10.2"
    End
  End   

  Context "space delimited inputs"
    setup() { 
      shArgs.arg "IPS" -i --ips PARAMETER true 
    }
    BeforeEach 'setup'

    assert_val_method() {
      local varName=$1
      local expectedValue=$2
      local value=$(shArgs.val "IPS")
      if [ "$value" == "$expectedValue" ]; then
        return 0
      else
        return 1
      fi
    }

    assert_global_ips() {
      local expectedValue=$1
      if [ "$IPS" == "$expectedValue" ]; then
        return 0
      else
        return 1
      fi
    }
    It 'should return an array of ips when shArg.val is called'
      When call shArgs.parse -i "10.10.10.1 10.10.10.2"
      Assert assert_val_method "IPS" "10.10.10.1 10.10.10.2"
    End

    It 'should set the global variable IPS to an arra of ips'
      When call shArgs.parse -i "10.10.10.1 10.10.10.2"
      Assert assert_global_ips  "10.10.10.1 10.10.10.2"
    End
  End 
End
