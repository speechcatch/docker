FROM centos:centos8.4.2105 as builder

LABEL maintainer="dldidtmd1@naver.com"

WORKDIR /

# dnf update and install wget
RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*
RUN sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*
RUN dnf -y update 
RUN dnf install -y wget gcc make gcc-c++

# 1. Install golang
# download and insall golang
RUN wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
RUN tar -xvf go1.16.5.linux-amd64.tar.gz -C /usr/local

# set environ var
ENV PATH="$PATH:/usr/local/go/bin"

# delete install file
RUN rm -rf /go1.16.5.linux-amd64.tar.gz

# 2. Install onnxruntime-linux-x64-1.12.1
RUN wget https://github.com/microsoft/onnxruntime/releases/download/v1.12.1/onnxruntime-linux-x64-1.12.1.tgz
RUN tar -xvf onnxruntime-linux-x64-1.12.1.tgz -C /root/
RUN rm -rf /onnxruntime-linux-x64-1.12.1.tgz

# 3. Install libc.musl
RUN curl https://musl.libc.org/releases/musl-1.2.2.tar.gz -o musl-1.2.2.tar.gz
RUN tar -xvf musl-1.2.2.tar.gz
WORKDIR /musl-1.2.2
RUN ./configure
RUN make
RUN make install
RUN ln -s /usr/lib64/libc.so.6 /usr/lib64/libc.musl-x86_64.so.1

WORKDIR /
RUN rm -rf musl-1.2.2*


