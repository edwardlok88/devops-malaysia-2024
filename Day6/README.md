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

## Lab - Deploying wordpress and mariadb multi-pod application
First, let's deploy mariadb with Persistent Volume external storage coming from Remote NFS Server
```
cd ~/devops-malaysia-2024
git pull
cd Day6/persistent-volume
kubectl apply -f mariadb-pv.yml
kubectl get persistentvolumes
kubectl get persistentvolume
kubectl get pv

kubectl apply -f mariadb-pvc.yml
kubectl get persitentvolumeclaims
kubectl get persitentvolumeclaim
kubectl get pvc
```

Let's create the mariadb deployment
```
cd Day6/persistent-volume
kubectl apply -f mariadb-deploy.yml
```

Let's create mariadb service
```
cd Day6/persistent-volume
kubectl apply -f mariadb-svc.yml
kubectl get services
kubectl get service
kubectl get svc
kubectl describe svc/mariadb
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/e6547b63-6fbb-47b6-82ee-497f4abc4b1e)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/8f63eedd-3d9f-4c67-903e-6f1bd03c4b74)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/59bd2833-c04b-44fd-9a0f-307b1926ec4d)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f2119b1a-b312-452e-a20b-c2d4daf30982)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f633ca12-a1d2-4194-aec2-33d4861ab67f)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/b6aa9eec-ffa3-4a0c-a467-af3a02e23942)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/7957564c-88a6-4157-b9d2-c95bab51a320)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/9f53b296-dd15-4948-a457-0698475e2da3)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/7e045506-4443-4dab-b5d9-11cb4a4fb765)

Let's deploy wordpress
```
cd ~/devops-malaysia-2024
git pull
cd Day6/persitent-volume

kubectl apply -f wordpress-pv.yml
kubectl apply -f wordpress-pvc.yml
kubectl apply -f wordpress-deploy.yml
kubectl apply -f wordpress-svc.yml

kubectl get pv,pvc,po,svc
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/e2286cdc-cdfe-41b6-ac27-cb85f2b91e40)



## Info - HELM Overview
<pre>
- Helm is a package manager for Kubernetes & Openshift
- the helm packaged application is called chart
</pre>

