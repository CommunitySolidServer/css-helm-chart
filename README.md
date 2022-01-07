
# CSS Base URL in Kubernetes environment
CSS uses the one Base URL and seems heavily dependent on it with multiple verifications.
When deploying on Kubernetes we make a distinction between in-cluster communication and exposed out-of-cluster.
For example, we have CSS deployed, using ingress with a host domain `example.com` to expose publicly.
When applications from outside want to access our solid server, they use `http://example.com/`.
When application in our cluster want to access they could also use `http://<namespace>.<service>/` instead of the public URL.
Applications in the same namespace use `http://<service>` as well. Support for multiple valid base urls in CSS could be worthwile. Also https/http should be considered.

# Workarounds
Use `baseUrlOverride` to set it to `http://localhost:3000/`, deploy and use port-forwarding to connect to your Solid App over localhost.
`kubectl port-forward <css-pod> 3000:3000`

# Config

## Using a bundled config
To use any of the bundled configs of CSS, specify which config to use by overriding `config.bundled` with any of the following values:
- default (default)
- dynamic
- example-https-file
- file
- file-no-setup
- memory-subdomains
- path-routing
- restrict-idp
- sparql-endpoint-no-setup
- sparql-endpoint
- sparql-file-storage

## Use a custom config
To use a custom config, the `config.configMapName` and `config.configMapKey` variables are used.

First create a configmap resource to hold your config on the cluster. For example when you have a one json file called `my-config.json`:
```
kubectl create configmap my-configmap --from-file my-config.json
```

Alternatively when you have multiple configs in a directory called `my-configs`, you can bundle a whole directory into one configmap like so:
```
kubectl create configmap my-configmap --from-file my-configs/
```

Then override this name and key values accordingly (key of the config will be the same as the filename), for example:
```yaml
config:
    configMapName: my-configmap
    configMapKey: my-config.json
```

