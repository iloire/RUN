#!/bin/bash

. env.sh

echo "LIBRARIES_DIR: $LIBRARIES_DIR"

cd $LIBRARIES_DIR

MPICH_VERSION="4.1.2"
NETCDF_VERSION="4.1.3"
ZLIB_VERSION="1.2.7"
LIBPNG_VERSION="1.2.50"
JASPER_VERSION="1.900.1"

env > env.txt

echo "===== Building WRF Libraries ====="
echo "Download libraries to $LIBRARIES_DIR"

## NetCDF
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-$NETCDF_VERSION.tar.gz
tar xzvf netcdf-$NETCDF_VERSION.tar.gz
rm netcdf-$NETCDF_VERSION.tar.gz
cd netcdf-$NETCDF_VERSION
echo "./configure --prefix=$LIBRARIES_DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared" > configure_params.txt
./configure --prefix=$LIBRARIES_DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared
make > $FOLDER_LOGS/netcdf_configure.log
make install > $FOLDER_LOGS/netcdf_make_install.log
cd ..

## MPICH
wget https://www.mpich.org/static/downloads/4.1.2/mpich-$MPICH_VERSION.tar.gz
tar xzvf mpich-$MPICH_VERSION.tar.gz
rm mpich-$MPICH_VERSION.tar.gz
cd mpich-$MPICH_VERSION
./configure --prefix=$LIBRARIES_DIR/mpich > $FOLDER_LOGS/mpich_configure.log
make > $FOLDER_LOGS/mpich_make.log
make install> $FOLDER_LOGS/mpich_make_install.log
cd ..

## zlib
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-$ZLIB_VERSION.tar.gz
tar xzvf zlib-$ZLIB_VERSION.tar.gz
rm zlib-$ZLIB_VERSION.tar.gz
cd zlib-$ZLIB_VERSION
./configure --prefix=$LIBRARIES_DIR/grib2 > $FOLDER_LOGS/zlib_configure.log
make > $FOLDER_LOGS/zlib_make.log
make install > $FOLDER_LOGS/zlib_make_install.log
cd ..

## libpng
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-$LIBPNG_VERSION.tar.gz
tar xzvf libpng-$LIBPNG_VERSION.tar.gz
rm libpng-$LIBPNG_VERSION.tar.gz
cd libpng-$LIBPNG_VERSION
./configure --prefix=$LIBRARIES_DIR/grib2 > $FOLDER_LOGS/libpng_configure.log
make > $FOLDER_LOGS/libpng_make.log
make install > $FOLDER_LOGS/libpng_make_install.log
cd ..

## Jasper
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-$JASPER_VERSION.tar.gz
tar xzvf jasper-$JASPER_VERSION.tar.gz
rm jasper-$JASPER_VERSION.tar.gz
cd jasper-$JASPER_VERSION
./configure --prefix=$LIBRARIES_DIR/grib2 > $FOLDER_LOGS/jasper_configure.log
make > $FOLDER_LOGS/jasper_make.log
make install > $FOLDER_LOGS/jasper_make_install.log
cd ..
