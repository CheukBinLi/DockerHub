#!/bin/sh
#description: docker离线安装服务

 cd /apps/docker_server
 nohup python -m SimpleHTTPServer >/dev/null 2>&1 &
