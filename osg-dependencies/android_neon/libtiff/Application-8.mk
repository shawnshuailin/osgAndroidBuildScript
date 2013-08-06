#ANDROID APPLICATION MAKEFILE
APP_BUILD_SCRIPT := ./Android.mk

APP_OPTIM := release

APP_PLATFORM 	:= android-8

APP_STL 		:= gnustl_static
APP_CFLAGS      :=
APP_CPPFLAGS 	:= -fexceptions -frtti
APP_LDFLAGS     :=
APP_ABI 		:= armeabi armeabi-v7a

APP_MODULES     := libtiff
