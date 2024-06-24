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
