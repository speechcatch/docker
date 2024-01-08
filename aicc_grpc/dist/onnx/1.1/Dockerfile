FROM aicc_grpc_centos:1.1  as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/

RUN go build .
RUN cp ./grpc /
RUN cp -r settings/ aes/ /

EXPOSE 58965

WORKDIR /

CMD ["./grpc"]