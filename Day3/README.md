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

## Kubernetes Overview
<pre>
- Kubernetes is a Container Orchestration Platform  
- the applications that we intend to run with Kubernetes must be containerized
- this is opensource
- developed by Google in Golang

</pre>
