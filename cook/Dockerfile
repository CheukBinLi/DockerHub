#参数：    EN
#        PROJECT_PATH 子项目目录;   
#        PROFILES profile版本
#        VM :vm argumnet

FROM docker.io/fdisk123/jre-full:8

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

COPY *.jar /App.jar

EXPOSE 80

CMD /usr/local/java/bin/java -jar $VM -Dspring.profiles.active=$PROFILES,$PROFILES-redis,$PROFILES-jdbc,$PROFILES-other /App.jar