# Day 2

## Lab - Installing ifconfig and ping command in Windows Ubuntu WSL
```
sudo apt update
sudo apt install -y net-tools iputils-ping
```

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
192.168.1.104
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
docker build -t tektutor/helloms:1.0 .
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

## Lab - Creating mysql container and running it in background
```
docker images
docker run -d --name mysql --hostname mysql bitnami/mysql:latest
```

List and check if the mysql container is running
```
docker ps
```

The mysql container doesn't seem to be running, hence let's list all containers
```
docker ps -a
```

Let's check the mysql container log to troubleshoot
```
docker logs mysql
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/552256b2-a035-4f52-80fa-dc4b688c3972)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f0bb103d-6360-4b1e-9233-61d3931f8f38)

Let's create the mysql container suppling the root password as environment variable
```
docker run -d --name mysql --hostname mysql -e MYSQL_ROOT_PASSWORD=root@123 bitnami/mysql:latest
docker ps
docker logs -f mysql
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/9fa770c7-826b-4e37-ab86-0f10f1eb062f)

Getting inside the mysql container shell
```
docker exec -it mysql sh
ls
mysql -u root -p

SHOW DATABASES;
CREATE DATABASE tektutor;
USE tektutor;
SHOW TABLES;
CREATE TABLE training ( id INT NOT NULL, name VARCHAR(200) NOT NULL, duration VARCHAR(200) NOT NULL, PRIMARY KEY(id) );

INSERT INTO training VALUES ( 1, "DevOps", "5 Days" );
INSERT INTO training VALUES ( 2, "Microservices with golang", "5 Days" );
INSERT INTO training VALUES ( 3, "Advanced Openshift", "5 Days" );

SELECT * FROM training;
DESCRIBE training;
exit
exit
```

Let's delete the mysql container
```
docker ps
docker rm -f mysql
```

At this point, we not only delete the mysql container we also deleted the 'tektutor' database and the training table along with all records.  This is due to the reason we used container internal storage which is bad practice.  The training table data ideally has a long life time compared to the container life time, hence we should rely the container storage, instead we should use an external storage to persist the data permanently.

Container are treated as temporary resource, hence though it is possible to store data internally, we aren't supposed to store application data in the container internal storage.

Hence we should use external disk volume.


Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/aea24105-6a8c-4001-8330-22ed6a66e8bb)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/781232ef-af44-4dad-afd4-cc43fa059dfd)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/a06c802a-c2d3-4231-a6fa-f8d1d0c940c8)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/8d90ff06-79d1-4fbf-adc8-1d6d5da94ad1)
