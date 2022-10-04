FROM alpine:latest

LABEL org.opencontainers.image.source=https://github.com/anthoneous/docker-kubectl
LABEL org.opencontainers.image.description="Portable kubectl 1.8.0"

# Install requirements
RUN apk add -U openssl curl tar gzip bash ca-certificates

# Install kubectl
RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl && \
  chmod +x /usr/bin/kubectl && \
  kubectl version --client

ENTRYPOINT []
CMD []