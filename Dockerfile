ARG FEDORA_VERSION

FROM fedora:$FEDORA_VERSION

ENV TZ=Europe/Berlin \
  BASEDIR=/root/rasp \
  LIBRARIES_DIR=/root/rasp/libraries \
  FOLDER_INSTALL=/root/rasp/meteo

RUN mkdir $BASEDIR
WORKDIR $BASEDIR

RUN dnf update -y && dnf install -y \
  which wget time findutils less vim patch diffutils \
  git gcc csh gfortran cpp m4 \
  mpich zlib libpng jasper \
  netcdf netcdf-fortran \
  && dnf clean all

COPY install_WRF.sh $BASEDIR
COPY install/env.sh $BASEDIR
COPY install/install_libraries.sh $BASEDIR

RUN chmod +x $BASEDIR/*.sh

RUN ./install_libraries.sh

# RUN bash ./install_WRF.sh
# RUN /bin/bash
