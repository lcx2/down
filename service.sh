#!/bin/bash

jarFile='./bin/ug-manager-xstarter-1.0.0.jar'
profileActive="$1"

start() {
	echo `pwd`" starting..."
	if [ ! -f "run.pid" ]
        then
            touch run.pid
        fi
	pid=`cat run.pid`
	if [ -z "$pid" ]
	then
		export JAVA_OPTS="-Xms256m -Xmx1024m"
		java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -Dlog4j2.formatMsgNoLookups=true -jar $jarFile --spring.profiles.active=$profileActive
		echo $! > run.pid
	fi
}

stop() {
	echo `pwd`" stopping..."
	pid=`cat run.pid`
	if [ -n "$pid" ]
	then
		while [ 1 ]
		do
		    echo "stop $pid..."
		    kill $pid
                    sleep 3
                    check_pid=`ps -ef | grep $pid | grep -v grep | wc -l`
                    if [ $check_pid == 0 ]
                    then
                        break
                    fi
		done
		echo '' > run.pid
	fi
}

case "$2" in
	start)
		$2
		exit 0
		;;
	stop)
		$2
		exit 0
		;;
	*)
		echo 'Usage: cmd name start|stop'
		echo 'service.sh dev start'
		exit 0
		;;
esac
