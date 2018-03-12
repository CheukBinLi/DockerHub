FROM centos:latest

MAINTAINER 20796698@qq.com

RUN yum install -y epel-release && \
 yum update -y && \
 yum install -y python-setuptools m2crypto supervisor && \
 easy_install pip && \
 pip install shadowsocks && \
 yum clean all && \
 rm -rf /var/cache/yum

COPY run.sh /run.sh

ENV PORT=10086 \
    PASSWORD=qq20796698 \
    TIMEOUT=600 \
    METHOD=aes-256-cfb \
    FAST_OPEN=false \
    WORKERS=2 

VOLUME /apps/conf

CMD echo " port:$PORT password:$PASSWORD method:$METHOD workers:$WORKERS" & sh /run.sh

