# minidlna (aka ReadyDLNA or ReadyMedia)
> Tested for VLC for Android and ViMu Media Player for TV
```bash
mkdir -p ~/Документы/minidlna && cd ~/Документы/minidlna
cat << EOF > Dockerfile
FROM alpine:3
LABEL MAINTAINER "Roman Lagutin <r@lag.net.ru>"
RUN apk add --no-cache minidlna
COPY minidlna.conf /etc/minidlna.conf
# VOLUME /minidlna
EXPOSE 1900/udp 8200/tcp
CMD ["minidlnad", "-d"]
EOF
cat << EOF > minidlna.conf
port=8200
media_dir=/minidlna
friendly_name=minidlna
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
    build: .
    pull_policy: never
    container_name: minidlna
    network_mode: host
    restart: unless-stopped
    volumes:
      - ~/Загрузки:/minidlna
    # environment:
      # - MINIDLNA_MEDIA_DIR=/minidlna
      # - MINIDLNA_FRIENDLY_NAME=minidlna
EOF
docker compose up -d
```
https://sourceforge.net/projects/minidlna/
