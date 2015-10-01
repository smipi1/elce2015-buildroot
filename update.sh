#!/bin/sh
IMG_DIR=output/images
BOOT_DIR=/media/`whoami`/boot

hasLocalChanges() {
	[ -n "`git diff-index --name-only HEAD --`" ] &&
		return 0 ||
		return 1
}

head() {
	git show-ref HEAD | awk '{print $1}'
}

releaseName() {
	if hasLocalChanges; then
		echo "`head`++"
	else
		head
	fi
}

copyImagesTo() {
	cp -v ${IMG_DIR}/MLO ${1} &&
	cp -v ${IMG_DIR}/u-boot.img ${1} &&
	cp -v ${IMG_DIR}/am335x-boneblack.dtb ${1} &&
	cp -v ${IMG_DIR}/zImage ${1} &&
	cp -v ${IMG_DIR}/uEnv.txt ${1} &&
	return 0 ||
	return 1
}

RELEASE_DIR=../releases/`releaseName`

[ "${1}" = "tclean" ] && make trivia-dirclean all

mkdir -p -v ${RELEASE_DIR} &&
	touch /home/smipi1/Projects/elce2015/buildroot/output/build/linux-*/.stamp_configured &&
	make &&
	copyImagesTo ${RELEASE_DIR} &&
	copyImagesTo ${BOOT_DIR} &&
	ls ${BOOT_DIR} -lh &&
	sha1sum ${BOOT_DIR}/*
