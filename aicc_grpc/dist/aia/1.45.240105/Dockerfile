ARG BUILDER
FROM ${BUILDER} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/
COPY /grpcurl /
COPY /grpc.sh /

WORKDIR /workspace/

RUN go mod tidy \
&&  go build . \
&&  cp ./grpc / \
&&  cp -r settings/ aes/ / \
&&  rm -rf /workspace/

WORKDIR /

RUN mkdir log/ \
&&  chmod +x /grpcurl \
&&  chmod +x /grpc.sh

EXPOSE 9200

ENTRYPOINT ["sh","./grpc.sh"]