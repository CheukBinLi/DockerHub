#参数：    EN
#        PROJECT_PATH 子项目目录;   
#        PROFILES profile版本
#        VM :vm argumnet

FROM redis
COPY redis.conf /usr/local/etc/redis/redis.conf
ENV REDIS_PORT=6379 \
    REDIS_MASTERAUTH=123456 \
    REDIS_REQUIREPASS=123456 \
    REDIS_CLUSTER_ANNOUNCE_IP=127.0.0.1 \
    REDIS_CLUSTER_ANNOUNCE_PORT=7001 \
    REDIS_CLUSTER_BUS_PORT=7001 \
    REDIS_APPENDONLY=yes

CMD sed -i 's/REDIS_PORT/'$REDIS_PORT'/g' /usr/local/etc/redis/redis.conf & \
	sed -i 's/REDIS_MASTERAUTH/'$REDIS_MASTERAUTH'/g' /usr/local/etc/redis/redis.conf & \
	sed -i 's/REDIS_REQUIREPASS/'$REDIS_REQUIREPASS'/g' /usr/local/etc/redis/redis.conf & \
	sed -i 's/REDIS_CLUSTER_ANNOUNCE_IP/'$REDIS_CLUSTER_ANNOUNCE_IP'/g' /usr/local/etc/redis/redis.conf & \
	sed -i 's/REDIS_CLUSTER_ANNOUNCE_PORT/'$REDIS_CLUSTER_ANNOUNCE_PORT'/g' /usr/local/etc/redis/redis.conf & \
	sed -i 's/REDIS_CLUSTER_BUS_PORT/'$REDIS_CLUSTER_BUS_PORT'/g' /usr/local/etc/redis/redis.conf & \
	sed -i 's/REDIS_APPENDONLY/'$REDIS_APPENDONLY'/g' /usr/local/etc/redis/redis.conf & \
	echo $REDIS_APPENDONLY' & \
	redis-server /usr/local/etc/redis/redis.conf \