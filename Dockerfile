ARG FEDORA_VERSION

FROM fedora:$FEDORA_VERSION

ENV TZ=Europe/Berlin \
  BASEDIR=/root/rasp \
  LIBRARIES_DIR=/root/rasp/libraries \
  FOLDER_LOGS=/root/rasp/logs

WORKDIR $BASEDIR

RUN mkdir -p $BASEDIR $LIBRARIES_DIR $FOLDER_LOGS

RUN dnf update -y && dnf install -y \
  which wget mc time findutils less vim patch diffutils \
  git gcc gcc-fortran g++ csh gfortran cpp m4 \
  openmpi openmpi-devel \
  python3 file \
  python3-rasterio python3-cartopy python3-netcdf4 python3-xarray \
  mpich zlib libpng jasper \
  netcdf netcdf-fortran netcdf-fortran-devel \
  && dnf clean all

RUN sudo pip3 install wrf-python

RUN git clone --depth 1 --branch v4.5.2 https://github.com/wrf-model/WRF
RUN git clone --depth 1 --branch v4.5 https://github.com/wrf-model/WPS

COPY install/* $BASEDIR

RUN chmod +x $BASEDIR/*.sh

RUN ./install_libraries.sh

# needs manual prompt for architecture
# RUN ./install_WRF.sh
# RUN ./install_WPS.sh

# RUN /bin/bash
