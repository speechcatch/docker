ARG IMAGE_NAME
FROM ${IMAGE_NAME}:1.0 as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/

RUN go build .
RUN cp ./grpc /
RUN cp -r settings/ aes/ /
RUN rm -rf /workspace/

EXPOSE 58964

WORKDIR /

CMD ["./grpc"]