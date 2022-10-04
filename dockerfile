FROM alpine:latest

ARG KUBEVERSION=''

LABEL org.opencontainers.image.source=https://github.com/anthoneous/docker-kubectl
LABEL org.opencontainers.image.description="Portable kubectl $KUBEVERSION"

# Install requirements
RUN apk add -U openssl curl tar gzip bash ca-certificates

# Install kubectl
RUN curl -L -o /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v$KUBEVERSION/bin/linux/amd64/kubectl" && \
  chmod +x /usr/bin/kubectl && \
  kubectl version --client

ENTRYPOINT []
CMD []