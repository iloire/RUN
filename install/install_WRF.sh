#!/bin/bash

. env.sh

echo "===== Building WRF ====="
cd $BASEDIR/WRF
echo "when asked select 34. (dmpar) for GNU (gfortran/gcc)"
echo "and select nesting: 1=basic"
./configure > $FOLDER_LOGS/wrf_configure.log
echo "===== compiling WRF..."
./compile em_real > $FOLDER_LOGS/wrf_compile.log

