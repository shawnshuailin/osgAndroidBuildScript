LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libjpeg

LOCAL_ARM_MODE := arm   

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := false
endif

LOCAL_SRC_FILES :=   jerror.c jmemmgr.c jcapimin.c jcparam.c jdapimin.c jdhuff.c jfdctflt.c jdcoefct.c jidctint.c jdcolor.c jchuff.c jidctfst.c jutils.c jidctflt.c jcmainct.c jcdctmgr.c jddctmgr.c jdatadst.c jaricom.c jdinput.c jdtrans.c jdarith.c jdmaster.c jdsample.c jcmarker.c jcomapi.c jdmerge.c jcinit.c jcarith.c jdapistd.c jdatasrc.c jfdctfst.c jccoefct.c jctrans.c jccolor.c jcprepct.c jquant2.c transupp.c jdmainct.c jcmaster.c jquant1.c jmemansi.c jcsample.c jdmarker.c jcapistd.c jfdctint.c jdpostct.c

#armv6_idct.S
	
LOCAL_CFLAGS := 

LOCAL_C_INCLUDES :=  $(LOCAL_PATH)

include $(BUILD_STATIC_LIBRARY)
