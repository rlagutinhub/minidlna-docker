ARG ALPINE_TAG=latest
FROM alpine:${ALPINE_TAG}
LABEL maintainer="Roman Lagutin <r@lag.net.ru>"
ARG MINIDLNA_VER=1.3.3-r1
RUN apk add --no-cache tzdata minidlna=${MINIDLNA_VER}
ENV TZ=Europe/Moscow
COPY minidlna.conf /etc/minidlna.conf
VOLUME /media
EXPOSE 1900/udp 8200/tcp
CMD ["minidlnad", "-d"]
