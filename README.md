# Prometheus monitoring

Build with:

```sh
docker build -f prometheus.dockerfile -t prometheus:latest .
```

Run with:

```sh
docker run --rm -ti -p 9090:9090 -v /${PWD}/prometheus:/usr/prometheus/config prometheus:latest
```
