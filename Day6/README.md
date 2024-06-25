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
