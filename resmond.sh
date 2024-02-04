#!/bin/bash

PROC_NAME="resmond"

function resmond_start()
{ 
    if pgrep -x "$PROC_NAME" > /dev/null; then
        echo "Resmond service is already running"
    else
        /usr/local/sbin/resmond || echo "Failed to start resmond service"
    fi
}

function resmond_stop()
{
    if pid=$(pgrep -x "$PROC_NAME"); then
        kill "$pid"
        echo "Stopped resmond service"
    else
        echo "Resmond service is not running"
    fi
}

function main()
{
    case "$1" in
        start)
            resmond_start
        ;;
        stop)
            resmond_stop
        ;;
        *)
            echo "Usage: $0 {start|stop}"
            exit 1
        ;;
    esac
}

main "$@"
