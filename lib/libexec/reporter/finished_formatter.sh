#shellcheck shell=sh

buffer finished

finished_end() {
  finished '=' "Finished in ${time_real:-?} seconds" \
    "(user ${time_user:-?} seconds, sys ${time_sys:-?} seconds)${LF}"
}

finished_output() {
  case $1 in (end)
    finished '>>'
  esac
}
