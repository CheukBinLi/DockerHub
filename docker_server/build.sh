#!/bin/bash
#set -e

tmp=/tmp/tempDownload
dockerVersion=docker
params=""

operation=build
server=10.16.35.166:8000
currentPath=
application=
port=
tomcatLog=null
logs=null
config=null
tomcatConf=null
warName=null
newWarName=null

checkInstallRpm()
{
	#if [ $(sudo rpm -qa|grep $1|wc -l) -eq 0 ]; then
		rm -rf $tmp/*
		curl -L http://$server/rpms/$1.rpm > $tmp/$1.rpm
		sudo rpm -ivh $tmp/$1.rpm --nosignature
	#fi
}

InstallRpm()
{
	#if [ $(sudo rpm -qa|grep $1|wc -l) -eq 0 ]; then
		sudo rpm -ivh rpms/$1.rpm --nosignature
	#fi
}

checkInstall()
{
	mkdir -p $tmp
	rpm=(
		libcgroup
		kernel-headers
		libgomp
		libstdc
		mpfr
		ppl
		cloog-ppl
		cpp
		glibc
		glibc-headers
		gcc
		device-mapper
		lua-alt-getopt
		lua-filesystem
		lxc
		lxc-libs
		lua-lxc		
		xz
		docker-io

	)
	for i in "${!rpm[@]}"; do
		if [ "$operation" = "install" ] ; then
			InstallRpm ${rpm[$i]}
		else
			checkInstallRpm ${rpm[$i]}
		fi
	done
	
	service docker start
	
	docker version
	
	echo docker is install success!
	
	rm -rf $tmp
}

fillParams()
{
	if [ "$tomcatLog" != "" ] && [ "$tomcatLog" != "null" ] ; then
			params=$params" -v "$tomcatLog":/usr/local/tomcat/logs "
	fi
	if [ "$logs" != "" ] && [ "$logs" != "null" ] ; then
			params=$params" -v "$logs":/apps/logs "
	fi
	if [ "$config" != "" ] && [ "$config" != "null" ] ; then
			params=$params" -v "$config":/apps/conf "
	fi
	if [ "$tomcatConf" != "" ] && [ "$tomcatConf" != "null" ] ; then
			params=$params" -v "$tomcatConf":/usr/local/tomcat/conf "
	fi
}

checkImage()
{
	if [ $(sudo docker ps -a|grep $application|wc -l) -ne 0 ] ; then
		sudo docker rm -f $(sudo docker ps -a |grep $application|awk '{print $1}')
	fi

	if [ $(sudo docker images |grep $application|wc -l) -ne 0 ] ; then
		sudo docker rmi -f $(sudo docker images|grep $application|awk '{print $1}')
	fi
}


build(){
	if [ "$application" = "" ] ; then
        echo application is null
        exit 1
	fi
	if [ "$port" = "" ] ; then
			echo port is null
			exit 1
	fi
	
	cd $currentPath
	
	fillParams 
	
	checkImage
	
	mkdir -p image/web
	echo "FROM basetomcat:latest">image/Dockerfile

	if [ "$warName" = "" ] || [ "$warName" = "null" ] ; then
			warName=$(ls -1 $application/target|grep ".war"|awk '{print $NF}')
	fi

	if [ "$newWarName" = "" ] || [ "$newWarName" = "null" ] ; then
			newWarName=$warName
	fi

	cp $application/target/$warName image/web/$newWarName

	docker build -t $application image/
	echo exporting image.
	rm -rf image
	docker save $application> $application.tar
	echo export success.
}

run()
{
	if [ "$application" = "" ] ; then
        echo application is null
        exit 1
	fi
	if [ "$port" = "" ] ; then
			echo port is null
			exit 1
	fi
	
	fillParams 
	
	checkImage

	cd $currentPath
        echo $(pwd)
	echo importing images.
	sudo docker load <"$application.tar"
	echo import success.
	echo params:$params

	sudo docker run -d --name=$application -u root --privileged=true -p $port:8080 $params $application
	rm -rf $application.tar
}

clean()
{
	
	rm -rf $currentPath/image
	rm -rf *.tar
}

main()
{
	sudo su
	operation=$1
	server=$2
	currentPath=$3
	application=$4
	port=$5
	if [  $# -ge 6 ] ; then
		tomcatLog=$6
	fi
	if [  $# -ge 7 ] ; then
		logs=$7
	fi
	if [  $# -ge 8 ] ; then
		config=$8
	fi
	if [  $# -ge 9 ] ; then
		tomcatConf=$9
	fi
	if [  $# -ge 10 ] ; then
		warName=${10}
	fi
	if [  $# -ge 11 ] ; then
		newWarName=${11}
	fi
	for i in {0..1}
		do
		if [ $(rpm -qa|grep $dockerVersion|wc -l) -eq 0 ] ; then
			checkInstall $dockerVersion
		fi
	done
	if [ "$operation" = "run" ] ; then
		echo run image
		run 
	elif [ "$operation" = "build" ] ; then
		echo build image
		build 
	elif [ "$operation" = "clean" ] ; then
		echo clean
		clean
	elif [ "$operation" = "install" ] ; then
		sudo docker load < image/basetomcat.tar
		echo install success
		exit 1
	fi
}

main $@
