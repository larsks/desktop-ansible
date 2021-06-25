#!/bin/sh

: ${PROM_DIR:=/etc/prometheus}
: ${PROM_CONF:=$PROM_DIR/prometheus.yml}

if [ ! -f $PROM_CONF ]; then
	echo "ERROR: missing configuration $PROM_CONF" >&2
	exit 1
fi

if ! podman container exists prometheus; then
	podman container create \
		--name prometheus \
		--conmon-pidfile=/run/prometheus.pid \
		--net=host \
		-v $PROM_DIR:$PROM_DIR \
		-v prom_data:/prometheus \
		prom/prometheus
fi
