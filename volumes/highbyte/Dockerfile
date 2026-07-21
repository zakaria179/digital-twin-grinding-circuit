# HighByte Intelligence Hub Fallback Stub
# Note: Official HighByte images are enterprise tarballs loaded via `docker load -i HighByte-*.tar`.
# This Dockerfile provides an operational container fallback for local development.

FROM alpine:3.19

RUN apk add --no-cache curl bash

# Create app directory
WORKDIR /app

# Expose default HighByte port
EXPOSE 45245

# Lightweight HTTP health responder
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:45245/ || exit 1

CMD ["sh", "-c", "echo 'HighByte Intelligence Hub container initialized. (For production, load the official HighByte tarball: docker load -i HighByte-Intelligence-Hub-*.tar)'; while true; do echo -e 'HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHighByte Intelligence Hub Stub' | nc -l -p 45245; done"]
