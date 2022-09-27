#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

cvlc -I telnet --telnet-port 4212 --telnet-password testest --no-video --aout afile --audiofile-file /share/snapfifo/vlc-tous &

bashio::log.info "Starting SnapServer..."

/usr/bin/snapserver -c /share/snapcast/snapserver.conf
