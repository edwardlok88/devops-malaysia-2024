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
