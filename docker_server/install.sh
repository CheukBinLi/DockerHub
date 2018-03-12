#!/bin/bash

tmp=/tmp/tempDownload
HTTP_SERVER=10.16.35.166:8000

root=$(id -u)
if [ $root -ne 0 ]; then
	echo must run as root
	exit 1
fi

checkInstallRpm()
{
	result=$(rpm -qa $1 |grep $1|wc -l)
	echo "$result:$1"
	if [ $result == 0 ]; then
	    rm -rf $tmp/*
		curl -L http://$HTTP_SERVER/rpms/$1.rpm > $tmp/$1.rpm
		#rpm -ivh $tmp/$1.rpm --force --nosignature
		rpm -ivh $tmp/$1.rpm --nosignature
		#rpm -ivh $tmp/$2 --force
	fi
}

checkInstallTar()
{
	result=$(rpm -qa $1 |grep $1|wc -l)
	link=$(ls -a /a 2>/dev/null|wc -l)
	echo "$result:$1"
	if [ $result == 0 ]; then
	    rm -rf $tmp/*
		curl -L http://$HTTP_SERVER/rpms/$2 > $tmp/$2
		mkdir $tmp/$1
		tar -zxvf $tmp/$2 -C $tmp/$1
		cd $tmp/$1
		cd $tmp/$1/$(ls)
		echo $(pwd)
		sh configure --prefix=/opt/gnu/$1
		make && make install
		#ln -s /opt/gun/xz/bin/$1 /usr/local/bin/$1
	fi
}

checkInstall()
{
	mkdir -p $tmp
	
	# declare -A map=(
		# ["libcgroup"]="libcgroup-0.40.rc1-23.el6.x86_64.rpm"
		# ["kernel-headers"]="1_kernel-headers-2.6.32-642.el6.x86_64.rpm"
		# ["libgomp"]="2_libgomp-4.4.7-17.el6.x86_64.rpm"
		# ["libstdc"]="3_libstdc++-devel-4.4.7-17.el6.x86_64.rpm"
		# ["mpfr"]="4_mpfr-2.4.1-6.el6.x86_64.rpm"
		# ["ppl"]="5_ppl-0.10.2-11.el6.x86_64.rpm"
		# ["cloog"]="6_cloog-ppl-0.15.7-1.2.el6.x86_64.rpm"
		# ["cpp"]="6_cpp-4.4.7-17.el6.x86_64.rpm"
		# ["glibc"]="glibc-2.12-1.192.el6.x86_64.rpm"
		# ["glibc-headers"]="8_glibc-headers-2.12-1.192.el6.x86_64.rpm"
		# ["gcc"]="9_gcc-4.4.7-17.el6.x86_64.rpm"
		# ["gcc-c++"]="10_gcc-c++-4.4.7-17.el6.x86_64.rpm"
		# ["device-mapper"]="device-mapper-1.02.117-12.el6.x86_64.rpm"
	# )
	rpm=(
		libcgroup
		kernel-headers
		libgomp
		#libstdc
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
		lua-lxc
		lxc
		lxc-libs
		xz
		docker-io
		#docker-engine-1.7.1-1.el6.x86_64
	)
	
	declare -A tarMap=(
		#["xz"]="xz-5.2.3.tar.gz"
	)
	
	#rpm
	# for key in ${!map[@]}
	# do
		# checkInstallRpm $key ${map[$key]}
	# done
	for i in "${!rpm[@]}"; do
		checkInstallRpm ${rpm[$i]}
	done
	
	#tar
	for key in ${!tarMap[@]}
	do
		checkInstallTar $key ${tarMap[$key]}
	done
	
	service docker start
	
	docker version
	
	echo docker is install success!
	
	rm -rf $tmp
}

main(){
	checkInstall $@
	# if[ $1 -eq "server" ] ; then
		
	# fi
}

main $@


