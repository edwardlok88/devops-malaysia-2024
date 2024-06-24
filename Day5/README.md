# Day 5

## Lab - Creating a clusterip internal service for nginx deployment

Let's delete the nginx node port service
```
kubectl get svc
kubectl delete svc/nginx
kubectl get svc
```

Let's create the internal clusterip service for nginx deploy
```
kubectl expose deploy/nginx --type=ClusterIP --port=80
kubectl get svc
kubectl describe svc/nginx
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/148ee3c4-8f92-4b2f-a920-44c9fc08a9ea)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/5758b037-2915-4c7a-8656-6ac49d730566)


## Lab - Creating an external Load Balancer service
<pre>
- Load Balancer service is created in case your K8s cluster is running in a public cloud like AWS, Azure, GCP, etct.,
- It won't work in local K8s/Openshift cluster
- In order to make this work in local K8s/Openshift cluster, we need install something called metallb load balancer
</pre>

You may refer my medium blog about creating an external loadbalancer service in K8s cluster
<pre>
https://medium.com/tektutor/using-metal-lb-on-a-bare-metal-onprem-kubernetes-setup-6d036af1d20c  
</pre>

Before we create a load-balancer service, let's delete the existing clusterip service
```
kubectl get svc
kubectl delete svc/nginx
kubectl get svc
```

Let's create the loadbalancer external service
```
kubectl get deploy
kubectl expose deploy/hello --type=LoadBalancer --port=8080
kubectl get svc
kubectl describe svc/hello
```

If you haven't configured the address-pool already for the metallb operator you need to create a yaml file as shown below
```
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.49.100-192.168.49.110
```

You need to run 
```
cd ~/devops-malaysia-2024
git pull
cd Day5/metallb
cat metallb-addresspool.yml
oc apply -f metallb-addresspool.yml
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/b3eab98b-3f76-40ea-a866-1456e3b0a139)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/5ea56818-6849-4af2-8316-a5d4c54cf3ae)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/60c660a9-c529-4dae-8f44-8c07ae96fbc2)


## Lab - Deploying nginx in K8s cluster in declarative style

First let's delete the exixting nginx deployment
```
kubectl delete deploy/nginx svc/nginx
kubectl get deploy,svc
```

It's a good practice to create a namespace for you and deploy all your application inside your namespace
```
kubectl create namespace jegan
kubectl get namespaces
```


Let's auto-generate nginx deployment
```
kubectl create deployment nginx --image=nginx:1.18 --replicas=3 -o yaml --dry-run=client
kubectl create deployment nginx --image=nginx:1.18 --replicas=3 -o json --dry-run=client
kubectl create deployment nginx --image=nginx:1.18 --replicas=3 -o yaml --dry-run=client > nginx-deploy.yml
ls nginx-deploy.yml
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/e4945cb4-86b3-4a81-aaf2-a02f94f37b19)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/c5e7f3a8-dbdf-461b-9543-828a64b86d76)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/2752ec43-ef96-47d7-84b4-5390fb4c5450)


Make sure you have edit the nginx-deploy.yml to reflect your namespace
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/0e6e0b57-5485-4f19-adb3-f0c711128a5b)


Now let's create nginx deployment in declarative style using the yaml manifest scripts
```
kubectl apply -f nginx-deploy.yml
kubectl get deploy -n jegan
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f75e2783-d2d5-4943-8c06-c85bfbfe0172)


Scaling up the nginx deployment in declarative style, edit the nginx-deploy.yml and update the replicas from 1 to 5
```
kubectl apply -f nginx-deploy.yml
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/474a139e-8e4a-4f6f-9925-4fdbd5cdc162)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/13282943-beeb-48e1-9fa5-24debab62b3c)


## Lab - Declarative creating a clusterip internal service for nginx deployment
```
kubectl get deploy -n jegan
kubectl expose deploy/nginx -n jegan --type=ClusterIP --port=80 -o yaml --dry=client
kubectl expose deploy/nginx -n jegan --type=ClusterIP --port=80 -o yaml --dry=client > nginx-clusterip-svc.yml
ls -l
kubectl apply -f nginx-clusterip-svc.yml
kubectl get svc
kubectl describe svc/nginx
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/d6fc9e36-a287-4f84-b230-0aebdafa7404)

Deleting a clusterip service in declarative style
```
kubectl delete -f nginx-clusterip-svc.yml
```
Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/37e0e40e-d9d5-4c53-aa6b-72138385b93b)

## Lab - Creating nodeport service in declarative style

Let's ensure first we delete any nginx service
```
kubectl delete -f nginx-clusterip-svc.yml
kubectl get svc
```

Let's create the nodeport service in declarative style
```
kubectl expose deploy/nginx -n jegan --port=80 --type=NodePort -o yaml --dry-run=client
kubectl expose deploy/nginx -n jegan --port=80 --type=NodePort -o yaml --dry-run=client > nginx-nodeport-svc.yml
ls -l

kubectl apply -f nginx-nodeport-svc.yml
kubectl get svc
kubectl describe svc/nginx
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/780cd2fd-7eae-4c63-b682-ec5d8b52b1cf)
