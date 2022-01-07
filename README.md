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

## Parameters

### Common parameters

| Name               | Description                               | Value |
| ------------------ | ----------------------------------------- | ----- |
| `nameOverride`     | String to partially override css.fullname | `""`  |
| `fullnameOverride` | String to fully override css.fullname     | `""`  |


### Solid Community Server parameters

| Name                        | Description                                                                                                                                                         | Value       |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `config.bundled`            | Use one of the bundled configs (options: default, file, sparlql-endpoint, etc.)                                                                                     | `default`   |
| `config.configMapName`      | Name of configMap holding a custom css config                                                                                                                       | `""`        |
| `config.configMapKey`       | Key for the configfile to be used from the configMap                                                                                                                | `""`        |
| `logLevel`                  | Log level: silly, debug, verbose, info, warn, error                                                                                                                 | `info`      |
| `showStacktrace`            | Enables detailed logging on error pages.                                                                                                                            | `false`     |
| `baseUrlOverride`           | From the helm config, an appropriate --baseUrl value will be passed to the community server. If however you wish to override this set this parameter appropriately. | `""`        |
| `persistence.enabled`       | Enable persistence on CSS using a `PersistentVolumeClaim`. If false, use emptyDir                                                                                   | `false`     |
| `persistence.existingClaim` | Name of an existing `PersistentVolumeClaim` for CSS replicas                                                                                                        | `""`        |
| `persistence.subPath`       | Subdirectory of the volume to mount at (mostly useful when using an existing claim)                                                                                 | `""`        |
| `persistence.storageClass`  | CSS persistent volume storage Class                                                                                                                                 | `""`        |
| `persistence.size`          | CSS persistent volume size                                                                                                                                          | `128Mi`     |
| `persistence.selector`      | Selector to match an existing Persistent Volume                                                                                                                     | `{}`        |
| `service.type`              | CSS Kubernetes service type                                                                                                                                         | `ClusterIP` |
| `service.port`              | CSS Kubernetes service port                                                                                                                                         | `80`        |
| `service.nodePort`          | CSS Kubernetes service node port, only relevant when service.type == `NodePort`                                                                                     | `""`        |
| `ingress.enabled`           | Set to true to enable ingress record generation                                                                                                                     | `false`     |
| `ingress.host`              | When the ingress is enabled, a host pointing to this will be created                                                                                                | `CSS.local` |
| `ingress.path`              | Default path for the ingress resource                                                                                                                               | `/`         |
| `ingress.annotations`       | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.                                    | `{}`        |
| `ingress.tls`               | TLS Configuration                                                                                                                                                   | `[]`        |
| `ingress.ingressClassName`  | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                                                       | `""`        |
| `resources.limits`          | The resources limits for CSS containers                                                                                                                             | `{}`        |
| `resources.requests`        | The requested resources for CSS containers                                                                                                                          | `{}`        |
| `podAnnotations`            | CSS Pod annotations                                                                                                                                                 | `{}`        |
| `securityContext`           | Security Context for CSS Container                                                                                                                                  | `{}`        |
| `podSecurityContext`        | Security Context for CSS Pod                                                                                                                                        | `{}`        |
| `nodeSelector`              | Node labels for pod assignment                                                                                                                                      | `{}`        |
| `tolerations`               | Tolerations for pod assignment                                                                                                                                      | `[]`        |
| `affinity`                  | Affinity for pod assignment                                                                                                                                         | `{}`        |

# WIP

CSS uses the one Base URL and seems heavily dependent on it with multiple verifications.
When deploying on Kubernetes we make a distinction between in-cluster communication and exposed out-of-cluster.
For example, we have CSS deployed, using ingress with a host domain `example.com` to expose publicly.
When applications from outside want to access our solid server, they use `http://example.com/`.
When application in our cluster want to access they could also use `http://<namespace>.<service>/` instead of the public URL.
Applications in the same namespace use `http://<service>` as well. Support for multiple valid base urls in CSS could be worthwile. Also https/http should be considered.

# Workarounds
Use `baseUrlOverride` to set it to `http://localhost:3000/`, deploy and use port-forwarding to connect to your Solid App over localhost.
`kubectl port-forward <css-pod> 3000:3000`



