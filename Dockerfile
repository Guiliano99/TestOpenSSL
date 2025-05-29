FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENSSL_VERSION=3.5.0

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential curl git perl make cmake \
    autoconf automake libtool pkg-config \
    libssl-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src

# Download and build OpenSSL 3.5.0
RUN curl -sL https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz | tar xz && \
    cd openssl-${OPENSSL_VERSION} && \
    ./Configure linux-x86_64 --prefix=/usr/local --openssldir=/usr/local/ssl && \
    make -j"$(nproc)" && \
    make install_sw && \
    cd .. && rm -rf openssl-${OPENSSL_VERSION}

# Set OpenSSL binary path
ENV PATH="/usr/local/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/lib"

# Copy custom scripts
CMD ["bash"]