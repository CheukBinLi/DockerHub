FROM centos:latest

MAINTAINER cheukbinli@icloud.com

COPY tool /usr/local/ 
#新BUILD直接复制war包
ONBUILD COPY web /apps/webapp/webroot

ENV WRITE_LOG=false \
    JAVA_HOME=/usr/local/java/jre \
    PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/lib \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

#base config
RUN mkdir -p /apps/webapp/conf && \
    mkdir /apps/webapp/webroot && \
    mkdir /apps/sh && \
    mv /usr/local/run.sh /apps/sh/run.sh &&\
    chmod 755 /apps/sh/run.sh &&\
	chmod +x /apps/sh/run.sh &&\
	chmod +x /usr/local/tomcat/bin/*.sh &&\
    cat /usr/share/zoneinfo/Asia/Shanghai > /etc/localtime && \
	cp -r /usr/local/tomcat/conf /usr/local/tomcat/conf_bak && \
    yum clean all && \
    rm -rf /var/cache/yum

VOLUME /usr/local/tomcat/logs /usr/local/tomcat/conf /apps/webapp/webroot /apps/conf /apps/logs

EXPOSE 8080

ENTRYPOINT /apps/sh/run.sh
