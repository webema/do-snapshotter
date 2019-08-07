FROM bash:5

RUN apk --update add jq && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

ENV VOLUME_ID=67890 \
  DIGITALOCEAN_TOKEN=12345 \
  SNAPSHOT_NAME=generic-snapshot

COPY script.sh /

CMD ["bash", "/script.sh"]
