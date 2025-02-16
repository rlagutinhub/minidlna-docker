# minidlna-docker (formerly known as ReadyMedia)
My DLNA Server

```bash
mkdir -p ~/Документы/minidlna && cd ~/Документы/minidlna
cat << EOF > Dockerfile
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
EOF
cat << EOF > minidlna.conf
port=8200
media_dir=/media
friendly_name=My DLNA Server
album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg/AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg/Folder.jpg/folder.jpg/Thumb.jpg/thumb.jpg
inotify=yes
enable_tivo=no
tivo_discovery=bonjour
strict_dlna=no
notify_interval=900
serial=12345678
model_number=1
EOF
cat << EOF > docker-compose.yml
services:
  minidlna:
    build: . # image: minidlna:latest
    container_name: minidlna
    network_mode: host
    restart: unless-stopped
    volumes:
      - ./cache:/var/cache/minidlna
      - ~/Загрузки:/media
    environment:
      - MINIDLNA_MEDIA_DIR=/media
      - MINIDLNA_FRIENDLY_NAME=My DLNA Server
EOF
# docker build -t minidlna:latest .
docker compose up -d
docker compose down
# docker compose restart minidlna
```
