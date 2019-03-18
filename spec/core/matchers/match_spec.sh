#shellcheck shell=sh

Describe "core/matchers/match.sh"
  Before set_subject
  subject() { false; }

  Describe 'match matcher'
    Example 'example'
      The value "foobarbaz" should match "foo*"
      The value "foobarbaz" should not match "FOO*"
    End

    Context 'when subject is foobarbaz'
      subject() { shellspec_puts foobarbaz; }

      Example 'it should match "foo*"'
        When invoke matcher match "foo*"
        The status should be success
      End

      Example 'it should match "FOO*"'
        When invoke matcher match "FOO*"
        The status should be failure
      End
    End

    Context 'when subject is undefined'
      subject() { false; }
      Example 'it should not match "*"'
        When invoke matcher match "*"
        The status should be failure
      End
    End

    Example 'output error if parameters is missing'
      When invoke matcher match
      The stderr should equal SYNTAX_ERROR_WRONG_PARAMETER_COUNT
      The status should be failure
    End

    Example 'output error if parameters count is invalid'
      When invoke matcher match "foo" "bar"
      The stderr should equal SYNTAX_ERROR_WRONG_PARAMETER_COUNT
      The status should be failure
    End
  End
End
