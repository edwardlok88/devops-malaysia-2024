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

## Info - HELM Overview
<pre>
- Helm is a package manager for Kubernetes & Openshift
- the helm packaged application is called chart
- using help package manager, we can install/uninstall/upgrade our application inside Kubernetes/openshift
</pre>

## Lab - Installing helm tool in Linux
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/5ad7c35e-7a50-474e-9594-4af2333a8840)

## Lab - Creating a custom helm chart for wordpress & mariadb multi-pod application
```
cd ~/devops-malaysia-2024
git pull
cd Day7/helm
tree declarative-manifest-scripts
pwd

helm create wordpress
tree wordpress

cd wordpress/templates
rm -rf *
cd ..
echo "" > values.yaml
cat values.yaml

cp declarative-manifest-scripts/*.yml wordpress/templates
tree wordpress
```

You need to update the values.yaml as shown below
<pre>
mariadb_pv_size: 100Mi
mariadb_pv_nfs_path: "/var/nfs/jegan/mariadb"
wordpress_pv_size: 100Mi
wordpress_pv_nfs_path: "/var/nfs/jegan/wordpress"
nfs_server_ip: "192.168.1.108"  
</pre>

You need to copy the values.yml from helm folder to wordpress folder before creating helm chart package
```
cd ~/devops-malaysia-2024
git pull
cd Day7/helm
cp values.yaml wordpress
helm package wordpress
ls -l
```

Installing the wordpress chart into Kubernetes
```
helm install wordpress wordpress-0.1.0.tgz
helm list
kubectl get deploy,po,svc
```
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/2636776c-01f9-4e0e-aa5e-fd7a01926e03)


Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/655faefe-8c9d-4205-8066-9714705aedc3)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/256a565f-4ecd-4435-b7eb-7c975e6f6382)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f0991680-0b77-42ee-a9a9-ed299a1c750a)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/3199c5d0-d79f-42ab-a60f-00f87d69afaa)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/5b91ca0a-abd5-47d9-a518-63a43b7ee5f6)

## Info - What is StatefulSet?
<pre>
- Deployment is meant for stateless applications
- While StatefulSet is meant for deploying stateful applications
- creating multiple replicas of stateless pods is very easy as they are totally independent of each other
- creating multiple replicas of stateful pos like mysql/mariadb pods has to consider many factors
- when we create multiple instances of mysql pod in a statefulset, it create unique names for each mysql Pod 
- For example ( replicas=3 )
  - the first mysql pod will be named as mysql-0
  - the second mysql pod will be named as mysql-1
  - the third mysql pod will be named as mysql-2
- the mysql-1 Pod will be created only after the mysql-0 pod moves to running state
- the mysql-2 Pod will be created only after the mysql-1 pod moves to running state
- the mysql-0 Pod acts a master mysql with read/write permission to the database tables
- the mysql-1 and mysql-2 Pods are slaves of mysql-0 Pod with read only replicas of the data owned by mysql-0 Pod
- but the mysql-1 and mysql-2 Pods has own their copy of the database tables with read only access, but they get synchronized automatically
- the statefulset controller ensures when a mysql pod crashes in let's say worker-1 node, a new Pod with the same name will be created exactly in the same node
- the deployment doesn't provide this kind of assurance
</pre>

