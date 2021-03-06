#shellcheck shell=sh

shellspec_syntax 'shellspec_matcher_match'

shellspec_matcher_match() {
  shellspec_matcher__match() {
    # shellcheck disable=SC2034
    SHELLSPEC_EXPECT=$1
    [ "${SHELLSPEC_SUBJECT+x}" ] || return 1
    shellspec_match "$SHELLSPEC_SUBJECT" "$1"
  }

  shellspec_matcher__failure_message() {
    shellspec_putsn "expected $1 to match $2"
  }

  shellspec_matcher__failure_message_when_negated() {
    shellspec_putsn "expected $1 not to match $2"
  }

  shellspec_syntax_param count [ $# -eq 1 ] || return 0
  shellspec_matcher_do_match "$@"
}
