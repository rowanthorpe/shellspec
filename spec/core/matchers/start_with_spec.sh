#shellcheck shell=sh

Describe "core/matchers/start_with.sh"
  Describe 'start with matcher'
    Before set_subject
    subject() { false; }

    Example 'example'
      The value "foobarbaz" should start with "foo"
      The value "foobarbaz" should not start with "FOO"
    End

    Context 'when subject is abcdef'
      subject() { shellspec_puts abcdef; }

      Example 'it should start with "abc"'
        When invoke matcher start with "abc"
        The status should be success
      End

      Example 'it should start with "ABC"'
        When invoke matcher start with "ABC"
        The status should be failure
      End
    End

    Example 'output error if parameters is missing'
      When invoke matcher start with
      The stderr should equal SYNTAX_ERROR_WRONG_PARAMETER_COUNT
      The status should be failure
    End

    Example 'output error if parameters count is invalid'
      When invoke matcher start with "foo" "bar"
      The stderr should equal SYNTAX_ERROR_WRONG_PARAMETER_COUNT
      The status should be failure
    End
  End
End
