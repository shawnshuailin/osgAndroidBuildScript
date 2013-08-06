LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE:= libft2

LOCAL_ARM_MODE := arm   

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := false
endif

LOCAL_SRC_FILES:= \
	src/base/ftbbox.c \
	src/base/ftbitmap.c \
	src/base/ftglyph.c \
	src/base/ftstroke.c \
	src/base/ftxf86.c \
	src/base/ftbase.c \
	src/base/ftsystem.c \
	src/base/ftinit.c \
	src/base/ftgasp.c \
	src/base/ftdebug.c \
    src/base/ftcid.c \
    src/base/ftfstype.c \
	src/base/ftgxval.c \
	src/base/ftlcdfil.c \
    src/base/ftmm.c \
    src/base/ftotval.c \
    src/base/ftpatent.c \
    src/base/ftsynth.c \
    src/base/fttype1.c \
    src/psnames/psnames.c \
	src/pshinter/pshinter.c \
    src/psaux/psaux.c \
    src/cache/ftcache.c \
	src/autofit/autofit.c \
    src/raster/raster.c \
	src/smooth/smooth.c \
	src/truetype/truetype.c \
	src/type1/type1.c \
	src/type42/type42.c \
    src/cid/type1cid.c \
	src/cff/cff.c \
	src/bdf/bdf.c \
	src/pcf/pcf.c \
	src/pfr/pfr.c \
	src/sfnt/sfnt.c \
	src/winfonts/winfnt.c \
    src/otvalid/otvalid.c \
    src/gxvalid/gxvalid.c

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/builds \
	$(LOCAL_PATH)/include

LOCAL_CFLAGS += -W -Wall
LOCAL_CFLAGS += -fPIC -DPIC
#LOCAL_CFLAGS += "-DDARWIN_NO_CARBON"
LOCAL_CFLAGS += "-DFT2_BUILD_LIBRARY"

LOCAL_CFLAGS += -O2

include $(BUILD_STATIC_LIBRARY)
