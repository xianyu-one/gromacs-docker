FROM ubuntu:jammy AS builder

COPY get_src.sh /get_src.sh

RUN apt update && apt upgrade -y && \
    apt install \
    wget \
    curl \
    jq \
    cmake \
    python3 \
    build-essential \
    -y && \
    chmod +x /get_src.sh && \
    bash /get_src.sh

WORKDIR /app

RUN mkdir build && \
    cd build && \
    cmake .. \
    -DGMX_BUILD_OWN_FFTW=ON \
    -DREGRESSIONTEST_DOWNLOAD=ON && \
    export CPU_CORES=$(nproc) && \
    make -j $CPU_CORES && \
    make check -j $CPU_CORES && \
    make install && \
    cd /usr/local/gromacs/share/gromacs/top && \
    tar -czvf /usr/local/gromacs/share/gromacs/top.tar.gz * && \
    cd / && \
    rm -rf /usr/local/gromacs/share/gromacs/top/*

FROM ubuntu:jammy

COPY --from=builder /usr/local/gromacs /usr/local/gromacs
COPY init.sh /init.sh

RUN apt update && apt upgrade -y && \
    apt install \
    wget \
    python3 \
    libgomp1 \
    bash-completion \
    -y && \
    chmod +x /init.sh

ENV USER_UID=1000 

WORKDIR /work

ENTRYPOINT /init.sh