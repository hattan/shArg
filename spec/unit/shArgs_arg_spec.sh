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

    It 'should set auto export to true, if not specified'
      When call shArgs.arg "MESSAGE" -m --message FLAG 
      The value "${_SH_AUTOS['MESSAGE']}" should equal true
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
End
