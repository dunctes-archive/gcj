FROM debian:stretch

WORKDIR /

RUN mkdir gcj

WORKDIR /gcj

COPY ./src/main/java/Main.java ./Main.java

# deb http://snapshot.debian.org/archive/debian/20210326T030000Z jessie main
RUN echo 'deb http://archive.debian.org/debian stretch main' > /etc/apt/sources.list
RUN echo 'deb http://archive.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list
RUN echo 'deb http://archive.debian.org/debian stretch-backports main' >> /etc/apt/sources.list

# deb http://snapshot.debian.org/archive/debian-security/20210326T030000Z jessie/updates main
#deb http://archive.debian.org/debian-security jessie/updates main
# deb http://snapshot.debian.org/archive/debian/20210326T030000Z jessie-updates main
#deb http://archive.debian.org/debian jessie-backports main
# deb http://archive.debian.org/debian jessie main


#RUN echo 'deb http://archive.debian.org/debian jessie main' >> /etc/apt/sources.list

RUN apt update -y && apt install build-essential libgcj-common gcj-6 gcj-jdk libgcj17 libgcj17-dev nano -y --force-yes
#RUN apt update -y && apt install build-essential gcj-4.9 gcj-4.9-jdk libgcj15 libgcj15-dev libgcj-common nano -y --force-yes

RUN gcj-6 -c Main.java
RUN gcj-6 --main=Main -o Main Main.o

ENTRYPOINT ["/bin/bash"]
