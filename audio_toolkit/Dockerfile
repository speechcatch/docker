FROM python:3.8

LABEL maintainer="elbum@hanmail.net"
# Audio Toolkit v1.4

ENV LANG=ko_KR.UTF-8
ENV TZ=Asia/Seoul
ENV LC_ALL=C.UTF-8
ENV PYTHONENCODING=utf_8
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
# RUN apt-get install -y tzdata
RUN apt-get update
RUN apt-get install -y ffmpeg sox apache2-utils vim
RUN echo 'alias ll="ls -al"' >> /root/.bashrc
COPY . /workspace
WORKDIR /workspace
RUN pip install -r Requirements.txt
CMD tail -f /dev/null
