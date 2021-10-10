# QuickGuide | Docker

## Commands

```docker
# <> = <container/image name/id>

docker version
docker run docker/whalesay cowsay Hello
docker run nginx
docker ps                     # list all running containers
docker ps -a                  # list all running and stopped containers
docker container ls           # list all running containers
docker container ls --all     # list all running and stopped containers
docker stop <>                # stop a running container
docker rm <>                  # remove a stopped container
docker rm <> --force          # remove a running container
docker images                 # list all downloaded images
docker image ls               # list all downloaded images
docker rmi <>                 # remove downloaded image
docker pull <>                # remove downloaded image
docker run ubuntu             # run a container from image 'ubuntu'
dockder run ubuntu sleep 5    # run a container form image 'ubuntu', then run command 'sleep 5'
docker exec <> cat /etc/hosts # execute command in container
docker exec -it <> /bin/bash  # ssh into a running container
docker run -d <>              # run container in detached mode
docker attach <>              # attach to the running container
docker run redis              # defaults to 'docker run redis:latest'
docker run redis:4.0          # runs container from image of redis version '4.0'
docker run -it redis          # interactive/terminal
docker run -p 8080:80 <>      # map host port to container port
docker run -v /opt/data/dir:/var/lib/mysql mysql # map host volume to container volume
docker inspect <>             # more info than 'docker ps'
docker logs <>                # display stdout
docker run -e APP_CLR=blue <> # export env variable

# search docker hub for official ubuntu image
docker search --filter is-official=true ubuntu

# print SHA256 hash of docker image
docker inspect --format='{{index .RepoDigests 0}}' <image>

```

## Dockerfile

##### Dockerfile example

```dockerfile
FROM Ubuntu

RUN apt-get update
RUN apt-get install python

RUN pip install flask
RUN pip install flask-mysql

# Add files
ADD ./localfile /root/.containerfile

# Copy files from source/host to destination/container
COPY . /opt/source-code

# Set environment variables
ENV HOME /root

# Define working directory
WORKDIR /root

# Shell form
ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
#CMD=

# Exec form
#ENTRYPOINT [ "FLASK_APP=/opt/source-code/app.py", "flask", "run"]
#CMD=

```

##### Exec form

```dockerfile
ENTRYPOINT ["executable", "arg1", "arg2"]
CMD ["executable", "arg1", "arg2"]
```

Putting these together the default argument to the container will be:

```dockerfile
["executable", "arg1", "arg2", "executable", "arg1", "arg2"]
```

Approximates shell command:

```dockerfile
executable arg1 arg2 executable arg1 arg2
```


##### Shell form

```dockerfile
ENTRYPOINT executable arg1 arg2
CMD executable arg1 arg2
```


##### Override CMD

```docker
docker run <> /new/cmd/ arg1 arg2
```

##### Override ENTRYPOINT

```docker
docker run --entrypoint /new/entrypoint <>
```

##### Override both CMD and ENTRYPOINT

```docker
docker run --entrypoint /new/entrypoint <> /new/cmd arg1 arg2
```

##### Build

```docker
docker build Dockerfile -t achopra/my_custom_app
docker history <>
docker history <> --no-trunc
```

## Networking

```docker
docker network ls # list all networks
docker inspect <> # look under NetworkSettings
```

##### Default networks

1. Bridge (default)  
   `docker run ubuntu`
   Container can be mapped to host network
   All containers on a bridge and can talk to each other

2. Host  
   `docker run ubuntu --network=host`
   Containers runs on same network as host

3. None  
   `docker run ubuntu --network=none`
   Containers runs on isolated network

##### User-defined networks

```docker
docker network create \
    --driver bridge \
    --subnet 182.18.0.0/16
    custom-isolated-network
```

##### Embedded DNS

Docker Embedded DNS Server runs at 127.0.0.11

```docker
mysql.connect(<IP>)
OR
mysql.connect(<>)
```

## Storage

##### File System

/var/lib/docker
|--aufs
|--containers
|--images
|--volumes

##### Layered Architecture

Image layer - Read only

Container layer - Read Write

##### Volume Mounts

```docker
# creating local volume
docker volume create data_volume

# volume is created on docker host (default path)
/var/lib/docker
|--volumes
   |--data_volume

# volume mounting host to container
docker run -v data_volume:/var/lib/mysql mysql
```

##### Bind Mounts

```docker
# bind mounting host to container
docker run -v /data/mysql:/var/lib/mysql mysql
```

##### New notation for mounting

```docker
docker run \
    --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql
```

##### Storage Drivers

 - AUFS
 - ZFS
 - BTRFS
 - Device Mapper
 - Overlay
 - Overlay2

## Docker Compose
 
##### Docker Compose Example
 
 ```dockerfile
 services:
    web:
        image: "abhijeetchopra/simple-webapp"
    database:
        image: "mongodb"
    messaging:
        image: "redis:alpine"
    orchestration:
        image: "ansible"
 ```

##### Sample application

1. voting-app: python
2. in-memory DB: redis
3. worker: .net
4. db: postgreSQL
5. result-app: node.js

```dockerfile
# assuming images referenced below are already built and available: 

docker run -d --name=redis redis
docker run -d --name=db postgres:9.4
docker run -d --name=vote -p 5000:80 voting-app
docker run -d --name=result -p 5001:80 result-app
docker run -d --name=worker worker
```

##### Linking 

```dockerfile
... --link <container>:<host>...
```

```dockerfile
# modifying same commands as above with linking 

docker run -d --name=redis redis
docker run -d --name=db --link db:db postgres:9.4
docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
docker run -d --name=result -p 5001:80 result-app
docker run -d --name=worker --link db:db -link redis:redis worker
```

##### Docker Compose from above example

1. Dictionary of container names
2. Image
3. Ports
4. Links

```docker
# docker-compose.yml

redis:
    image: redis
db:
    image: postgres:9.4
vote:
    image: voting-app
    ports:
        - 5000:80
    links:
        - redis
result:
    image: result-app
    ports:
        - 5001:80
    links:
        - db
worker:
    image: worker
    links:
        - redis
        - db
```

##### Building Images from Dockerfiles with Docker Compose

```docker
# docker-compose.yml

redis:
    image: redis
db:
    image: postgres:9.4
vote:
    build: ./vote
    ports:
        - 5000:80
    links:
        - redis
result:
    build: ./result
    ports:
        - 5001:80
    links:
        - db
worker:
    build: ./worker
    links:
        - redis
        - db
```

##### Docker Compose v3

1. Specify version
2. Services
3. Default network is dedicated bridged network instead of a linked default  
   bridged network. No need to specify links as each container is on the same  
   dedicated bridged network and containers can reference by name
4. Dependencies can be specified

```docker
# docker-compose.yml
version: 2
services:
    redis:
        image: redis
    db:
        image: postgres:9.4
    vote:
        build: ./vote
        ports:
            - 5000:80
        depends_on:
            - redis
    result:
        build: ./result
        ports:
            - 5001:80
    worker:
        build: ./worker
```

##### Networks

```docker
# docker-compose.yml
version: 2
services:
    redis:
        image: redis
        networks:
            - back-end
    db:
        image: postgres:9.4
        networks:
            - back-end
    vote:
        build: ./vote
        ports:
            - 5000:80
        depends_on:
            - redis
        networks:
            - front-end
            - back-end
    result:
        build: ./result
        ports:
            - 5001:80
        networks:
            - front-end
            - back-end
    worker:
        build: ./worker
        networks:
            - front-end
            - back-end
networks:
    front-end:
    back-end:
```

##### Docker Compose v3

1. Specify version 3
2. #TODO

# References

 - https://freecodecamp.org
 - https://docs.docker.com
