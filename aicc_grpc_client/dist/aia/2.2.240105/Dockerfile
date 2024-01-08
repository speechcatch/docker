ARG BUILDER
FROM ${BUILDER} as builder

LABEL maintainer="dldidtmd1@naver.com"

COPY source/ /workspace/

WORKDIR /workspace/
RUN go get -u github.com/gordonklaus/portaudio \
&& go mod tidy \
&& go build .

# ENTRYPOINT ["sh","./grpc.sh"]