#!/bin/bash

. env.sh

echo "===== Building WPS ====="
cd $BASEDIR/WPS
./clean
echo "===== compiling WPS..."
./compile > $FOLDER_LOGS/wps_compile.log

ls -ls *.exe
ls -ls geogrid/src/geogrid.exe
ls -ls metgrid/src/metgrid.exe
ls -ls ungrib/src/ungrib.exe
