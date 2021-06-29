IMAGE=quay.io/prometheus/snmp-generator
MIBDIR=$(HOME)/src/librenms/mibs/

snmp.yml: generator.yml
	podman run --rm \
		-v $(PWD):/data:z \
		-v $(MIBDIR):/mibs:z \
		-w /data \
		-e MIBDIRS=/mibs \
		$(IMAGE) generate
