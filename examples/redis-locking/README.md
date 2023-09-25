# Multithreaded CSS with Redis based resource locking

A config has been provided to setup CSS with a file backend and Redis resource locking. First we need to get this config deployed on the cluster in a configmap:

```bash
kubectl create configmap css-redis-file --from-file examples/redis-locking/config.json
```

```bash
helm install css-redis bitnami/redis --set auth.enabled=false
```
