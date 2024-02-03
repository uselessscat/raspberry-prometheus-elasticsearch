ARG PROMETHEUS_VER=2.49.1

FROM alpine:3.19

ARG PROMETHEUS_VER
ENV PROMETHEUS_HOME /usr/prometheus

RUN apk update \
    && apk add --virtual deps curl \
    && curl -L -o /tmp/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VER}/prometheus-${PROMETHEUS_VER}.linux-amd64.tar.gz \
    && mkdir ${PROMETHEUS_HOME} \
    && tar -xzvf /tmp/prometheus.tar.gz -C ${PROMETHEUS_HOME} --strip-components=1 \
    && test -f ${PROMETHEUS_HOME}/prometheus || (echo "Prometheus binary not found" && exit 1) \
    && ln -s ${PROMETHEUS_HOME}/prometheus /bin/prometheus \
    && rm -f /tmp/prometheus.tar.gz \
    && apk del deps \
    && apk cache clean

RUN ls -lah ${PROMETHEUS_HOME}

COPY prometheus ${PROMETHEUS_HOME}/config

WORKDIR ${PROMETHEUS_HOME}
EXPOSE 9090

ENTRYPOINT [ "/bin/prometheus" ]
CMD [ "--config.file=config/prometheus.yml" ]
