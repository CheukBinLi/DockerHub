#参数：    EN
#        PROJECT_PATH 子项目目录;   
#        PROFILES profile版本
#        VM :vm argumnet

FROM docker.io/centos:latest

COPY jdk-19_linux-x64_bin.tar.gz /app/

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo 'Asia/Shanghai' >/etc/timezone \
&& cd /app  \
&& tar -xvf 'jdk-19_linux-x64_bin.tar.gz' \
&& mv jdk-19.0.2 java \
&& rm -rf jdk-19_linux-x64_bin.tar.gz \
&& echo -e  "\nexport JAVA_HOME=/app/java \nexport CLASSPATH=.\$JAVA_HOME/lib \nexport PATH=\$JAVA_HOME/bin:\$PATH ">/etc/profile.d/env.sh 
