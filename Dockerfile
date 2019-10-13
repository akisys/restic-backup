FROM python:3-alpine

RUN set -ex \
      && apk add --no-cache restic curl fuse

WORKDIR /tmp
RUN set -ex \
      && curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip \
      && unzip rclone-current-linux-amd64.zip \
      && cd rclone-*-linux-amd64 \
      && cp rclone /usr/bin/ \
      && chown root:root /usr/bin/rclone \
      && chmod 755 /usr/bin/rclone \
      && rm -rf /tmp/*

WORKDIR /

ADD restic-backup /usr/bin/
ADD entrypoint.sh /
RUN set -ex \
      && mkdir -p /etc/restic \
      && chown root:root /entrypoint.sh \
      && chmod 755 /entrypoint.sh \
      && chown root:root /usr/bin/restic-backup \
      && chmod 755 /usr/bin/restic-backup

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]

