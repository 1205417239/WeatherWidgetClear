ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WeatherWidgetClear

WeatherWidgetClear_FILES = Tweak.xm
WeatherWidgetClear_CFLAGS = -fobjc-arc
WeatherWidgetClear_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
