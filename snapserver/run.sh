#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

bashio::log.info "Starting SnapServer..."

/usr/bin/snapserver -c /share/snapcast/snapserver.conf

vlc -I telnet --telnet-port 4212 --telnet-password testest --no-video --aout afile --audiofile-file /share/snapfifo/vlc-tous
