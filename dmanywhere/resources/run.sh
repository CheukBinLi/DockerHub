#!/bin/bash
#set -x
#set -e

main(){
        chmod +x dmanywhere.team.linux.0.8.4
        exec setsid ./dmanywhere.team.linux.0.8.4 -p $port
}
main $@
