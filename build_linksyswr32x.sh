#!/bin/bash

#Documentation: https://openwrt.org/docs/guide-user/additional-software/imagebuilder

OUTPUT="$(pwd)/images"
BUILDER="https://downloads.openwrt.org/releases/21.02.3/targets/mvebu/cortexa9/openwrt-imagebuilder-21.02.3-mvebu-cortexa9.Linux-x86_64.tar.xz"
#KERNEL_PARTSIZE=128 #Kernel-Partitionsize in MB
#ROOTFS_PARTSIZE=4096 #Rootfs-Partitionsize in MB

# download image builder
if [ ! -f "${BUILDER##*/}" ]; then
	wget "$BUILDER"
	tar xJvf "${BUILDER##*/}"
fi

mkdir "$OUTPUT"
cd openwrt-*/

# list all targets for this image builder, consider 'make help' as well
# make info

# clean previous images
make clean

# Packages are added if no prefix is given, '-packaganame' does not integrate a package
#sed -i "s/CONFIG_TARGET_KERNEL_PARTSIZE=.*/CONFIG_TARGET_KERNEL_PARTSIZE=$KERNEL_PARTSIZE/g" .config
#sed -i "s/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=$ROOTFS_PARTSIZE/g" .config

make image  PROFILE="linksys_wrt32x" \
           PACKAGES="block-mount kmod-fs-ext4 kmod-usb-storage blkid mount-utils swap-utils e2fsprogs fdisk luci dnsmasq" \
            FILES="/home/ubuntu/Seafile/OpenWRT/build_script/AUTO_EXTROOT_BUILDS/wrt32x/files" \
            BIN_DIR="$OUTPUT"
