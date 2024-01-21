ARG BASE_IMAGE
ARG FEDORA_VERSION

FROM $BASE_IMAGE:fedora$FEDORA_VERSION as base

FROM $BASE_IMAGE:fedora$FEDORA_VERSION

ENV BASEDIR=/root/rasp

ARG REGION
ENV REGION=$REGION

RUN test -n "$REGION" || (echo "REGION  not set" && false)

COPY ./Domains/$REGION $BASEDIR/$REGION
COPY --from=base /root/rasp/WPS/geogrid.exe $BASEDIR/$REGION
COPY --from=base /root/rasp/WPS/metgrid.exe $BASEDIR/$REGION
COPY --from=base /root/rasp/WPS/ungrib.exe $BASEDIR/$REGION

COPY gfs_data/*.py $BASEDIR/$REGION
COPY run_rasp.sh $BASEDIR/$REGION
COPY config.ini $BASEDIR/$REGION

COPY run/*.sh $BASEDIR/$REGION
RUN chmod +x $BASEDIR/*.sh

COPY inputer.py $BASEDIR/$REGION
RUN chmod +x $BASEDIR/$REGION/*.py

WORKDIR $BASEDIR/$REGION

RUN /bin/bash
