ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/

RUN go build .
RUN cp ./grpc /
RUN cp -r settings/ aes/ /
RUN rm -rf /workspace/

EXPOSE 9200

WORKDIR /
RUN mkdir log/

COPY /grpc.sh /
RUN chmod +x /grpc.sh

ENTRYPOINT ["sh","./grpc.sh"]