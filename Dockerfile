FROM ubuntu:jammy AS builder

COPY get_src.sh /get_src.sh

RUN apt update && apt upgrade -y && \
    apt install \
    wget \
    cmake \
    build-essential \
    -y && \
    chmod +x /get_src.sh && \
    bash /get_src.sh

WORKDIR /app

ARG CORES=$(nproc)

RUN mkdir build && \
    cd build && \
    cmake .. \
    -DGMX_BUILD_OWN_FFTW=ON \
    -DREGRESSIONTEST_DOWNLOAD=ON && \
    make -j $CORES && \
    make check -j $CORES && \
    make install && \
    tar -czvf top.tar.gz /usr/local/gromacs/share/gromacs/top && \
    rm -rf /usr/local/gromacs/share/gromacs/topwei ko

FROM ubuntu:jammy

COPY --from=builder /usr/local/gromacs /usr/local/gromacs
COPY init.sh /init.sh

RUN apt update && apt upgrade -y && \
    apt install \
    wget \
    bash-completion \
    -y && \
    chmod +x /init.sh && \
    echo 'source /usr/local/gromacs/bin/GMXRC' >> /etc/profile

WORKDIR /work

ENTRYPOINT /init.sh