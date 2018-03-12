#!/bin/bash
#set -x
#set -e

config=/apps/conf/shadowsocks.json
dirctory=/apps/conf

init(){
if [ ! -f $config ]; then
   mkdir -p $dirctory
   cat> $config<<EOF
	{
			"server":"0.0.0.0",
			"server_port":$PORT,
			"password":"$PASSWORD",
			"timeout":$TIMEOUT,
			"method":"$METHOD",
			"fast_open":$FAST_OPEN,
			"workers":$WORKERS
	}
EOF
fi
}

main(){
	init
	ssserver -c $config
	ssserver -c $config -d start
	netstat -anput | grep $PORT
}
main $@
