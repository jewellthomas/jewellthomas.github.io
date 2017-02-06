FROM debian:jessie

MAINTAINER Jewell Thomas <jewell.thomas@gmail.com>


RUN apt-get update && \
    apt-get -yq install python-pip pandoc git

RUN apt-get -yq install python python-dev python-lxml libxml2-dev libxslt-dev 

RUN pip install pip -U
RUN pip install 'mako==1.0.*' \
    'markdown==2.6.*' \
    'nbconvert==4.2.*' \
    'ipython==4.2.*' \
    'pyyaml==3.11'

COPY . /srv/blog
WORKDIR /srv/blog
