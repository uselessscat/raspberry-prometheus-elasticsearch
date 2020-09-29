
Build with:

    docker build -f prometheus.dockerfile -t prometheus:latest .

Run with:

    docker run --rm -ti -p 9090 -v /$PWD/prometheus:/usr/prometheus prometheus:latest