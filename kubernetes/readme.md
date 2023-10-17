## Start minikube

0. start minikube `minikube start`

## Create the Namespace

1. `kubectl apply -f namespace.yml`
   namespace/cloud-tracker created

## Create the Database

2. `kubectl apply -f database-configmap.yml`
   configmap/database-configmap created

3. `kubectl apply -f database-secret.yml`
   secret/database-secret created

4. `kubectl apply -f database-persistent-volume.yml`
   persistentvolume/database-persistent-volume created

5. `kubectl apply -f database-persistent-volume-claim.yml`
   persistentvolumeclaim/database-persistent-volume-claim created

6. `kubectl apply -f database-deployment.yml`
   deployment.apps/database-deployment created

7. `kubectl apply -f database-service.yml`
   service/database-service created

8. `kubectl get all --namespace=cloud-tracker`

   ```
   NAME                                       READY   STATUS    RESTARTS   AGE
   pod/database-deployment-6dcbb8d7fb-mvkmr   1/1     Running   0          29s

   NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
   service/database-service   ClusterIP   10.107.212.195   <none>        5432/TCP   25s

   NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/database-deployment   1/1     1            1           29s

   NAME                                             DESIRED   CURRENT   READY   AGE
   replicaset.apps/database-deployment-6dcbb8d7fb   1         1         1       29s
   ```

## Create the Backend

9. `kubectl apply -f backend-configmap.yml`
   configmap/backend-configmap created

10. `kubectl apply -f backend-deployment.yml`
    deployment.apps/backend-deployment created

11. `kubectl apply -f backend-service.yml`
    service/backend-service created

12. `kubectl get all --namespace=cloud-tracker`

    ```
    NAME                                       READY   STATUS    RESTARTS   AGE
    pod/backend-deployment-56d9dbc855-lzc2f    1/1     Running   0          23s
    pod/database-deployment-6dcbb8d7fb-mvkmr   1/1     Running   0          67s

    NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    service/backend-service    ClusterIP   10.96.252.13     <none>        4000/TCP   18s
    service/database-service   ClusterIP   10.107.212.195   <none>        5432/TCP   63s

    NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/backend-deployment    1/1     1            1           23s
    deployment.apps/database-deployment   1/1     1            1           67s

    NAME                                             DESIRED   CURRENT   READY   AGE
    replicaset.apps/backend-deployment-56d9dbc855    1         1         1       23s
    replicaset.apps/database-deployment-6dcbb8d7fb   1         1         1       67s
    ```

## Create the Frontend

13. `kubectl apply -f frontend-service.yml`
    service/frontend-service created

14. `kubectl apply -f frontend-deployment.yml`
    deployment.apps/frontend-deployment created

    ```
    $ kubectl logs -f frontend-deployment-7fc6468f7d-mvbl8 -c frontend -n cloud-tracker
    2023/10/17 16:17:41 [emerg] 1#1: host not found in upstream "backend" in /etc/nginx/nginx.conf:43
    nginx: [emerg] host not found in upstream "backend" in /etc/nginx/nginx.conf:43
    ```

15. I had to manually edit `nginx.conf` in the Repo/Docker Image to direct `/api` to `http://backend-service:4000` (Kubernetes) instead of `http://backend:4000` (Docker) - How to handle this dynamically?

16. `kubectl get all --namespace=cloud-tracker`

    ```
    NAME                                       READY   STATUS    RESTARTS   AGE
    pod/backend-deployment-56d9dbc855-lzc2f    1/1     Running   0          54s
    pod/database-deployment-6dcbb8d7fb-mvkmr   1/1     Running   0          98s
    pod/frontend-deployment-7fc6468f7d-5tb7l   1/1     Running   0          10s

    NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    service/backend-service    ClusterIP   10.96.252.13     <none>        4000/TCP   49s
    service/database-service   ClusterIP   10.107.212.195   <none>        5432/TCP   94s
    service/frontend-service   ClusterIP   10.100.137.63    <none>        80/TCP     14s

    NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/backend-deployment    1/1     1            1           54s
    deployment.apps/database-deployment   1/1     1            1           98s
    deployment.apps/frontend-deployment   1/1     1            1           10s

    NAME                                             DESIRED   CURRENT   READY   AGE
    replicaset.apps/backend-deployment-56d9dbc855    1         1         1       54s
    replicaset.apps/database-deployment-6dcbb8d7fb   1         1         1       98s
    replicaset.apps/frontend-deployment-7fc6468f7d   1         1         1       10s
    ```

## Create the Ingress

20. `kubectl apply -f ingress.yml`
    ingress.networking.k8s.io/ingress created

21. `kubectl get ingress -n cloud-tracker`

    ```
    NAME      CLASS    HOSTS   ADDRESS   PORTS   AGE
    ingress   <none>   *                 80      6s
    ```

22. `minikube ip`
    192.168.49.2

23. Try to visit http://192.168.49.2 but nothing

24. Research/Suggestions towards a solution:

    - run a service tunnel using: `minikube service frontend-service -n cloud-tracker --url`
      http://127.0.0.1:49546/ displays the frontned, but the frontend `fetch` is trying http://127.0.0.1:49546/api/coursework which obviously won't work

    - https://minikube.sigs.k8s.io/docs/handbook/accessing/#nodeport-access but I am deliberately using an `Ingress` instead of `NodePort`

    - The `ingress-dns` addon acts as a DNS service that runs inside your Kubernetes cluster https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/
