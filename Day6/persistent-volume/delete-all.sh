echo "\n Deleting wordpress ..."
kubectl delete -f wordpress-svc.yml
kubectl delete -f wordpress-deploy.yml
kubectl delete -f wordpress-pvc.yml
kubectl delete -f wordpress-pv.yml

echo "\n Deleting mariadb ..."
kubectl delete -f mariadb-svc.yml
kubectl delete -f mariadb-deploy.yml
kubectl delete -f mariadb-pvc.yml
kubectl delete -f mariadb-pv.yml

kubectl get po,svc,pv,pvc
