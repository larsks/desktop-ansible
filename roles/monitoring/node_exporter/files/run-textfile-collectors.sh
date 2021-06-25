#!/bin/sh

set -eu

LOG () {
	echo "${0##*/}: $*" >&2
}

DIE () {
	LOG "ERROR: $*"
	exit 1
}

if [ -z "$1" ]; then
	DIE "usage: $0 <directory>"
fi

: ${PROM_TEXTFILE_DIR:=/etc/prometheus/textfile}

intervaldir=$1

readarray -t collectors < <(find $intervaldir -maxdepth 1 -type f -perm -001 -print)
LOG "running ${#collectors[*]} collectors in $intervaldir"

for collector in "${collectors[@]}"; do
	base=${collector##*/}
	base=${base%.*}

	LOG "collecting from $collector"
	$collector | sponge "$PROM_TEXTFILE_DIR/$base.prom"
done
