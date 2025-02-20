FROM alpine:3
LABEL maintainer="Roman Lagutin <r@lag.net.ru>"
RUN apk add --no-cache minidlna
ADD minidlna.conf /etc/minidlna.conf
VOLUME /media
EXPOSE 1900/udp 8200/tcp
CMD ["minidlnad", "-d"]
