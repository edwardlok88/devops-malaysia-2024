# Day 2

## Lab - Deleting all containers irrespective of their running state
```
docker rm -f $(docker ps -aq)
```

## Lab - Finding IP address of a running container
Let's create 3 ubuntu containers using ubuntu:16.04 docker image from Docker Hub Remote Registry
```
docker run -dit --name ubuntu1 --hostname ubuntu1 ubuntu:16.04 /bin/bash
docker run -dit --name ubuntu2 --hostname ubuntu2 ubuntu:16.04 /bin/bash
docker run -dit --name ubuntu3 --hostname ubuntu3 ubuntu:16.04 /bin/bash
```

Listing the currently running containers
```
docker ps
```

Listing all the container irrespective of their running states
```
docker ps -a
```

Finding the IP address of the containers
```
docker inspect ubuntu1 | grep IPA
docker inspect -f {{.NetworkSettings.IPAddress}} ubuntu1
docker inspect -f {{.NetworkSettings.IPAddress}} ubuntu2
docker inspect -f {{.NetworkSettings.IPAddress}} ubuntu3
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/c0c3d56e-c865-4022-a9f2-8158e9a18ba3)

## Lab - Getting inside a running container shell
```
docker ps
docker exec -it ubuntu1 /bin/bash
hostname
hostname -i
ls
whoami
exit
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/6337cb73-da2e-4735-9c54-dd4a315cd856)
