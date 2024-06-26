echo "\n Deploying mariadb ..."
kubectl apply -f mariadb-pv.yml
kubectl apply -f mariadb-pvc.yml
kubectl apply -f mariadb-deploy.yml
kubectl apply -f mariadb-svc.yml

echo "\n Deploying wordpress ..."
kubectl apply -f wordpress-pv.yml
kubectl apply -f wordpress-pvc.yml
kubectl apply -f wordpress-deploy.yml
kubectl apply -f wordpress-svc.yml

kubectl get po,svc,pv,pvc
