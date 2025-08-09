#!/bin/bash

user_id=$(id -u)
if [[ $user_id -ne 0 ]]; then
    echo "Please run this script as a root user!"
    exit 1
fi

PATH=/system/bin
packages=$(pm list packages -3 | cut -d: -f2)

force_stop() {
    for package in $packages; do
        if [ $package == "com.termux" ] ; then
            echo "Skipping: ${package}"
           continue;
        else
            echo "Killing: ${package}"
            am force-stop $package
        fi
    done
}


clear_cache() {
    for package in $packages; do
        echo "Clearing: ${package}"
        pm clear --cache-only $package
    done
}  


echo "Welcome to all in one tool (root)
1. Clear Cache
2. Force Stop
0. Exit
"
read -p "Please choose an option: " choice

if [ $choice -eq 0 ]; then
    echo "Bye...!"
elif [ $choice -eq 1 ]; then
    echo "Okay baby clearing cache!"
    clear_cache
elif [ $choice -eq 2 ]; then
    echo "Okay baby force stopp!"
    force_stop
else
    echo "Betichod ye option hi nhi hai!"
fi


