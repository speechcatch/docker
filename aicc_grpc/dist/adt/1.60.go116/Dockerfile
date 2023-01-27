ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/

RUN go mod tidy
RUN go build .
RUN cp ./grpc /
RUN cp -r settings/ aes/ /
RUN rm -rf /workspace/

EXPOSE 58965

WORKDIR /
RUN mkdir log/

COPY /grpc.sh /
RUN chmod +x /grpc.sh
RUN rm /go/pkg/mod/google.golang.org/grpc@v1.43.0/rpc_util.go
COPY rpc_util.go /go/pkg/mod/google.golang.org/grpc@v1.43.0/
RUN rm /go/pkg/mod/google.golang.org/grpc@v1.43.0/internal/transport/transport.go
COPY transport.go /go/pkg/mod/google.golang.org/grpc@v1.43.0/internal/transport/

ENTRYPOINT ["sh","./grpc.sh"]