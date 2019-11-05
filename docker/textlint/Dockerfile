FROM node:latest
MAINTAINER mainek00n

RUN mkdir /workdir

COPY docker/textlint/package.json /workdir/

WORKDIR /workdir
RUN npm install

COPY docker/textlint/config/* /workdir/