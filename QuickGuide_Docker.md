# QuickGuide | Docker

## Commands

```
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
```

## Dockerfile

##### Dockerfile example

```
FROM Ubuntu

RUN apt-get update
RUN apt-get install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
```

##### Exec form

```
ENTRYPOINT ["executable", "arg1", "arg2"]
CMD ["executable", "arg1", "arg2"]
```

Putting these together the default argument to the container will be:
```
["executable", "arg1", "arg2", "executable", "arg1", "arg2"]
```

Approximates shell command:
```
executable arg1 arg2 executable arg1 arg2
```


##### Shell form

```
ENTRYPOINT executable arg1 arg2
CMD executable arg1 arg2
```


##### Override CMD

```
docker run <> /new/cmd/ arg1 arg2
```

##### Override ENTRYPOINT

```
docker run --entrypoint /new/entrypoint <>
```

##### Override both CMD and ENTRYPOINT

```
docker run --entrypoint /new/entrypoint <> /new/cmd arg1 arg2
```

##### Build

```
docker build Dockerfile -t achopra/my_custom_app
docker history <>
docker history <> --no-trunc
```