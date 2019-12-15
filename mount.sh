#/bin/sh

PROFILE="${1}"
HOST_MOUNTPATH="${2}"

if [ -z "${PROFILE}" ]; then
  echo "need profile"; exit 1;
fi

if [ -z "${HOST_MOUNTPATH}" ]; then
  echo "need host mountpath"; exit 1;
fi

cd "$(dirname $0)"
echo "sudo permissions required for remounting binds"
sudo mount --bind -o shared "${HOST_MOUNTPATH}" "${HOST_MOUNTPATH}"

docker-compose run \
  --rm \
  -v "${HOST_MOUNTPATH}:${HOST_MOUNTPATH}:ro,shared" \
  restic-backup \
  -p "${PROFILE}" \
  mount "${HOST_MOUNTPATH}"

echo "sudo permissions required for unmounting previous binds"
sudo umount "${HOST_MOUNTPATH}"

