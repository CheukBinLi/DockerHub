FROM docker.io/nginx:latest

MAINTAINER bin "cheukbinli@icloud.com"

VOLUME /etc/nginx/conf

ENV NGINX_CONF=nginx.conf

EXPOSE 80

RUN rm -rf /etc/init.d/nginx
RUN rm -rf /etc/init.d/nginx-debug

RUN mkdir -p /etc/nginx/conf

COPY run.sh /run.sh

RUN cat /usr/share/zoneinfo/Asia/Shanghai > /etc/localtime
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN chmod 755 run.sh

CMD sh run.sh

#RUN cat /etc/nginx/nginx.conf > /etc/nginx/conf/nginx.conf

#CMD nginx -c /etc/nginx/conf/$NGINX_CONF -g 'daemon off;'
