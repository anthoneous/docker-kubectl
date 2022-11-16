# docker-kubectl

This repo is a portable version of kubectl for older EKS configurations.

### Add the following lines to bash profile

```bash
export KUBEDOCKER='1.10.7'
```

```bash
alias kubectl-docker='docker run --rm -v $HOME/.kube:/root/.kube ghcr.io/anthoneous/kubectl:$KUBEDOCKER kubectl'
```

### Test command

```bash
kubectl-docker version
```

### Makefile commands

```makefile
make all
make build
make test
make push
```
