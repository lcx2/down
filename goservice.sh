#!/bin/bash

act=$1

if [ !$1 ]
then
    act=restart
fi


start() {
    echo `pwd`" starting..."
    nohup ./gomock &
}

stop() {
    echo `pwd`" stopping..."
    pid=`pgrep -f gomock`
    echo "gomock pid: $pid"
    kill -9 $pid
}

case "$act" in
    start)
        $1
        exit 0
        ;;
    stop)
        $1
        exit 0
        ;;
    restart)
        stop
        start
        exit 0
        ;;
    *)
        echo "Usage: $0 start|stop"
        echo "$0 start"
        exit 0
        ;;
esac

