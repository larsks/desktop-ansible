#!/bin/sh

if ! podman container exists grafana; then
	podman container create \
		--name grafana \
		--conmon-pidfile=/run/grafana.pid \
		-v grafana_data:/var/lib/grafana \
		-v /etc/grafana:/etc/grafana \
		--net=host \
		docker.io/grafana/grafana
fi
