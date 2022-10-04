# docker-kubectl

This repo is a portable version of kubectl 1.8.0 for older EKS configuration.

## Running in bash

```sh
# add alias to bash profile
$ alias kubectl-1.8.0='docker run --rm -it -v $HOME/.kube:/root/.kube ghcr.io/anthoneous/kubectl:1.8.0 kubectl'

# test command
$ kubectl-1.8.0 version
```
