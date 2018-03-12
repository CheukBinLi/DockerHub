#!/bin/bash



catalina="/usr/local/tomcat/bin/catalina.sh"
logcatalina="/usr/local/tomcat/bin/catalina.sh_log"
nologcatalina="/usr/local/tomcat/bin/catalina.sh_no_log"

logbak="/usr/local/tomcat/conf/logging.properties_bak"
log="/usr/local/tomcat/conf/logging.properties"

# echo "system_config"
# echo "[INFO]  tomcat write log ? WRITE_LOG=$WRITE_LOG"
# echo ""
# if [ $WRITE_LOG = "false" ] ; then
	# cat $nologcatalina > $catalina
        # echo "" > $log
# else
	# cat $logcatalina > $catalina
	# cat $logbak > $log
# fi

echo "[INFO] /apps/webapp/webroot directory files:"
echo "$(ls -l /apps/webapp/webroot)"
echo "">>/usr/local/tomcat/logs/catalina.out
echo ""
echo "[INFO] tomcat starting"

tomcatConfig=$(ls /usr/local/tomcat/conf|wc -l)
if [ $tomcatConfig < 1 ] ; then
	cp -r /usr/local/tomcat/conf_bak /usr/local/tomcat/conf
fi

sh /usr/local/tomcat/bin/startup.sh
echo "[INFO tomcat is complete]"
tail -f /usr/local/tomcat/logs/catalina.out
