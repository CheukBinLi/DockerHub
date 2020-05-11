FROM centos:latest

MAINTAINER 20796698@qq.com

COPY resources /

ENV version=0.8.4 \
    application=dmanywhere.team \
    port=8080 \
    applicationFullName=$version$application

CMD echo "version:$version" & sh /run.sh

