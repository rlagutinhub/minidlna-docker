# minidlna (aka ReadyDLNA or ReadyMedia)
> Tested for VLC for Android and ViMu Media Player for TV
```bash
mkdir -p ~/Документы/minidlna && cd ~/Документы/minidlna
cat << EOF > Dockerfile
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
EOF
cat << EOF > minidlna.conf
port=8200
media_dir=/media
friendly_name=Медиа
album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg/AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg/Folder.jpg/folder.jpg/Thumb.jpg/thumb.jpg
inotify=yes
enable_tivo=no
tivo_discovery=bonjour
strict_dlna=no
notify_interval=900
serial=12345678
model_number=1
root_container=B
EOF
cat << EOF > docker-compose.yml
services:
  minidlna:
    image: minidlna:latest
    build:
      context: .
      args:
        ALPINE_TAG: "3"
        MINIDLNA_VER: "1.3.3-r1"
    pull_policy: never
    container_name: minidlna
    network_mode: host
    restart: unless-stopped
    volumes:
      - ~/Загрузки:/media
    # environment:
      # - MINIDLNA_MEDIA_DIR=/media
      # - MINIDLNA_FRIENDLY_NAME=Медиа
EOF
docker compose up -d
# docker compose down
# docker system prune -a
```
https://sourceforge.net/projects/minidlna/
