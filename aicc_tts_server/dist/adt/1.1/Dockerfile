ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/
# COPY model/ /model/

WORKDIR /workspace/

ENV PYTHONUNBUFFERED=0
EXPOSE 9100

CMD ["bash","run.sh"]