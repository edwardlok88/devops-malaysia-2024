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
  
</pre>
