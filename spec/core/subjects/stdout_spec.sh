#shellcheck shell=sh

Describe "core/subjects/stdout.sh"
  Before set_stdout
  stdout() { false; }

  Describe "stdout subject"

    Example 'example'
      func() { echo "foo"; }
      When call func
      The stdout should equal "foo"
      The output should equal "foo" # alias for stdout
    End

    Context 'when stdout is "test<LF>"'
      stdout() { shellspec_puts "test${LF}"; }
      Example "it should equal test"
        When invoke subject stdout _modifier_
        The entire stdout should equal 'test'
      End
    End

    Context 'when stdout is undefined'
      stdout() { false; }
      Example "it should be failure"
        When invoke subject stdout _modifier_
        The status should be failure
      End
    End

    Example 'output outor if next word is missing'
      When invoke subject stdout
      The entire stderr should equal SYNTAX_ERROR_DISPATCH_FAILED
    End
  End

  Describe "entire stdout subject"
    Example 'example'
      func() { echo "foo"; }
      When call func
      The entire stdout should equal "foo${LF}"
      The entire output should equal "foo${LF}" # alias for entire stdout
    End

    Context 'when stdout is "test<LF>"'
      stdout() { shellspec_puts "test${LF}"; }
      Example "it should equal test<LF>"
        When invoke subject entire stdout _modifier_
        The entire stdout should equal "test${LF}"
      End
    End

    Context 'when stdout is undefined'
      stdout() { false; }
      Example "it should be failure"
        When invoke subject entire stdout _modifier_
        The status should be failure
      End
    End

    Example 'output outor if next word is missing'
      When invoke subject entire stdout
      The entire stderr should equal SYNTAX_ERROR_DISPATCH_FAILED
    End
  End
End
