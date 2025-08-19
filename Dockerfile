FROM alpine:3.19

# Make sure to have the appropriate version based on base image (alpine:3.19)
RUN apk add --no-cache \
  bash=5.2.21-r0 \
  curl=8.12.1-r0 \
  jq=1.7.1-r0

RUN mkdir -p /conjur-action 

COPY entrypoint.sh /conjur-action/entrypoint.sh

COPY CHANGELOG.md /conjur-action/CHANGELOG.md

RUN chmod +x /conjur-action/entrypoint.sh

WORKDIR /conjur-action

ENTRYPOINT ["/conjur-action/entrypoint.sh"]