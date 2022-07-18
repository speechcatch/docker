ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/
# COPY model/ /model/

WORKDIR /workspace/

EXPOSE 9100

CMD ["bash","run.sh"]