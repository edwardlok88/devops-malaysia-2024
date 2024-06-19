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

## Lab - Start/Stop containers
List the running containers
```
docker ps
```

Stopping containers
```
docker stop ubuntu1
docker stop ubuntu2 ubuntu3
docker ps
```

Starting exited containers
```
docker ps
docker ps -a
docker start ubuntu1
docker start ubuntu2 ubuntu3
docker ps
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/83d82487-2782-4cdb-aac9-7ba0c88728ab)

## Lab - Renaming containers and restarting the containers

Renaming containers
```
docker ps
docker rename ubuntu3 c3
docker rename ubuntu2 c2
docker rename ubuntu1 c1
docker ps
```

Restarting containers ( renaming containers doesn't mandate restart containers )
```
docker restart c1
docker restart c2 c3
docker ps
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/baf7c6a1-1b64-4d38-b20d-94784bfd57fb)

## Lab - Deleting containers
We can't delete a running container
```
docker ps
docker rm c3
```

In order to delete a running container, it must be stopped first
```
docker stop c3
docker rm c3
docker ps
docker ps -a
```

We could delete containers forcibly without stopping container optionally
```
docker ps
docker rm -f c1 c2 
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/fff2f8ea-4c67-4f14-b21f-3037e866f4fa)

## Lab - Building Custom Docker Image
```
cd ~/devops-malaysia-2024
git pull
cd Day2/CustomDockerImages
docker built -t tektutor/helloms:1.0 .
docker images
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/c784cf67-d979-4901-aed8-cb73ff15d9c1)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/9fb55d3a-4a44-429e-a5d6-89ea5f549c0e)

Creating a container using the custom docker image we built just now
```
docker images
docker run -d --name hello --hostname hello tektutor/helloms:1.0
docker ps
docker inspect -f {{.NetworkSettings.IPAddress}} hello
curl http://172.17.0.2:8080
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/7f357e89-3305-4fdd-b14b-040d98b3d33d)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/6d5450a1-f4ab-4abf-a17a-5a55022c9aa4)

## Lab - Port forwarding to expose containerized application to remote machines
Let's delete the existing hello container before proceeding
```
docker rm -f hello
```

Let's create a new container with port forwarding
```
docker run -d --name hello --hostname hello -p 9090:8080 tektutor/helloms:1.0
docker ps
```

In the above command, the port 9090 is exposed to the remote machines, whenever requests hits the local machine with IP 192.168.1.104 at port 9090, the request is forwarded to the container at port 8080.

Accessing the containerized application from remote machines, Find the IP address of your machine
```
ifconfig
curl http://192.168.1.104:9090
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f8b4df3c-5e49-4187-bbe0-1c7257d5a734)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/1aa29721-556d-4a55-8088-c75e72ba6eb4)
