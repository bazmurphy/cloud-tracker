# Terminology

## Kubernetes

An open source system for automating deployment, scaling, and management of Containerized applications.

## Cluster

A Kubernetes cluster is a set of Nodes (machines) running Kubernetes. The cluster manages and schedules containers on the Nodes.

## Node

A machine (physical or virtual) that runs containers managed by Kubernetes. Each Node runs the Kubernetes Node Agent (kubelet).

## Pod

The basic building block in Kubernetes. A pod represents a group of one or more Containers that share resources like Volumes and Network. Pods always run on Nodes.

## Namespace

Namespaces are virtual Clusters backed by the same physical cluster. They provide isolation for teams and applications in a shared Cluster.

## Deployment

A Kubernetes deployment describes the desired state for a Pod or replicated set of Pods. It controls deploying and updating instances of an application.

## Service

A Kubernetes service groups a set of Pods and provides a stable network endpoint to access them. Services allow Pods to die and replicate in Kubernetes without affecting the application

## Ingress

An ingress exposes HTTP and HTTPS routes from outside the Cluster to Services within the Cluster. Traffic routing is controlled by rules defined on the Ingress resource.

## ConfigMap

A ConfigMap stores configuration data like environment variables, command-line arguments, configuration files, etc. Pods consume ConfigMaps as environment variables, command-line arguments, or configuration files.

## Secret

A Secret is similar to a ConfigMap but designed to hold confidential data like passwords, API keys, etc. Secrets are only sent to Nodes that have a Pod requesting that Secret.

# Steps

1.  minikube needs kubectl (but may come as dependency of the below)
2.  install minikube
3.  `brew install minikube`
4.  start minikube
5.  `minikube start`

    ```
    $ minikube start
    😄  minikube v1.31.2 on Darwin 12.6.7
    ✨  Using the docker driver based on existing profile
    👍  Starting control plane node minikube in cluster minikube
    🚜  Pulling base image ...
    🤷  docker "minikube" container is missing, will recreate.
    🔥  Creating docker container (CPUs=2, Memory=4000MB) ...
    🐳  Preparing Kubernetes v1.27.4 on Docker 24.0.4 ...
        ▪ Generating certificates and keys ...
        ▪ Booting up control plane ...
        ▪ Configuring RBAC rules ...
    🔗  Configuring bridge CNI (Container Networking Interface) ...
        ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
    🔎  Verifying Kubernetes components...
    🌟  Enabled addons: storage-provisioner, default-storageclass
    🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
    ```

6.  access the cluster:
7.  `kubectl get po -A`

    ```
    NAMESPACE     NAME                               READY   STATUS    RESTARTS        AGE
    kube-system   coredns-5d78c9869d-hfd7n           1/1     Running   0               5m44s
    kube-system   etcd-minikube                      1/1     Running   0               5m52s
    kube-system   kube-apiserver-minikube            1/1     Running   0               5m52s
    kube-system   kube-controller-manager-minikube   1/1     Running   0               5m52s
    kube-system   kube-proxy-lw7rj                   1/1     Running   0               5m44s
    kube-system   kube-scheduler-minikube            1/1     Running   0               5m52s
    kube-system   storage-provisioner                1/1     Running   1 (5m11s ago)   5m47s
    ```

8.  deploy applications:

9.  service:
    create a sample deployment on port 8080
    `kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0`

    ```
    deployment.apps/hello-minikube created
    ```

    `kubectl expose deployment hello-minikube --type=NodePort --port=8080`

    ```
    service/hello-minikube exposed
    ```

10. the deployment will show up when you run:
    `kubectl get services hello-minikube`

    ```
    NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
    hello-minikube   NodePort   10.102.139.17   <none>        8080:30969/TCP   29s
    ```

11. let minikube launch a web browser for you:
    `minikube service hello-minikube`

    OR use kubectl to forward the port:
    `kubectl port-forward service/hello-minikube 7080:8080`

12. `kubectl get pods`

13. `kubectl describe pod hello-minikube-b67847c65-9z5xn`

14. visit http://localhost:7080

    ```
    Request served by hello-minikube-59d4768566-qg9b7

    HTTP/1.1 GET /

    Host: localhost:7080
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,_/_;q=0.8
    Accept-Encoding: gzip, deflate, br
    Accept-Language: en-GB,en;q=0.5
    Connection: keep-alive
    Dnt: 1
    Sec-Fetch-Dest: document
    Sec-Fetch-Mode: navigate
    Sec-Fetch-Site: none
    Sec-Fetch-User: ?1
    Upgrade-Insecure-Requests: 1
    User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/118.0
    ```

15. pause kubernetes without impacted deployed applications:
    `minikube pause`
    unpause a paused instance:
    `minikube unpause`
    halt the cluster:
    `minikube stop`
    change the default memory limit (requires restart):
    `minikube config set memory 9001`
    browser the catalog of easily installed kubernetes services:
    `minikybe addons list`
    delete all of the minikube clusters:
    `minikube delete --all`
