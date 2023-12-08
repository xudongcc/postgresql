ARG PG_VERSION=16
ARG PG_PARTMAN_VERSION=4.7.4

FROM bitnami/postgresql:${PG_VERSION}

ARG PG_VERSION
ARG PG_PARTMAN_VERSION

USER root

RUN install_packages wget build-essential

RUN wget https://github.com/pgpartman/pg_partman/archive/refs/tags/v${PG_PARTMAN_VERSION}.tar.gz -O pg_partman.tar.gz && \
    export C_INCLUDE_PATH=/opt/bitnami/postgresql/include/:/opt/bitnami/common/include/ && \
    export LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ && \
    export LD_LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ && \
    tar -xzf pg_partman.tar.gz && \
    cd pg_partman-${PG_PARTMAN_VERSION} && \
    make && \
    make install && \
    rm -rf pg_partman.tar.gz pg_partman-${PG_PARTMAN_VERSION}
