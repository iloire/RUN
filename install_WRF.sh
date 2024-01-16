#!/bin/bash

echo " === FOLDER: $FOLDER_INSTALL"
mkdir -p $FOLDER_INSTALL

. env.sh

# Building WRF

echo "===== Building WRF ====="
cd $FOLDER_INSTALL
git clone https://github.com/wrf-model/WRF
cd WRF
echo "when asked select 34. (dmpar) for GNU (gfortran/gcc)"
echo "and select nesting: 1=basic"
./configure
echo "===== compiling WRF..."
./compile em_real
ls -ls main/*.exe

echo "===== Building WPS ====="
# Building WPS
cd $FOLDER_INSTALL
git clone https://github.com/wrf-model/WPS
cd WPS
./clean
echo "when asked select option 1.  Linux x86_64, gfortran (serial)"
echo "it is recommended to use serial regardless of the selection in WRF"
./configure
echo "===== compiling WPS..."
./compile

# ls -ls *.exe
# ls -ls geogrid/src/geogrid.exe
# ls -ls metgrid/src/metgrid.exe
# ls -ls ungrib/src/ungrib.exe


# sudo apt-get install python3-rasterio python3-cartopy python3-netcdf4 python3-xarray
# sudo pip3 install wrf-python
