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
   pod/database-deployment-6dcbb8d7fb-jz2gh   1/1     Running   0          28s

   NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
   service/database-service   ClusterIP   10.101.209.232   <none>        5432/TCP   24s

   NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/database-deployment   1/1     1            1           28s

   NAME                                             DESIRED   CURRENT   READY   AGE
   replicaset.apps/database-deployment-6dcbb8d7fb   1         1         1       28s
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
    pod/backend-deployment-56d9dbc855-pl2jh    1/1     Running   0          20s
    pod/database-deployment-6dcbb8d7fb-jz2gh   1/1     Running   0          66s

    NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
    service/backend-service    ClusterIP   10.110.251.216   <none>        4000/TCP   17s
    service/database-service   ClusterIP   10.101.209.232   <none>        5432/TCP   62s

    NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/backend-deployment    1/1     1            1           20s
    deployment.apps/database-deployment   1/1     1            1           66s

    NAME                                             DESIRED   CURRENT   READY   AGE
    replicaset.apps/backend-deployment-56d9dbc855    1         1         1       20s
    replicaset.apps/database-deployment-6dcbb8d7fb   1         1         1       66s
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
    pod/backend-deployment-56d9dbc855-pl2jh    1/1     Running   0          83s
    pod/database-deployment-6dcbb8d7fb-jz2gh   1/1     Running   0          2m9s
    pod/frontend-deployment-7fc6468f7d-4x2x6   1/1     Running   0          33s

    NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
    service/backend-service    ClusterIP   10.110.251.216   <none>        4000/TCP       80s
    service/database-service   ClusterIP   10.101.209.232   <none>        5432/TCP       2m5s
    service/frontend-service   NodePort    10.109.0.229     <none>        80:30799/TCP   37s

    NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/backend-deployment    1/1     1            1           83s
    deployment.apps/database-deployment   1/1     1            1           2m9s
    deployment.apps/frontend-deployment   1/1     1            1           33s

    NAME                                             DESIRED   CURRENT   READY   AGE
    replicaset.apps/backend-deployment-56d9dbc855    1         1         1       83s
    replicaset.apps/database-deployment-6dcbb8d7fb   1         1         1       2m9s
    replicaset.apps/frontend-deployment-7fc6468f7d   1         1         1       33s
    ```

17. No `NodePort` was defined in the `frontend-service` (deliberately) so why is it type `NodePort`

18. `minikube ip`
    192.168.49.2

19. Try to visit http://192.168.49.2:30799 but nothing

## Create the Ingress

20. `kubectl apply -f ingress.yml`
    ingress.networking.k8s.io/ingress created

21. `kubectl get ingress -n cloud-tracker`

    ```
    NAME      CLASS    HOSTS   ADDRESS   PORTS   AGE
    ingress   <none>   *                 80      6s
    ```

22. Try to visit http://192.168.49.2 but nothing

23. Research/Suggestions towards a solution:

    - `minikube service frontend-service -n cloud-tracker --url`

    - `kubectl port-forward frontend-deployment-7fc6468f7d-4x2x6 80:30799 -n cloud-tracker`

    - https://minikube.sigs.k8s.io/docs/handbook/accessing/#nodeport-access

    - https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/
