FROM alpine:3.19

RUN apk add --no-cache \
  bash=5.2.21-r0 \
  curl=8.12.1-r0 \
  jq=1.7.1-r0 \
  sudo

ARG USER=appuser
ARG GROUP=appgroup
ENV HOME=/home/$USER

# Create non-root user and set up sudo permissions
RUN addgroup -S $GROUP && \
    adduser -D -S -G $GROUP $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

RUN mkdir -p /conjur-action

COPY entrypoint.sh /conjur-action/entrypoint.sh
COPY CHANGELOG.md /conjur-action/CHANGELOG.md

RUN chmod +x /conjur-action/entrypoint.sh && \
    chown -R $USER:$GROUP /conjur-action

WORKDIR /conjur-action

USER $USER

HEALTHCHECK CMD curl --fail http://localhost:3000 || exit

ENTRYPOINT ["/conjur-action/entrypoint.sh"]
