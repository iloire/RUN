## Export variables
export CC=gcc
export CXX=g++
export FC=gfortran
export FCFLAGS=-m64
export F77=gfortran
export FFLAGS=-m64
export JASPERLIB=$LIBRARIES_DIR/grib2/lib
export JASPERINC=$LIBRARIES_DIR/grib2/include
export LDFLAGS=-L$LIBRARIES_DIR/grib2/lib
export CPPFLAGS=-I$LIBRARIES_DIR/grib2/include

export PATH=$LIBRARIES_DIR/netcdf/bin:$PATH
export NETCDF=$LIBRARIES_DIR/netcdf

export PATH=$LIBRARIES_DIR/mpich/bin:$PATH

export LD_LIBRARY_PATH=$LIBRARIES_DIR/grib2/lib/
