FROM ubuntu:16.04

RUN echo '\
deb <mirror> <version> main restricted universe multiverse\n\
deb <mirror> <version>-updates main restricted universe multiverse\n\
deb <mirror> <version>-backports main restricted universe multiverse\n\
deb <mirror> <version>-security main restricted universe multiverse\n'\
> /etc/apt/sources.list
RUN sed -ie 's|<mirror>|http://mirrors.tuna.tsinghua.edu.cn/ubuntu/|' /etc/apt/sources.list
RUN sed -ie 's|<version>|xenial|' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
        curl \
        unzip \
        git \
        make \
        cmake-curses-gui \
        python \
        python-pip \
        python-setuptools \
        clang-format-5.0 \
        graphviz \
        g++-arm-linux-gnueabi \
        gcc-arm-linux-gnueabi
RUN apt-get autoremove -y && apt-get clean
RUN ln -s clang-format-5.0 /usr/bin/clang-format
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple wheel
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pre-commit
RUN cd /tmp && curl -O http://mirrors.neusoft.edu.cn/android/repository/android-ndk-r17b-linux-x86_64.zip
RUN curl -O https://mms-res.cdn.bcebos.com/cmake-3.10.3-Linux-x86_64.tar.gz && \
        tar xzf cmake-3.10.3-Linux-x86_64.tar.gz && \
        mv cmake-3.10.3-Linux-x86_64 /opt/cmake-3.10 && \
        mv /usr/bin/cmake /usr/bin/cmake.bak && ln -s /opt/cmake-3.10/bin/cmake /usr/bin/cmake && \
        mv /usr/bin/ccmake /usr/bin/ccmake.bak && ln -s /opt/cmake-3.10/bin/ccmake /usr/bin/ccmake
RUN cd /opt && unzip /tmp/android-ndk-r17b-linux-x86_64.zip
ENV NDK_ROOT /opt/android-ndk-r17b
