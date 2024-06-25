# Day 6

## Info - What is Ingress?
<pre>
- Ingress is not a service
- Ingress is a Kubernetes feature that allows us to define forwarding rules
- In Kubernetes cluster, we need to an Ingress Controller, can be Nginx Ingress Controller or HAProxy Ingress Controller
- For Ingress to work in K8s cluster, we need the below components in K8s cluster
  - Ingress (Forwarding rules - defined by us )
  - Ingress Controller
  - Load Balancer ( Nginx or HAProxy )
- Assume the home page my website is http://wwww.tektutor.org
  - Assume the login page of my website is http://www.tektutor.org/login
  - Assume the logout page of my website is http://www.tektutor.org/logout
  - Assume the trainings page of website is http://www.tektutor.org/trainings
</pre>

## Lab - Creating an Ingress Forwarding rules
In case you already don't have nginx deployment, you may deploy as shown below
```
kubectl create deployment nginx --image=nginx:latest --replicas=3
kubectl get deploy,rs,po
kubectl expose deploy/nginx --port=80
kubectl get svc
kubectl describe svc/nginx
```

In case you already don't have hello deployment, you may deploy as shown below
```
kubectl create deployment hello  --image=tektutor/hello:4.0 --replicas=3
kubectl get deploy,rs,po
kubectl expose deploy/hello --port=8080
kubectl get svc
kubectl describe svc/hello
```

Create a file ingress.yml
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tektutor
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: www.tektutor.org
    http:
      paths:
      - path: /nginx
        pathType: Prefix
        backend:
          service:
            name: nginx
            port:
              number: 80

      - path: /hello
        pathType: Prefix
        backend:
          service:
            name: hello 
            port:
              number: 8080
```

Create the ingress in Kubernetes cluster
```
kubectl apply -f ingress.yml
kubectl get ingress
kubectl describe ingress/tektutor
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/ff73a367-645a-4171-873a-a6eb9036b5b9)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/ccb75211-93a2-4699-86bc-ed139f6b6575)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/41b396b9-0d77-4632-8c4e-a25e4e383008)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/46d8a2aa-9058-4544-b297-ad2214734c87)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/631fe285-c0cc-42b6-be95-f1acbcc19683)

## Info - What is Peristent Volume
<pre>
- If your application happens a stateful application, it needs to persistent the data beyond the lifetime of the Pod containers
- In this case, we need to use an external storage usually referred in Kubernetes/Openshift as Persistent Volume (PV)
- the persistent volume storage can come from NFS, AWS S3, AWS EBS, Azure Storage
- Persistent Volume can be provisioned by the System Administrator either manually or using Storage Class dynamically
- the scope of Persistent Volume is cluster wide, so any application running in the cluster on anyname can claim the Persistent Volume if the below criteria matches
- Persistent Volume
  - size in MB/GB
  - type of Storage
  - StorageClass (optional)
  - AccessMode
    - ReadWriteOnce ( All Pods running in same node can access the PV )
    - ReadWriteMany ( All Pods running in any node can access the PV )
</pre>  

## Info - Application that needs external storage will ask K8s for storage?
<pre>
- Any stateful application that needs external storage has to request the K8s/Openshift cluster by defining a Persistent Volume Claim(PVC)
- the PVC has ask for 
  - how much disk space required in MB/GB
  - Access Mode
  - type of Storage (NFS )
  - Storage Class ( optional )
</pre>  

## Info - HELM Overview
<pre>
- Helm is a package manager for Kubernetes & Openshift
- the helm packaged application is called chart
</pre>

