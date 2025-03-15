FROM ubuntu:22.04 AS root

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN  apt-get update && apt-get install -y \
    g++ cmake ninja-build \
    tcl-dev libgflags-dev libgoogle-glog-dev libboost-all-dev libgtest-dev flex\
    libeigen3-dev libunwind-dev libmetis-dev libgmp-dev bison rustc cargo\
    libhwloc-dev libcairo2-dev

CMD ["/usr/bin/bash"]