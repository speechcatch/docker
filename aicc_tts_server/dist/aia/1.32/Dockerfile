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
    echo "conda -y clean -all" >> ~/.bashrc

# RUN echo "conda activate aicc" >> ~/.bashrc

# RUN /bin/bash -c "source activate my_env && pip install torch"


ENV PATH /root/anaconda3/envs/aicc/bin:$PATH
ENV REDIS_SERVER "10.178.84.119"
ENV REDIS_PORT 6380
ENV REDIS_PASSWORD "None"
ENV REDIS_SSL False

RUN /bin/bash -c "pip install sox" 
RUN /bin/bash -c "pip install ." 
# RUN pip install -y sox
RUN pip cache purge
ENV PYTHONUNBUFFERED=TRUE
EXPOSE 9000

# ENTRYPOINT ["bash", "run.sh"]