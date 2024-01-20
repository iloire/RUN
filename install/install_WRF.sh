#!/bin/bash

. env.sh

echo "===== Building WRF ====="
cd $BASEDIR/WRF
echo "===== compiling WRF..."
./compile em_real > $FOLDER_LOGS/wrf_compile.log

