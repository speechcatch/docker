ARG BUILDER
FROM ${BUILDER} as builder

LABEL maintainer="elbum@hanmail.net"

COPY source/ /workspace/
# COPY model/ /model/

WORKDIR /workspace/

RUN /bin/bash -c "pip install sox ." 
# RUN /bin/bash -c "pip install ." 

ENV PYTHONUNBUFFERED=0
EXPOSE 9100

# CMD ["bash","run.sh"]
CMD ["bash","run_multimodel.sh"]