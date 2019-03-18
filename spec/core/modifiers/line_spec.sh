#shellcheck shell=sh

Describe "core/modifiers/line.sh"
  Describe "line modifier"
    Before set_subject
    subject() { false; }

    Example 'example'
      The line 1 of value foobarbaz should equal foobarbaz
    End

    Context 'when subject is "foo<LF>bar<LF>baz"'
      subject() { shellspec_puts "foo${LF}bar${LF}baz"; }
      Example 'second line is bar'
        When invoke modifier line 2 _modifier_
        The entire stdout should equal bar
      End
    End

    Context 'when subject is "foo<LF>"'
      subject() { shellspec_puts "foo${LF}"; }
      Example 'can not get second line'
        When invoke modifier line 2 _modifier_
        The status should be failure
      End
    End

    Context 'when subject is "foo<LF><LF>"'
      subject() { shellspec_puts "foo${LF}${LF}"; }
      Example 'second line is ""'
        When invoke modifier line 2 _modifier_
        The entire stdout should equal ""
      End
    End

    Context 'when subject is empty string'
      subject() { shellspec_puts ""; }
      Example 'can not get first line'
        When invoke modifier line 1 _modifier_
        The status should be failure
      End
    End

    Context 'when subject is "<LF>"'
      subject() { shellspec_puts "${LF}"; }
      Example 'first line is ""'
        When invoke modifier line 1 _modifier_
        The entire stdout should equal ""
      End
    End

    Context 'when subject is undefined'
      subject() { false; }
      Example 'can not get first line'
        When invoke modifier line 2 _modifier_
        The status should be failure
      End
    End

    Example 'output error if value is not a number'
      When invoke modifier line ni
      The stderr should equal SYNTAX_ERROR_PARAM_TYPE
    End

    Example 'output error if value is missing'
      When invoke modifier line
      The stderr should equal SYNTAX_ERROR_WRONG_PARAMETER_COUNT
    End

    Example 'output error if next word is missing'
      When invoke modifier line 2
      The stderr should equal SYNTAX_ERROR_DISPATCH_FAILED
    End
  End
End
