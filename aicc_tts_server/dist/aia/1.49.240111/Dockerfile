ARG BUILDER
FROM ${BUILDER} as builder

LABEL maintainer="elbum@hanmail.net"

# sox 설치
COPY sox-14.4.1-7.el7.x86_64.rpm /pkg/
RUN yum update \
&& yum install -y /pkg/sox-14.4.1-7.el7.x86_64.rpm \
&& rm -rf /pkg/sox-14.4.1-7.el7.x86_64.rpm

COPY source/ /workspace/
COPY Model/ /workspace/Model/

WORKDIR /workspace/

RUN /bin/bash -c "mkdir -p /nltk_data/corpora && cp -r /workspace/speechclone_tts/utils/korean_normalizer/e2hsk/cmudict_modify/cmudict/ /nltk_data/corpora && cp -r /workspace/speechclone_tts/utils/korean_normalizer/e2hsk/cmudict_modify/cmudict.zip /nltk_data/corpora"

RUN ln -s /root/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
&&  echo ". /root/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc \
&&  echo "conda activate aicc" >> ~/.bashrc \ 
&&  echo "conda clean -all -y " >> ~/.bashrc

ENV PATH /root/anaconda3/envs/aicc/bin:$PATH
ENV RESAMPLER "sox"

RUN /bin/bash -c "pip install sox python-mecab-ko . && pip cache purge" 

ENV PYTHONUNBUFFERED=TRUE
ENV TF_CPP_MIN_LOG_LEVEL=3
EXPOSE 9000

ENTRYPOINT ["bash", "run.sh"]