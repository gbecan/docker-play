FROM java:latest
MAINTAINER Guillaume Bécan

RUN mkdir /play
WORKDIR /play

COPY start.sh ./
RUN chmod +x ./start.sh

ENTRYPOINT ["./start.sh"]
