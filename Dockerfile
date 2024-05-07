# TODO fix issue with alpine that it can't find doxygen
FROM ubuntu:20.04

ARG DOXYGEN_VERSION=1.10.0

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y graphviz subversion git curl make libclang1-9 libclang-cpp9

## Install doxygen directly to allow for any version
# Release is the snake case of the version i.e 1.10.0 => 1_10_0
RUN export DOXYGEN_RELEASE=$(echo "$DOXYGEN_VERSION" | tr . _) && \
    curl --output doxygen.tar.gz -L \
    https://github.com/doxygen/doxygen/releases/download/Release_$DOXYGEN_RELEASE/doxygen-$DOXYGEN_VERSION.linux.bin.tar.gz && \
    mkdir -p doxygen && \
    tar -o -xzvf doxygen.tar.gz -C doxygen --strip-components 1 && \
    cd doxygen && \
    make install

CMD ["doxygen", "-v"]

