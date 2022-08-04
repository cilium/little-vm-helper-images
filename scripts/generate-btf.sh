#!/bin/sh

set -e

if [ -z $1 ]; then
	echo "Usage: $0 <kernel_install_dir>"
	exit 1
fi

dir="$1"
bootdir="$dir/boot"

for fname in $bootdir/vmlinux-*; do
	kernel=$(basename $fname)
	ver=$(echo $kernel | sed -e 's/vmlinux-//')
	outfile="$bootdir/kernel-${ver}.btf"
	rm -f $outfile
	pahole --btf_encode_detached=$outfile $fname
	echo "Generated $outfile"
done
