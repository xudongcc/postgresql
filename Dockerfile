ARG PG_VERSION=17
ARG PG_PARTMAN_VERSION=5.2.2
ARG PG_VECTOR_VERSION=0.8.0

FROM bitnami/postgresql:${PG_VERSION}

ARG PG_VERSION
ARG PG_PARTMAN_VERSION
ARG PG_VECTOR_VERSION

USER root

RUN install_packages wget build-essential

RUN cd /tmp && \
    # Downloads
    wget https://github.com/pgpartman/pg_partman/archive/refs/tags/v${PG_PARTMAN_VERSION}.tar.gz -O pg_partman.tar.gz && \
    wget https://github.com/pgvector/pgvector/archive/refs/tags/v${PG_VECTOR_VERSION}.tar.gz -O pgvector.tar.gz && \
    export C_INCLUDE_PATH=/opt/bitnami/postgresql/include/:/opt/bitnami/common/include/ && \
    export LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ && \
    export LD_LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ && \
    # Install pg_partman
    tar -xzf pg_partman.tar.gz && \
    cd pg_partman-${PG_PARTMAN_VERSION} && \
    make && \
    make install && \
    cd .. && \
    rm -rf pg_partman.tar.gz pg_partman-${PG_PARTMAN_VERSION} && \
    # Install pgvector
    tar -xzf pgvector.tar.gz && \
    cd pgvector-${PG_VECTOR_VERSION} && \
    make && \
    make install && \
    cd .. && \
    rm -rf pgvector.tar.gz pgvector-${PG_VECTOR_VERSION}

USER ${UID}
