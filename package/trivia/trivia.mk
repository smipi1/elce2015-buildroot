################################################################################
#
# trivia
#
################################################################################

TRIVIA_VERSION = master
TRIVIA_SITE = $(call github,smipi1,onion,$(TRIVIA_VERSION))
TRIVIA_LICENSE = MIT
TRIVIA_LICENSE_FILES = LICENSE
TRIVIA_BUILDDIR = $(TRIVIA_DIR)/$(TRIVIA_SUBDIR)
TRIVIA_EXT_SRCDIR = $(TOPDIR)/../demo/onion
#TRIVIA_TOOLCHAIN_FILE=$(TOPDIR)/package/trivia/toolchainfile.cmake
TRIVIA_TOOLCHAIN_FILE=$(HOST_DIR)/usr/share/buildroot/toolchainfile.cmake

define TRIVIA_EXTRACT_CMDS
endef

define TRIVIA_EXTRACT_CMDS
endef

define TRIVIA_CONFIGURE_CMDS
	(mkdir -p $(TRIVIA_BUILDDIR) && \
	cd $(TRIVIA_BUILDDIR) && \
	rm -f CMakeCache.txt && \
	PATH=$(BR_PATH) \
	$(TRIVIA_CONF_ENV) $(HOST_DIR)/usr/bin/cmake $(TRIVIA_EXT_SRCDIR) \
		-DCMAKE_TOOLCHAIN_FILE="$(TRIVIA_TOOLCHAIN_FILE)" \
		-DCMAKE_BUILD_TYPE=$(if $(BR2_ENABLE_DEBUG),Debug,Release) \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		-DCMAKE_COLOR_MAKEFILE=OFF \
		-DBUILD_DOC=OFF \
		-DBUILD_DOCS=OFF \
		-DBUILD_EXAMPLE=OFF \
		-DBUILD_EXAMPLES=OFF \
		-DBUILD_TEST=OFF \
		-DBUILD_TESTS=OFF \
		-DBUILD_TESTING=OFF \
		-DBUILD_SHARED_LIBS=$(if $(BR2_STATIC_LIBS),OFF,ON) \
		-DUSE_CCACHE=$(if $(BR2_CCACHE),ON,OFF) \
		$(CMAKE_QUIET) \
		$(TRIVIA_CONF_OPTS) \
	)
endef

define TRIVIA_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TRIVIA_MAKE_ENV) $(TRIVIA_MAKE) $(TRIVIA_MAKE_OPTS) $(TRIVIA_INSTALL_TARGET_OPTS) -C $(TRIVIA_BUILDDIR)
	$(INSTALL) -m 0755 -D $(@D)/examples/trivia/trivia $(TARGET_DIR)/usr/bin/
endef

$(eval $(cmake-package))
