FROM centos:latest

MAINTAINER cheukbinli@icloud.com

RUN yum install -y epel-release && \
 yum update -y && \
 yum install -y python-setuptools m2crypto supervisor && \
 easy_install pip && \
 pip install shadowsocks && \
 yum clean all && \
 rm -rf /var/cache/yum
