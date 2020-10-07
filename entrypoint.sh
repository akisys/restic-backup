#!/bin/sh

RUN_CMD="${1:-""}"

if [ "${RUN_CMD}" == "shell" ] || [ "${RUN_CMD}" == "/bin/sh" ];
then
  shift
  exec "/bin/sh" "$@"
else
  exec "/usr/bin/restic-backup" "$@"
fi

