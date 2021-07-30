FROM ubuntu

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install vim curl -y

RUN unlink /etc/nginx/sites-enabled/default

COPY ./container_start.sh /
COPY ./my-website.local /var/www/my-website.local
COPY ./my-website.local.conf /etc/nginx/conf.d/

EXPOSE 80

CMD /container_start.sh

