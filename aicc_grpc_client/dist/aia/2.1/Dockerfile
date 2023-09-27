ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/
RUN go get -u github.com/gordonklaus/portaudio
RUN go mod tidy
RUN go build .

# ENTRYPOINT ["sh","./grpc.sh"]