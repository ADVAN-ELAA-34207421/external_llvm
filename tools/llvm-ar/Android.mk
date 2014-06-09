LOCAL_PATH := $(call my-dir)

LLVM_ROOT_PATH := $(LOCAL_PATH)/../..


#===---------------------------------------------------------------===
# llvm-ar command line tool
#===---------------------------------------------------------------===

llvm_ar_SRC_FILES := \
  llvm-ar.cpp

llvm_ar_STATIC_LIBRARIES := \
  libLLVMObject             \
  libLLVMBitReader          \
  libLLVMCore               \
  libLLVMSupport            \

include $(CLEAR_VARS)

LOCAL_MODULE := llvm-ar
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_IS_HOST_MODULE := true

LOCAL_SRC_FILES := $(llvm_ar_SRC_FILES)

LOCAL_STATIC_LIBRARIES := $(llvm_ar_STATIC_LIBRARIES)

LOCAL_LDLIBS += -lpthread -lm -ldl

include $(LLVM_ROOT_PATH)/llvm.mk
include $(LLVM_HOST_BUILD_MK)
include $(BUILD_HOST_EXECUTABLE)

LLVM_RANLIB = $(HOST_OUT)/bin/llvm-ranlib

# Make sure if llvm-ar (i.e. $(LOCAL_MODULE)) get installed,
# llvm-ranlib will get installed as well.
ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(LLVM_RANLIB)
# the additional dependency is needed when you run mm/mmm.
$(LOCAL_MODULE) : $(LLVM_RANLIB)

# Symlink for llvm-ranlib
$(LLVM_RANLIB) : $(LOCAL_INSTALLED_MODULE)
	@echo "Symlink $@ -> $<"
	$(hide) ln -sf $(notdir $<) $@
