# CSS Base URL in Kubernetes environment
CSS uses the one Base URL and seems heavily dependent on it with multiple verifications.
When deploying on Kubernetes we make a distinction between in-cluster communication and exposed out-of-cluster.
For example, we have CSS deployed, using ingress with a host domain `example.com` to expose publicly.
When applications from outside want to access our solid server, they use `http://example.com/`.
When application in our cluster want to access they could also use `http://<namespace>.<service>/` instead of the public URL.
Applications in the same namespace use `http://<service>` as well. Support for multiple valid base urls in CSS could be worthwile. Also https/http should be considered.