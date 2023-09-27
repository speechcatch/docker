ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="elbum@hanmail.net"

COPY sox-14.4.1-7.el7.x86_64.rpm /pkg/
RUN yum update && yum install -y /pkg/sox-14.4.1-7.el7.x86_64.rpm 

COPY source/ /workspace/
COPY Model/ /workspace/Model
WORKDIR /workspace/

RUN /bin/bash -c "mkdir -p /nltk_data/corpora"
RUN /bin/bash -c "cp -r /workspace/speechclone_tts/utils/korean_normalizer/e2hsk/cmudict_modify/cmudict/ /nltk_data/corpora" 
RUN /bin/bash -c "cp -r /workspace/speechclone_tts/utils/korean_normalizer/e2hsk/cmudict_modify/cmudict.zip /nltk_data/corpora" 

RUN ln -s /root/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /root/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate aicc" >> ~/.bashrc && \ 
    echo "conda clean -all -y " >> ~/.bashrc

ENV PATH /root/anaconda3/envs/aicc/bin:$PATH
# Dockerfile에 적용한 ENV는 kubernetes yaml보다 우선순위를 가지므로 혼동을 피하기 위해 아예 뺀다.
# ENV REDIS_SERVER "host.docker.internal"
# ENV REDIS_PORT 6379
# ENV REDIS_PASSWORD ""
# ENV REDIS_SSL False
ENV RESAMPLER "sox"

RUN /bin/bash -c "pip install sox" 
RUN /bin/bash -c "pip install python-mecab-ko" 
RUN /bin/bash -c "pip install ." 


# RUN pip install -y sox
RUN pip cache purge
ENV PYTHONUNBUFFERED=TRUE
ENV TF_CPP_MIN_LOG_LEVEL=3
EXPOSE 9000

# ENTRYPOINT ["bash", "run.sh"]