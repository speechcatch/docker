ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/

WORKDIR /workspace/

EXPOSE 58961

WORKDIR /

CMD ["./grpc"]