#!/bin/bash

. env.sh

echo "===== Building WPS ====="
cd $BASEDIR/WPS
./clean
echo "when asked select option 1.  Linux x86_64, gfortran (serial)"
echo "it is recommended to use serial regardless of the selection in WRF"
./configure > $FOLDER_LOGS/wps_configure.log
echo "===== compiling WPS..."
./compile > $FOLDER_LOGS/wps_compile.log

ls -ls *.exe
ls -ls geogrid/src/geogrid.exe
ls -ls metgrid/src/metgrid.exe
ls -ls ungrib/src/ungrib.exe
