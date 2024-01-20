ARG BASE_IMAGE
ARG FEDORA_VERSION

FROM $BASE_IMAGE:fedora$FEDORA_VERSION as base


FROM $BASE_IMAGE:fedora$FEDORA_VERSION

ENV BASEDIR=/root/rasp

WORKDIR $BASEDIR

ARG REGION
RUN test -n "$REGION" || (echo "REGION  not set" && false)

COPY ./Domains/$REGION $BASEDIR/$REGION
COPY --from=base /root/rasp/WPS/geogrid.exe $BASEDIR/$REGION

RUN /bin/bash
