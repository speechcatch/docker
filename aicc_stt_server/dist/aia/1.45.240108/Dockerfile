ARG BUILDER
FROM ${BUILDER} as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/
COPY model/ /model/

WORKDIR /workspace/

RUN ln -s ../model/ model_repo \
&&  ln -s /usr/local/bin/python3.7 /usr/bin/python

EXPOSE 5000

ENTRYPOINT ["bash","run.sh"]