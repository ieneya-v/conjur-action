FROM alpine:3.19

# Make sure to have the appropriate version based on base image (alpine:3.19)
RUN apk add --no-cache \
  bash=5.2.21-r0 \
  curl=8.12.1-r0 \
  jq=1.7.1-r0

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN mkdir -p /conjur-action 

COPY entrypoint.sh /conjur-action/entrypoint.sh

COPY CHANGELOG.md /conjur-action/CHANGELOG.md

RUN chown -R appuser:appgroup /conjur-action 

RUN chmod +x /conjur-action/entrypoint.sh

WORKDIR /conjur-action

USER appuser

#  Add HEALTHCHECK
HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 

ENTRYPOINT ["/conjur-action/entrypoint.sh"]
