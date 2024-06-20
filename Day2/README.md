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


## Lab - Creating mysql database server container with external storage
```
docker rm -f mysql

docker run -d --name mysql --hostname mysql -e MYSQL_ROOT_PASSWORD=root@123 -v /tmp/mysql:/bitnami/mysql/data bitnami/mysql:latest

docker ps
docker logs mysql
```

Get inside the mysql container shell, type 'root@123' as password without quotes
```
docker exec -it mysql sh
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

Though we deleted the container, since we persisted the mysql data in an external volume (storage) we haven't lost the data.

In the below command, the /tmp/mysql folder we need create. The /bitnami/mysql/data folder exists already in mysql container which acts like mountpath.  The mountpath if it is not there, it would created automatically just like how it works in Unix/Linux.

```
mkdir -p /tmp/mysql
chmod 777 /tmp/mysql

docker run -d --name mysql --hostname mysql -e MYSQL_ROOT_PASSWORD=root@123 -v /tmp/mysql:/bitnami/mysql/data bitnami/mysql:latest

docker exec -it mysql sh
mysql -u root -p
SHOW DATABASES;
USE tektutor;
SHOW TABLES;
SELECT * FROM training;
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/127bdb8e-44c7-4a0d-b6d7-ea86c88e3675)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/72e422ec-5c37-48f0-b9ee-66b495d5ff38)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/769a9bd9-91ae-4acc-b7c8-3b634cc5caa1)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/5594fb1d-04ff-4738-8e85-a4ba80568dd4)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/65082fd7-8deb-4ba9-b29c-bd1d21c9c036)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/dfd3d5ed-d435-4b60-b0be-f666a1ab4d4a)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/2bb4b231-514c-4b21-a752-a92c7cb2a49a)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/9c2a13ca-b055-408b-b544-124d2bfc3984)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/a48a04d2-1bf2-40fe-8ec8-a1ff1b61f953)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/0905f6a7-3af9-4ad8-8237-6594652f0ef5)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/394a8b89-4220-4cb1-9d03-0e93b4f3d27b)

## Lab - Deleting a docker image from your local docker registry
```
docker images
docker pull hello-world:latest
docker images
```

Now, let's delete the hello-world:latest docker image from local docker registry
```
docker rmi hello-world:latest
docker images
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/dfd19683-3b25-4e3b-a965-fd14d88766f4)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/38dbb2e0-8a0c-43a0-8a73-c532aa518369)

In case you wish to delete all images from your local docker registry, you may do this
```
docker images -q
docker rmi $(docker images -q)
```

## Lab - Creating a container in the foreground mode
```
docker run -it --name ubuntu1 --hostname ubuntu ubuntu:16.04 /bin/bash
hostname
hostname -i
exit
docker ps -a
```
As we started the ubuntu1 container in interactive/foreground, it will take us inside the container shell immediately.

If you exit the shell inside container, it will terminate the container, as bash is the only application running inside the container.

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/c0c74ff2-0acd-4207-ac4f-58e99bd93bd6)

## Lab - Setting up a Load Balancer using Nginx
![loadbalancer](lb1.png)

Let's remove any currently running containers
```
docker rm -f $(docker ps -aq)
```

Let's create 3 nginx web server containers
```
docker run -dit --name web1 --hostname web1 bitnami/nginx:latest
docker run -dit --name web2 --hostname web2 bitnami/nginx:latest
docker run -dit --name web3 --hostname web3 bitnami/nginx:latest
docker ps
```

Let's create the load balancer container
```
docker run -dit --name lb --hostname lb -p 80:8080 bitnami/nginx:latest
docker ps
```

Let's find the IP addresses of the containers
```
docker inspect -f {{.NetworkSettings.IPAddress}} web1
docker inspect -f {{.NetworkSettings.IPAddress}} web2
docker inspect -f {{.NetworkSettings.IPAddress}} web3
docker inspect -f {{.NetworkSettings.IPAddress}} lb
```

Let's get inside the web1 container to customize the web page
```
docker exec -it web1 sh
ls
cat index.html
exit
```

From the local machine, let's create an index.html file and copy the same on to the containers
```
pwd
echo "Web Server 1" > index.html
docker cp index.html web1:/app/index.html

echo "Web Server 2" > index.html
docker cp index.html web2:/app/index.html

echo "Web Server 3" > index.html
docker cp index.html web3:/app/index.html
```

In order to test if the updated web pages are served by web1, web2 and web containers
```
docker inspect -f {{.NetworkSettings.IPAddress}} web1
curl http://172.17.0.2:8080

docker inspect -f {{.NetworkSettings.IPAddress}} web2
curl http://172.17.0.3:8080

docker inspect -f {{.NetworkSettings.IPAddress}} web3
curl http://172.17.0.4:8080
```

Let's copy nginx.conf file from the lb container to our local machine
```
docker cp lb:/etc/nginx/nginx.conf .
```

Edit the nginx.conf file as shown below
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/f93e0e1f-bf77-4d6a-b923-a0333cc97066)

Save the file and copy it back to the container
```
docker cp nginx.conf lb:/etc/nginx/nginx.conf
```

To apply config changes, we need to restart the lb container
```
docker restart lb
docker ps
```

Expected output
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/95875885-0209-4126-a2d4-b324355c8603)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/836a8eb3-81fe-4305-a53f-4763cbb1c398)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/0adf800a-da10-4fde-8c21-bfa629b26328)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/6fa8c711-5086-457d-a76f-6d9bb91253f9)
![image](https://github.com/tektutor/devops-malaysia-2024/assets/12674043/cce057f4-6798-4900-8b85-81c2e0f5ebbc)
