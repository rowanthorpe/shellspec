#!/bin/sh

# Run tests in docker

# This script is for development purposes.
# It provide as is, do not any support.
# It may change without notice.

set -eu

if [ $# -eq 0 ]; then
cat <<'USAGE'
Usage: test_in_docker.sh [Dockerfile..] [-- COMMAND]

Run tests in docker

Example of use
  contrib/test_in_docker.sh dockerfiles/*
  contrib/test_in_docker.sh dockerfiles/debian-9-*
  contrib/test_in_docker.sh dockerfiles/*bash* -- contrib/bugs.sh

To delete all shellspec images
  docker rmi $(docker images shellspec -q)
USAGE
  exit 0
fi

main() {
  options=""
  for arg in "$@"; do
    case $arg in
      --) break ;;
      -*) options="${options}${arg} " ;;
    esac
  done

  while [ $# -gt 0 ]; do
    case $1 in
      --) break ;;
      -*) ;;
      *) run "$@" ;;
    esac
    shift
  done
}

run() {
  dockerfile=$1

  while [ $# -gt 0 ]; do
    [ "$1" = "--" ] && shift && break
    shift
  done

  echo "======================================================================"
  echo "[$dockerfile: $@]"
  tag="${dockerfile##*/}"
  docker build $options -t "shellspec:$tag" ./ -f "$dockerfile"
  echo
  docker run -it --rm "shellspec:$tag" "$@" &&:
  xs=$?
  echo "exit status: $xs"
  case $tag in
    *-fail) ;;
    *) [ $xs -eq 0 ] || exit 1
  esac
  echo
}

main "$@"

echo Done
