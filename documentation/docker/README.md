## Basics
```
docker --version
Docker version 1.12.3, build 6b644ec

docker-compose --version
docker-compose version 1.8.1, build 878cff1

docker-machine --version
docker-machine version 0.8.2, build e18a919
```

## Images

#### Available local images
```
docker images

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos              latest              67591570dd29        7 days ago          191.8 MB
centos              6.8                 0cd976dc0a98        3 months ago        194.5 MB

```

#### Deleting an image
```
docker rmi <image_id>
```

#### downloading an image
```
docker pull centos:6.8

docker images

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos              6.8                 0cd976dc0a98        3 months ago        194.5 MB
```

#### Building image from Dockerfile
```
docker build -t elpis/mycbseguide .

docker images

```


## Containers

#### Running containers
```
docker ps 

CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

#### All running and stopped containers
```
docker ps -a

CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

#### Starting a container
```

```

## Other Commands
```

# verify docker is running
docker run hello-world

# creating a new server
docker run -d -p 80:80 --name webserver nginx

http://localhost/ should show nginx welcome page

docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                         NAMES
675ce55ddb78        nginx               "nginx -g 'daemon off"   2 minutes ago       Up 2 minutes        0.0.0.0:80->80/tcp, 443/tcp   webserver

docker stop webserver
docker start webserver

# deleting docker
docker ps -a
docker rm -f webserver

# deleting docker image
docker images
docker rmi nginx
```

## Getting IP address of docker container
```
docker inspect <container_id> | grep IPAddress | cut -d '"' -f 4
```

## SSH into docker container 
```
docker exec -it memcached bash
```

## Networking
```
setting a unused IP for Mac host which will be used in containers (in linux docker0 interface IP can be used)
Ref: https://docs.docker.com/docker-for-mac/networking/

sudo ifconfig lo0 alias 10.200.10.1/24
```

