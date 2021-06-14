#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for webdevops/postfix:latest
#    -- automatically generated  --
#+++++++++++++++++++++++++++++++++++++++

#FROM webdevops/base-app:ubuntu-18.04

FROM ubuntu:latest
#COPY conf/ /opt/docker/

RUN apt update  && apt upgrade

RUN apt-get install -y \
    postfix \
    libsasl2 sasl2-bin libsasl2-modules \
    libdb3-util \
    procmail \
    courier-authdaemon \
    courier-imap \
    courier-imap-ssl \
    courier-pop \
    courier-pop-ssl

RUN apt-get install \
    amavisd-new spamassassin clamav-daemon clamav-freshclam re2c

RUN apt-get install \
     libnet-dns-perl libmail-spf-query-perl pyzor razor

RUN apt-get install \
    file arc gzip bzip2 cabextract zip unzip unrar-free cpio tar zoo arj lzop nomarch pax unzoo

RUN useradd clamav --gid amavis

# RUN set -x \
#    && docker-service enable syslog \
#    && docker-service enable postfix \
#    && docker-run-bootstrap \
#    && docker-image-cleanup

EXPOSE 25 465 587


RUN apt-get update && apt-get upgrade && apt-get -y install build-essential git \
	python python3 python-pip python3-pip
