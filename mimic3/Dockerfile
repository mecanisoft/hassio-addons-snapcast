ARG BUILD_FROM
FROM debian:bullseye as build

RUN apt-get update && apt-get install -y libespeak-ng1 python3 python3-pip python3-venv git
RUN apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN git clone --depth=1 https://github.com/MycroftAI/mimic3
RUN cd mimic3 && ./install.sh

EXPOSE 59125

RUN mkdir -p /root/.local/share/mycroft/mimic3

RUN file="/mimic3/mimic3_tts/config.py"
RUN searchrate="sample_rate: int = 22050"
RUN replacerate="sample_rate: int = 44100"
RUN sed -i "s/$searchrate/$replacerate/" $file
RUN searchchan="channels: int = 1"
RUN replacechan="channels: int = 2"
RUN sed -i "s/$searchchan/$replacechan/" $file

COPY run.sh .
RUN chmod a+x run.sh

CMD [ "./run.sh" ]

