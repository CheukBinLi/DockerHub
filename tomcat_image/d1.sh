#!/bin/sh
httpd="/etc/httpd/conf/httpd.conf"

if [ ! -x "$httpd" ]; then
   echo "hi"
fi
