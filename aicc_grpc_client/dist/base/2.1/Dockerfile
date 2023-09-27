FROM golang:1.17-alpine3.15 as builder

LABEL maintainer="dldidtmd1@naver.com"

ENV LANG=ko_KR.UTF-8
ENV TZ=Asia/Seoul
ENV LC_ALL=C.UTF-8

RUN apk add -q --update \
    && apk add -q \
            bash \
            git \
            curl \
            build-base \
            pkgconfig \
            portaudio-dev \
    && rm -rf /var/cache/apk/*