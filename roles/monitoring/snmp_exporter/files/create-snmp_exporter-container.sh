#!/bin/sh

: ${SNMP_EXPORTER_VERSION:=latest}

if ! podman container exists snmp_exporter; then
	podman container create \
		--name snmp_exporter \
		--conmon-pidfile=/run/snmp_exporter.pid \
		--net=host \
		quay.io/prometheus/snmp-exporter:${SNMP_EXPORTER_VERSION}
fi
