FROM alpine:3.20

RUN apk add --no-cache \
    ca-certificates \
    curl \
    unzip

RUN mkdir -p /usr/local/bin /etc/xray && \
    curl -L \
      https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
      -o /tmp/xray.zip && \
    unzip /tmp/xray.zip xray -d /usr/local/bin && \
    chmod +x /usr/local/bin/xray && \
    rm -f /tmp/xray.zip

COPY config.json /etc/xray/config.json

EXPOSE 10000

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
