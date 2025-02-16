FROM alpine:3.21.3
LABEL MAINTAINER "Roman Lagutin <r@lag.net.ru>"
RUN apk add --no-cache \
    minidlna \
    ffmpeg \
    && mkdir -p /var/cache/minidlna /media
COPY minidlna.conf /etc/minidlna.conf
#VOLUME /media
EXPOSE 1900/udp 8200/tcp
CMD ["minidlnad", "-d"]
