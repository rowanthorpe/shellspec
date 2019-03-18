#shellcheck shell=sh

Describe "libexec/translator.sh"
  # shellcheck source=lib/libexec/translator.sh
  . "$SHELLSPEC_LIB/libexec/translator.sh"

  Describe "trim()"
    Context 'When value is abc'
      Before 'value="  abc"'
      Example 'trim left space'
        When call trim value
        The variable value should eq 'abc'
      End
    End

    Context 'When value is abc'
      Before 'value="${TAB}${TAB}abc"'
      Example 'trim left tab'
        When call trim value
        The variable value should eq 'abc'
      End
    End
  End
End
