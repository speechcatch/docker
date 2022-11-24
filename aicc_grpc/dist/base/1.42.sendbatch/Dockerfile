FROM golang:1.16-alpine3.15 as builder

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
    && rm -rf /var/cache/apk/*

RUN go get -u \
        github.com/funny/crypto \
        golang.org/x/net \
        golang.org/x/sys \
        golang.org/x/text \
        google.golang.org/genproto \
        google.golang.org/grpc
	      # google.golang.org/grpc \
    # && rm -rf $GOPATH/src/* && rm -rf $GOPATH/pkg/*
