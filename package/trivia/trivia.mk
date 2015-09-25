################################################################################
#
# trivia
#
################################################################################

TRIVIA_VERSION = master
TRIVIA_SITE = $(call github,smipi1,onion,$(TRIVIA_VERSION))
TRIVIA_LICENSE = MIT
TRIVIA_DEPENDENCIES = host-trivia
TRIVIA_LICENSE_FILES = LICENSE

define TRIVIA_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TRIVIA_MAKE_ENV) $(TRIVIA_MAKE) $(TRIVIA_MAKE_OPTS) $(TRIVIA_INSTALL_TARGET_OPTS) -C $(TRIVIA_BUILDDIR)
	$(INSTALL) -m 0644 -D $(@D)/examples/trivia/trivia $(TARGET_DIR)/usr/bin/
endef

$(eval $(cmake-package))
$(eval $(host-cmake-package))
