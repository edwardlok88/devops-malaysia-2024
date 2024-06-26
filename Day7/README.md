# Day 7

## Lab - Deploying mysql db service without using Persistent Volume
```
cd ~/devops-malaysia-2024
git pull
cd Day6/mysql
kubectl create deployment mysql --image=bitnami/mysql:latest -o yaml --dry-run=client 
kubectl create deployment mysql --image=bitnami/mysql:latest -o yaml --dry-run=client > mysql-deploy.yml

cat mysql-deploy.yml

kubectl apply -f mysql-deploy.yml

kubectl get deploy,po
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/3284c9f4-e029-4495-a459-6368b678f146)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/b47f62b9-387c-417f-a9ab-740848a70064)
