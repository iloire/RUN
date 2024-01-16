#!/bin/bash

. env.sh

echo "LIBRARIES_DIR: $LIBRARIES_DIR"

mkdir -p $LIBRARIES_DIR

cd $LIBRARIES_DIR

# Building the libraries
echo "===== Building WRF Libraries ====="
echo "Download libraries to $LIBRARIES_DIR"
echo "https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php#STEP2"
echo "Press any key to continue"
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/mpich-3.0.4.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-4.1.3.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.7.tar.gz


## NetCDF
tar xzvf netcdf-4.1.3.tar.gz
cd netcdf-4.1.3
./configure --prefix=$LIBRARIES_DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared
make
make install
cd ..

## MPICH
tar xzvf mpich-3.0.4.tar.gz     #or just .tar if no .gz present
cd mpich-3.0.4
./configure --prefix=$LIBRARIES_DIR/mpich
make
make install
cd ..

## zlib
tar xzvf zlib-1.2.7.tar.gz     #or just .tar if no .gz present
cd zlib-1.2.7
./configure --prefix=$LIBRARIES_DIR/grib2
make
make install
cd ..

## libpng
tar xzvf libpng-1.2.50.tar.gz     #or just .tar if no .gz present
cd libpng-1.2.50
./configure --prefix=$LIBRARIES_DIR/grib2
make
make install
cd ..

## Jasper
tar xzvf jasper-1.900.1.tar.gz     #or just .tar if no .gz present
cd jasper-1.900.1
./configure --prefix=$LIBRARIES_DIR/grib2
make
make install
cd ..
