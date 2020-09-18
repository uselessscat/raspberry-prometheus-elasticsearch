ARG PROMETHEUS_VER=2.21.0

FROM debian:10

ARG PROMETHEUS_VER
ENV PROMETHEUS_HOME /usr/prometheus_${PROMETHEUS_VER}

RUN apt update && \
    apt install -y curl && \
    curl -L -o /tmp/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VER}/prometheus-${PROMETHEUS_VER}.linux-amd64.tar.gz && \
    mkdir ${PROMETHEUS_HOME} && \
    tar -xzvf /tmp/prometheus.tar.gz -C ${PROMETHEUS_HOME} --strip-components=1 && \
    ln -s ${PROMETHEUS_HOME}/prometheus /bin/prometheus && \
    rm -f /tmp/prometheus.tar.gz

WORKDIR ${PROMETHEUS_HOME}

EXPOSE 9090

ENTRYPOINT [ "/bin/prometheus" ]
CMD [ "--config.file=prometheus.yml" ]

# docker build -f prometheus.dockerfile -t prometheus:latest .
# docker run -ti prometheus:latest -p 9090