FROM ubuntu

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y nginx

EXPOSE 80

COPY ./container_start.sh /

CMD /container_start.sh

