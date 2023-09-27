ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/
COPY model/ /model/

WORKDIR /workspace/

RUN ln -s ../model/ model_repo

EXPOSE 5000

# ENTRYPOINT ["bash","run.sh"]