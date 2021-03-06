#shellcheck shell=sh

# to suppress shellcheck SC2034
: "${SHELLSPEC_SUBJECT:-}"

shellspec_syntax 'shellspec_subject_stderr'
shellspec_syntax_alias 'shellspec_subject_error' 'shellspec_subject_stderr'
shellspec_syntax 'shellspec_subject_entire_stderr'
shellspec_syntax_alias 'shellspec_subject_entire_error' 'shellspec_subject_entire_stderr'

shellspec_subject_stderr() {
  if [ ${SHELLSPEC_STDERR+x} ]; then
    SHELLSPEC_SUBJECT=$(shellspec_putsn "${SHELLSPEC_STDERR:-}")
  else
    unset SHELLSPEC_SUBJECT ||:
  fi

  shellspec_off UNHANDLED_STDERR

  eval shellspec_syntax_dispatch modifier ${1+'"$@"'}
}

shellspec_subject_entire_stderr() {
  if [ ${SHELLSPEC_STDERR+x} ]; then
    SHELLSPEC_SUBJECT=${SHELLSPEC_STDERR:-}
  else
    unset SHELLSPEC_SUBJECT ||:
  fi

  shellspec_off UNHANDLED_STDERR

  eval shellspec_syntax_dispatch modifier ${1+'"$@"'}
}
