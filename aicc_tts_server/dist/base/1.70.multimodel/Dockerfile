FROM aicc_tts:2.53

LABEL maintainer="elbum@hanmail.net"

ENV LANG=ko_KR.UTF-8
ENV TZ=Asia/Seoul
ENV LC_ALL=C.UTF-8
ENV PYTHONENCODING=utf_8
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
# RUN apt-get install -y tzdata
RUN apt-get update
RUN apt-get install -y vim 