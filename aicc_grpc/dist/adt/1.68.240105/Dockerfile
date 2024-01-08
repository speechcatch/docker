ARG BUILDER
FROM ${BUILDER} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/
COPY /grpc.sh /

WORKDIR /workspace/

RUN go mod tidy \
&&  go build . \
&&  cp ./grpc / \
&&  cp -r settings/ aes/ / \
&&  rm -rf /workspace/

WORKDIR /

RUN mkdir log/ \
&&  chmod +x /grpc.sh \
&&  rm /go/pkg/mod/google.golang.org/grpc@v1.43.0/rpc_util.go \
&&  rm /go/pkg/mod/google.golang.org/grpc@v1.43.0/internal/transport/transport.go

COPY rpc_util.go /go/pkg/mod/google.golang.org/grpc@v1.43.0/
COPY transport.go /go/pkg/mod/google.golang.org/grpc@v1.43.0/internal/transport/

EXPOSE 58965

ENTRYPOINT ["sh","./grpc.sh"]