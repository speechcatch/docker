ARG IMAGE_NAME
ARG VERSION
FROM ${IMAGE_NAME}:${VERSION} as builder

LABEL maintainer="elbum@hanmail.net"

COPY sox-14.4.1-7.el7.x86_64.rpm /pkg/
RUN yum update && yum install -y /pkg/sox-14.4.1-7.el7.x86_64.rpm 

COPY source/ /workspace/
WORKDIR /workspace/

# SHELL ["conda", "run", "-n", "aicc", "/bin/bash", "-c"]
# RUN ["conda", "run", "-n", "aicc", "pip", "install" , "-y", "sox"]

RUN ln -s /root/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /root/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate aicc" >> ~/.bashrc && \ 
    echo "conda clean -all -y " >> ~/.bashrc

# RUN echo "conda activate aicc" >> ~/.bashrc

# RUN /bin/bash -c "source activate my_env && pip install torch"


ENV PATH /root/anaconda3/envs/aicc/bin:$PATH
ENV REDIS_SERVER "krazedrdc0003.redis.cache.windows.net"
ENV REDIS_PORT 6380
ENV REDIS_PASSWORD "uPma93SCV0VFsyFPNPBB1F1j4COJ0nQ1LAzCaCbGWSI="
ENV REDIS_SSL True
ENV RESAMPLER "sox"

RUN /bin/bash -c "pip install sox" 
RUN /bin/bash -c "pip install ." 
# RUN pip install -y sox
RUN pip cache purge
ENV PYTHONUNBUFFERED=TRUE
EXPOSE 9000

# ENTRYPOINT ["bash", "run.sh"]