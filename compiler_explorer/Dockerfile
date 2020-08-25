FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        curl \
        wget \
        vim \
        ca-certificates \
        xz-utils \
        git \
        build-essential \
        python3 \
        gfortran \
        gcc \
        gcc-10 \
        clang-tidy \
        clang-10 \
        clang-9 \
        llvm \
        llvm-dev \
        llvm-9 \
        llvm-9-dev \
        libc++-dev \
        libc++abi-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENV NODEJS_VERSION="v12.18.3"
ENV NODEJS_DISTRO="linux-x64"
RUN wget https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-${NODEJS_DISTRO}.tar.xz && \
    tar xfJ node-${NODEJS_VERSION}-${NODEJS_DISTRO}.tar.xz && \
    mv node-${NODEJS_VERSION}-${NODEJS_DISTRO} /opt/nodejs

ENV PATH /opt/nodejs/bin:${PATH}

USER root
RUN cd /tmp && wget https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.tar.gz && \
    tar xfz boost_1_74_0.tar.gz && \
    cd boost_1_74_0 && \
    ./bootstrap.sh && \
    ./b2 install --prefix=/opt/boost-1.74
ENV PATH /opt/boost-1.74/bin:${PATH}
ENV LD_LIBRARY_PATH /opt/boost-1.74/lib:${LD_LIBRARY_PATH}
ENV CPLUS_INCLUDE_PATH /opt/boost-1.74/include/:${CPLUS_INCLUDE_PATH}

RUN useradd -m ceuser && \
    mkdir /opt/compiler-explorer && \
    chown ceuser /opt/compiler-explorer

USER ceuser
WORKDIR /opt/compiler-explorer
RUN git clone https://github.com/compiler-explorer/compiler-explorer . && \
    make prereqs

# Copy the startup script
# USER root
# COPY run.sh /
# RUN chmod +x /run.sh

# Copy the config files
USER root
COPY *.properties /opt/compiler-explorer/etc/config/
RUN chown -R ceuser /opt/compiler-explorer/etc/config/

USER ceuser
EXPOSE 10240
ENTRYPOINT bash