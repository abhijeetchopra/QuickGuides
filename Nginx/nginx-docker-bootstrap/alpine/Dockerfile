FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add nginx

EXPOSE 80

COPY ./container_start.sh /

CMD /container_start.sh

