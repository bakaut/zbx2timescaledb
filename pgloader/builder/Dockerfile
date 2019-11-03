FROM debian:stable-slim as builder

ENV PGLOADER_VERSION="v3.6.1"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    freetds-dev \
    gawk \
    git \
    libsqlite3-dev \
    libssl1.1 \
    libzip-dev \
    make \
    openssl \
    patch \
    sbcl \
    time \
    unzip \
    wget \
    cl-ironclad \
    cl-babel \
    bzip2 \
    time \
    git-core \
    subversion \
    && rm -rf /var/lib/apt/lists/*

ENV CCL_VERSION="1.11"

WORKDIR /usr/local/src
RUN svn co http://svn.clozure.com/publicsvn/openmcl/release/$CCL_VERSION/linuxx86/ccl
RUN cp /usr/local/src/ccl/scripts/ccl64 /usr/local/bin/ccl

RUN git clone -b $PGLOADER_VERSION --depth 1 https://github.com/dimitri/pgloader.git /opt/src/pgloader

ENV PGLOADER_MEMORY_MB=2048 

ENV CL_VERSION="ccl"

#ENV CL_VERSION="sbcl" 

RUN mkdir -p /opt/src/pgloader/build/bin \
    && cd /opt/src/pgloader \
    && make CL=$CL_VERSION DYNSIZE=$PGLOADER_MEMORY_MB clones save


FROM alpine
COPY --from=builder /opt/src/pgloader/build/bin/pgloader /usr/local/bin