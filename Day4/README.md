# Day 4

## Info - Kubernetes Control Plane Component
<pre>
- API Server
- etcd key-value datastore
- controller managers
- scheduler
</pre>

## Info - API Server
<pre>
- API Server supports REST API's for all the Kubernetes features
- API stores the application status and the kubernetes cluster status into the etcd database
- generally, only API Server will have access to etcd database
- API runs a Pod in the master node(s)
- Whenever  
  - new record is added into etcd
  - existing record is edited in etcd
  - existing record is deleted from etcd
  - API Server will send broadcasting events about the change in etcd
    - New Deployment created
    - New ReplicaSet created
    - New Pod created
    - Pod Scheduled
</pre> 

## Info - etcd database
<pre>
- opensource database project that can be used outside the scope of Kubernetes/Openshift
- it stores data in the form of key/value pairs
- given a key, it can retrieve the data
- given a key, it can updata/delete data
- runs as a Pod in every master node
</pre>  

## Info - Controller Managers
<pre>
- it is a collection of many controllers
- is a Pod that runs in every master node
- controller job is manage resources
- each controller manages a single resources
- For example, 
  - Deployment Controller manages Deployment Resource
  - ReplicaSet Controller manages ReplicaSet Resource
  - Whenever a new Deployment is created, the Deployment Controller will recive an event from API Server, based on that event, it will create a ReplicaSet to manage the Pod
  - Whenever a new ReplicaSet is created, the ReplicaSet controller will receive an event from API Server, based on that event, it will create Pods

- Examples
  - Deployment Controller
  - ReplicaSet Controller
  - Job Controller
  - CronJob Controller
  - DaemonSet Controller
  - StatefulSet Controller
  - Endpoint Controller
  - Storage Controller
</pre>  

## Info - Scheduler
<pre>
- is a Pod that runs in every master node
- Scheduler is the one which decides where a new Pod should be deployed
- Scheduler when it receives new Pod created event, it finds a healthy node where the new Pod can be deployment
- Scheduler can't deploy a pod directly, hence it will send its scheduling recommendations to the API server via a REST call
- API updates the scheduling recommendation in the respective Pod record stored in the etcd database
</pre>

## Info - What happens when we deploy our application into Kubernetes ?
When we issue the below command
```
kubectl create deployment nginx --image=nginx:latest --replicas=3
```

<pre>
- kubectl client tool sends a REST call to API server requesting for new Deployment by name nginx to be created
- API Server, receives the REST call from kubectl, it then creates a nginx deployment record in etcd datastore
- API Server, then sends a broadcasting event that a new Deployment is created
- Deployment Controller receives the new Deployment created event, it then sends a REST call to API Server requesting it to create a ReplicaSet for the nginx deployment
- API Server will create a ReplicaSet record in etcd database and sends a broadcasting event like New ReplicaSet created
- ReplicaSet Controller receives the new ReplicaSet created event, it then makes REST calls to API server to create New Pod entries 
- API Server will create New Pod and sends a broadcasting event for each Pod it has created in etcd database
- the new pod created event is received by Scheduler, it then sends it scheduling recommendation on where each Pod can run to the API server via REST call
- API server, retrieves the Pod existing in etcd database and it updates the scheduling recommendation it received from Scheduler
- API Server will send broadcasting event saying Pod scheduled to node so and so
- The kubelet container agent which runs in every node will receive the event from API Server, it then downloads the container image and creates container with that image and reports the status back to API server via REST call
- Api server updates the status of the Pod once all the container that are part of the Pod are in running status
</pre>

## Lab - How Pods are created by Kubernetes - let's understand using plain docker

First we need to create a pause container
```
docker run -d --name nginx_pause --hostname nginx registry.k8s.io/pause:3.9
docker ps
docker inspect -f {{.NetworkSettings.IPAddress}} nginx_pause
```

Next, let's create the application container
```
docker run -d --name nginx --network=container:nginx_pause nginx:latest
docker ps
```

Let's get inside the nginx container shell to check its IP address, hostname, etc.,
```
docker exec -it nginx sh
hostname
hostname -i
ls
exit
```

If you notice, you would have observed that the nginx container reports the hostname assigned to the nginx_pause container and it also reports the IP address of the nginx_pause container.  

Any time we create container, it get its own network stack and software defined network card.  Any container that has network card whether hardware or software defined network card it gets an IP Address.

This is how, the nginx_pause container got its IP address, the nginx container we ensured it doesn't have its own software defined network card, also we connect nginx container with nginx_pause container's network. That's how Kubernetes creates a group of container that share their network, ports, hostname etc.

Pod is just a logical concept, when we deploy application only containers will be created in the nodes and they are mapped to a Pod record that resides in the etcd database.

## Lab - Scale up/down - adding additional Pod instances in a deployment

Listing deployments
```
kubectl get deployments
kubectl get deployment
kubectl get deploy
```

Listing replicasets
```
kubectl get replicasets
kubectl get replicaset
kubectl get rs
```

Listing pods
```
kubectl get pods
kubectl get pod
kubectl get po
```
Listing many resources with single command
```
kubectl get deploy,rs,po
kubectl get po,rs,deploy
kubectl get rs,po
```

Scale up the pod counts
```
kubectl scale deploy/nginx --replicas=5
kubectl get po -w
```

Scale down the pod counts ( to come out of the watch mode, press Ctrl + c )
```
kubectl scale deploy/nginx --replicas=3
kubectl get po -w
```

## Lab - Getting inside a Pod shell
```
kubectl get pods
kubectl exec -it nginx-89877bb6d-rlfgk sh
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/85167b37-6e92-438e-a8c6-ff4f7f9a91a3)


## Lab - Port forward ( Use only for testing, not used in production )
```
kubectl get po
kubectl port-forward nginx-89877bb6d-rlfgk 9090:80
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/50582e7d-3c30-482d-9ed2-c8f989a88d52)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/bf4d60de-85b3-49d8-b914-4ae812d9f1cc)


## Lab - Deleting a deployment
```
kubectl get deploy
kubectl delete deploy/nginx
kubectl get deploy,rs,po
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/de6da31c-1c39-4d25-8ca6-f86cbd15a125)


## Lab - Rolling update ( upgrading your application to latest version without any downtime )

Let's deploy nginx 
```
kubectl create deployment nginx --image=nginx:1.18 --replicas=3
kubectl get deploy,rs,po
kubectl get deployment nginx
kubectl get deployment nginx -o yaml
```

Let's perform rolling update by updating the image version to 1.19
```
kubectl set image deploy/nginx nginx=nginx:1.19
kubectl get rs
kubectl get po
```

Let's check the image version used by the new pods after rolling update
```
kubectl get pod/nginx-59d59d94c-q7w2s -o yaml | grep nginx:1.19
```
Let's check the image version used by the old replicaset
```
kubectl get rs/nginx-89877bb6d -o yaml | grep nginx:1.18
```
Let's check the image verison used by the new replicaset
```
kubectl get rs/nginx-59d59d94c -o yaml | grep nginx:1.19
```

Rolling back to older image
```
kubectl rollout undo deploy/nginx
```

Let's check the image used by the pod
```
kubectl get rs/nginx-89877bb6d -o yaml | grep nginx:1.18
kubectl get pod/nginx-89877bb6d-2hg65 -o yaml | grep image
```
Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/ee52b56b-ac99-433f-baae-a5d69bd97bd9)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/32a14f36-2e8c-4307-a588-1f2fb4c17f22)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/d8521738-dfe6-4bfc-b3ae-cebd70dbb67b)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/529e2cd8-d2ee-41d6-8017-ca5c690cb206)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/5f75efe5-0ad4-4f5f-a4a9-98388216ac8d)

## Lab - Creating an external NodePort service for nginx deployment
```
kubect get deployment
kubectl get services
kubectl get service
kubectl get svc
```

Let's create the nodeport service for nginx deployment
```
kubectl expose deploy/nginx --port=8080 --type=NodePort
kubectl get svc
kubectl describe svc/nginx
```

Accessing the NodePort from outside the Kubernetes cluster
```
minikube ip
curl http://192.168.49.2:32260
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/20138ee1-5f2f-4fc2-b906-153efb317eda)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/12ff3651-7281-4394-9237-3a640f17c365)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/c689f9fc-efbc-4f12-aa18-08d84e2dd138)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f8f1df6e-292f-4ad3-92ae-6b8728aae886)
