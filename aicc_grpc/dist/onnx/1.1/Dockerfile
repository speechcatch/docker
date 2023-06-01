ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/

RUN go build .
RUN cp ./grpc /
RUN cp -r settings/ aes/ /

EXPOSE 58965

WORKDIR /

CMD ["./grpc"]