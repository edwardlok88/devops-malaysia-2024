# Day 3

## Info - Container Orchestration Platform Overview
<pre>
- though we can manually manage the containerized applications, in real world no company directly manages docker or any containerized applications this way
- In industry generally container orchestration platforms are used to manage the containers application workloads
- Orchestration Platform features
  - it provides an environment where you can deploy your application and make it highly availble(HA)
  - in other words, your application will never go down 
  - it also supports in built monitoring features to check the health of your application
  - it can repair your application when it finds your application is not responding, or it crashes etc.,
  - it supports health-check, readiness check, etc.,
  - it also support load-balancing your application workloads
  - it lets you choose who can access your application ie. internal only or external 
  - it also support scale up/down
  - it support rolling update
    - you can upgrade your application from one version to the other without any downtime
    - you can also roll back in case you found any bug in the latest rolled out application version
  - it also supports CI/CD with Tekton serverless
  - you could even run Jenkins within Orchestration platforms
- Examples
  - Docker SWARM
  - Google Kubernetes
  - Red Hat Openshift
  - AWS EKS - Amazon's Elastic Kubernetes Service ( Managed Service by AWS )
  - Azure AKS - Microsoft's Azure Kubernetes Service ( Managed Service by Azure )
  - Google GKS - Google Kubernetes Service ( Managed Service by GCP )
  - AWS ROSA - Amazon's Red Hat Openshift Managed Service 
  - Azure ARO - Microsoft's Red Hat Openshift Managed Service
</pre>

## Lab - Install Kubernetes Minikube

Official website
<pre>
https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download  
</pre>

### Things to note
<pre>
- Minikube is not a production grade Kubernetes setup
- Minikube only supports a single node but we can configure it run multiple nodes 
- it is lightweight setup used in dev/qa environment
- it is also popularly used for learning purpose
- for production use, we need to either setup Kubernetes with multiple master and workers
  - each nodes that we see in Kubernetes could be Physical server or Virtual Machine
  - the Virtual Machine could be running on your datacenter, or public cloud
</pre>  

## Kubernetes Overview
<pre>
- Kubernetes is a Container Orchestration Platform  
- the applications that we intend to run with Kubernetes must be containerized
- this is opensource
- developed by Google in Golang
</pre>

## Demo - Downloading the Minikube setup binary for linux
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

## Demo - Installing Minikube as Docker container
```
minikube start --driver=docker
```


## Demo - Installing Minikube within Oracle Virtual Box as a Virtual Machine
```
minikube start --driver=virtualbox
```
Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/d807f6fb-9bb5-42aa-aefd-d8574aa814cd)


## Info - Pod Overview
<pre>
- Pod is a group of related containers
- application runing inside the container
- one or more containers can run inside a Pod
- IP address is assigned on the Pod level not on the container level
- the containers within the same Pod shares the same IP
- the containers within the same Pod shared the Port range (0-65535) available on the Pod level
- Pod is the smallest unit that can be deployed into Kubernetes
</pre>

## Info - ReplicaSet
<pre>
- When we want to run more than one instance of our application, we can scale up to run multiple Pod instances of our application
- Through Replicaset we can define how many Pod instances you wish to run in the Kubernetes cluster
- ReplicaSet is managed by ReplicaSet controller( Controller Managers -  Control Plane Component )
- Scale up/down is supported by ReplicaSet Controller
- ReplicaSet takes the ReplicaSet as the input and creates so many Pods in the K8s cluster
</pre>

## Info - Deployment
<pre>
- Whenever we deploy our applications into Kubernetes, we generally deploy them as Deployment
- Let's say we wish to deploy nginx web server into Kubernetes, we need to create deployment for nginx
  - this involves creating a nginx deployment
    - this involves creating a nginx replicaset
      - creates one or more Pods
        - one or more containers will be created
        - inside container application will be running
</pre>
