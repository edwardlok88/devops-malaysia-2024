# Day 6

## Info - What is Ingress?
<pre>
- Ingress is not a service
- Ingress is a Kubernetes feature that allows us to define forwarding rules
- In Kubernetes cluster, we need to an Ingress Controller, can be Nginx Ingress Controller or HAProxy Ingress Controller
- For Ingress to work in K8s cluster, we need the below components in K8s cluster
  - Ingress (Forwarding rules - defined by us )
  - Ingress Controller
  - Load Balancer ( Nginx or HAProxy )
- Assume the home page my website is http://wwww.tektutor.org
  - Assume the login page of my website is http://www.tektutor.org/login
  - Assume the logout page of my website is http://www.tektutor.org/logout
  - Assume the trainings page of website is http://www.tektutor.org/trainings
</pre>

## Lab - Creating an Ingress Forwarding rules
In case you already don't have nginx deployment, you may deploy as shown below
```
kubectl create deployment nginx --image=nginx:latest --replicas=3
kubectl get deploy,rs,po
kubectl expose deploy/nginx --port=80
kubectl get svc
kubectl describe svc/nginx
```

In case you already don't have hello deployment, you may deploy as shown below
```
kubectl create deployment hello  --image=tektutor/hello:4.0 --replicas=3
kubectl get deploy,rs,po
kubectl expose deploy/hello --port=8080
kubectl get svc
kubectl describe svc/hello
```

Create a file ingress.yml
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tektutor
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: www.tektutor.org
    http:
      paths:
      - path: /nginx
        pathType: Prefix
        backend:
          service:
            name: nginx
            port:
              number: 80

      - path: /hello
        pathType: Prefix
        backend:
          service:
            name: hello 
            port:
              number: 8080
```

Create the ingress in Kubernetes cluster
```
kubectl apply -f ingress.yml
kubectl get ingress
kubectl describe ingress/tektutor
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/ff73a367-645a-4171-873a-a6eb9036b5b9)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/ccb75211-93a2-4699-86bc-ed139f6b6575)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/41b396b9-0d77-4632-8c4e-a25e4e383008)

![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/46d8a2aa-9058-4544-b297-ad2214734c87)

