FROM aicc_tts:2.53

LABEL maintainer="elbum@hanmail.net"

ENV LANG=ko_KR.UTF-8
ENV TZ=Asia/Seoul
ENV LC_ALL=C.UTF-8
ENV PYTHONENCODING=utf_8

RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* \
&&  apt-get update \
&&  apt-get install -y vim 