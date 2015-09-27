#!/bin/sh
IMG_DIR=output/images
BOOT_DIR=/media/`whoami`/boot
#touch /home/smipi1/Projects/elce2015/buildroot/output/build/linux-*/.stamp_configured &&
#	make &&
	cp -v ${IMG_DIR}/MLO ${BOOT_DIR} &&
	cp -v ${IMG_DIR}/u-boot.img ${BOOT_DIR} &&
	cp -v ${IMG_DIR}/am335x-boneblack.dtb ${BOOT_DIR} &&
	cp -v ${IMG_DIR}/zImage ${BOOT_DIR} &&
	cp -v ${IMG_DIR}/uEnv.txt ${BOOT_DIR} &&
	ls ${BOOT_DIR} -lh &&
	sha1sum ${BOOT_DIR}/*
