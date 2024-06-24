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
