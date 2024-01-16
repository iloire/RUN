#!/bin/bash

## Folders
FOLDER_INSTALL=/root/rasp/METEO
mkdir $FOLDER_INSTALL $FOLDER_INSTALL/Build_WRF $FOLDER_INSTALL/TESTS


# Building the libraries
echo "===== Building WRF Libraries ====="
cd ../Build_WRF
mkdir LIBRARIES
echo "Download libraries to $FOLDER_INSTALL/Build_WRF/LIBRARIES"
echo "https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php#STEP2"
echo "Press any key to continue"
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/mpich-3.0.4.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-4.1.3.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.7.tar.gz

## Export variables
export DIR=$FOLDER_INSTALL/Build_WRF/LIBRARIES
export CC=gcc
export CXX=g++
export FC=gfortran
export FCFLAGS=-m64
export F77=gfortran
export FFLAGS=-m64
export JASPERLIB=$DIR/grib2/lib
export JASPERINC=$DIR/grib2/include
export LDFLAGS=-L$DIR/grib2/lib
export CPPFLAGS=-I$DIR/grib2/include

## NetCDF
tar xzvf netcdf-4.1.3.tar.gz
cd netcdf-4.1.3
./configure --prefix=$DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared
make
make install
export PATH=$DIR/netcdf/bin:$PATH    #XXX  to .bashrc??
export NETCDF=$DIR/netcdf            #XXX  to .bashrc??
cd ..

## MPICH
tar xzvf mpich-3.0.4.tar.gz     #or just .tar if no .gz present
cd mpich-3.0.4
./configure --prefix=$DIR/mpich
make
make install
export PATH=$DIR/mpich/bin:$PATH    #XXX  to .bashrc??
cd ..

## zlib
tar xzvf zlib-1.2.7.tar.gz     #or just .tar if no .gz present
cd zlib-1.2.7
./configure --prefix=$DIR/grib2
make
make install
cd ..

## libpng
tar xzvf libpng-1.2.50.tar.gz     #or just .tar if no .gz present
cd libpng-1.2.50
./configure --prefix=$DIR/grib2
make
make install
cd ..

## Jasper
tar xzvf jasper-1.900.1.tar.gz     #or just .tar if no .gz present
cd jasper-1.900.1
./configure --prefix=$DIR/grib2
make
make install
cd ..

# Building WRF
echo "===== Building WRF ====="
cd $FOLDER_INSTALL
git clone https://github.com/wrf-model/WRF
cd WRF
echo "when asked select 34. (dmpar) for GNU (gfortran/gcc)"
echo "and select nesting: 1=basic"
./configure
./compile em_real >& log.compile
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
./compile >& log.compile

ls -ls *.exe
ls -ls geogrid/src/geogrid.exe
ls -ls metgrid/src/metgrid.exe
ls -ls ungrib/src/ungrib.exe


# sudo apt-get install python3-rasterio python3-cartopy python3-netcdf4 python3-xarray
# sudo pip3 install wrf-python
