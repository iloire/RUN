ARG BASE_IMAGE
ARG FEDORA_VERSION

FROM $BASE_IMAGE:fedora$FEDORA_VERSION as base

FROM $BASE_IMAGE:fedora$FEDORA_VERSION

RUN echo $FEDORA_VERSION > env-out.txt

ENV BASEDIR=/root/rasp

ARG REGION
ENV REGION=$REGION

RUN test -n "$REGION" || (echo "REGION  not set" && false)

RUN sudo pip3 install MetPy

COPY ./Domains/$REGION $BASEDIR/$REGION
COPY --from=base /root/rasp/WPS/geogrid.exe $BASEDIR/$REGION
COPY --from=base /root/rasp/WPS/metgrid.exe $BASEDIR/$REGION
COPY --from=base /root/rasp/WPS/ungrib.exe $BASEDIR/$REGION

COPY gfs_data/*.py $BASEDIR/$REGION

COPY *.sh $BASEDIR/$REGION

COPY run/*.sh $BASEDIR/$REGION

COPY inputer.py $BASEDIR/$REGION

COPY config.ini $BASEDIR/$REGION

ADD plots $BASEDIR/plots

RUN chmod +x $BASEDIR/$REGION/*.py
RUN chmod +x $BASEDIR/$REGION/*.sh
RUN chmod +x $BASEDIR/*.sh

WORKDIR $BASEDIR/$REGION

RUN /bin/bash
