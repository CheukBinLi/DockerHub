FROM docker.io/centos:latest

#MAINAINTER cheukbinli@icloud.com

USER root

RUN cat /usr/share/zoneinfo/Asia/Shanghai > /etc/localtime
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /apps/sh

COPY sh /apps/sh/

RUN yum install -y httpd

RUN mkdir -p /var/www/html

RUN  echo "test"> /var/www/html/index.html

RUN sed -i "s|#ServerName www.example.com:80|ServerName 127.0.0.1:80|g" /etc/httpd/conf/httpd.conf

#RUN sed -i "s|/var/www|/apps/webapp|g" /etc/httpd/conf/httpd.conf

#RUN echo "<Directory \"/apps/webapp/html\">" >>/etc/httpd/conf/httpd.conf
#RUN echo "    Options Indexes FollowSymLinks" >>/etc/httpd/conf/httpd.conf
#RUN echo "    AllowOverride None" >>/etc/httpd/conf/httpd.conf
#RUN echo "    Order allow,deny" >>/etc/httpd/conf/httpd.conf
#RUN echo "    Allow from all" >>/etc/httpd/conf/httpd.conf
#RUN echo "</Directory>" >>/etc/httpd/conf/httpd.conf

VOLUME /etc/httpd/conf/ /apps/webapp/html/ /var/www/html/

EXPOSE 80

CMD  ls /var/www/html && sh /apps/sh/run.sh
