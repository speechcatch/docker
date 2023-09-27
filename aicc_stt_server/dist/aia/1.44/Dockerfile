ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/
COPY model/ /model/

WORKDIR /workspace/

RUN ln -s ../model/ model_repo
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python

EXPOSE 5000

CMD ["bash","run.sh"]