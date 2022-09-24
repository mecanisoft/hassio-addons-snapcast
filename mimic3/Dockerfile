ARG BUILD_FROM
FROM debian:bullseye as build

#RUN apt-get update && apt-get install -y libespeak-ng1 python3 python3-pip python3-venv git
#RUN apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
#RUN git clone --depth=1 https://github.com/MycroftAI/mimic3
#RUN cd mimic3 && ./install.sh

EXPOSE 59125
RUN mkdir -p /share/mycroft/mimic3
#RUN ln -s /share/mycroft/mimic3 /home/mimic3/.local

COPY run.sh .
RUN chmod a+x run.sh

#CMD [ "./run.sh" ]

