ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/
RUN go get -u \
        github.com/funny/crypto \
        golang.org/x/net \
        golang.org/x/sys \
        golang.org/x/text \
        google.golang.org/genproto \
        google.golang.org/grpc \
        github.com/grpc-ecosystem/go-grpc-middleware
RUN go mod edit -go=1.19
RUN go mod tidy


RUN go build .
RUN cp ./grpc /
RUN cp -r settings/ aes/ /
# RUN rm -rf /workspace/

EXPOSE 9200

WORKDIR /
RUN mkdir log/

COPY /grpcurl /
RUN chmod +x /grpcurl

COPY /grpc.sh /
RUN chmod +x /grpc.sh

ENTRYPOINT ["sh","./grpc.sh"]