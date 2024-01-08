FROM aicc_tts:cuda11.4.3-runtime-ubuntu20.04-torch11.8 as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/
COPY Model/ /workspace/Model
WORKDIR /workspace/

RUN /bin/bash -c "mkdir -p /nltk_data/corpora && cp -r /workspace/diffclone_tts/text/korean_normalizer/e2hsk/cmudict_modify/cmudict/ /nltk_data/corpora && cp -r /workspace/diffclone_tts/text/korean_normalizer/e2hsk/cmudict_modify/cmudict.zip /nltk_data/corpora" 

ENV SAMPLE_RATE 8000
ENV CPU_MODE True
ENV NUM_WORKER 1
ENV NUM_THREAD 8
ENV TIMESTEPS 4

ENV PYTHONUNBUFFERED=TRUE
ENV TF_CPP_MIN_LOG_LEVEL=3
EXPOSE 9000

ENTRYPOINT ["./run.sh"]