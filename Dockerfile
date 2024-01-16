ARG FEDORA_VERSION

FROM fedora:${FEDORA_VERSION}

ENV TZ=Europe/Berlin \
  BASEDIR=/root/rasp

RUN mkdir $BASEDIR
WORKDIR $BASEDIR

RUN dnf update -y && dnf install -y \
  which wget time findutils less vim patch diffutils \
  git gcc csh gfortran cpp m4 \
  # libpng jasper \
  netcdf netcdf-fortran \
  && dnf clean all

COPY install_WRF.sh $BASEDIR

# RUN bash ./install_WRF.sh
RUN /bin/bash
