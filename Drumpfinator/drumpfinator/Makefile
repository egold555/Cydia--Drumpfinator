include theos/makefiles/common.mk

TWEAK_NAME = Drumpfinator
Drumpfinator_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += drumpfinator
include $(THEOS_MAKE_PATH)/aggregate.mk
