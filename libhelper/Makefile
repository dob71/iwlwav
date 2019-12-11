include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=libhelper
PKG_SOURCE_VERSION:=2.3.0.8
PKG_SOURCE_PROTO:=git
PKG_SOURCE_NAME:=ugw_sdk
PKG_SOURCE_INNERDIR:=helper/libhelper
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_ugw/$(PKG_SOURCE_NAME).git

PKG_BUILD_DIR:=$(BUILD_DIR)/libhelper-$(PKG_SOURCE_VERSION)
PKG_MAINTAINER:=Intel
PKG_LICENSE:=LGPL2.1

include $(INCLUDE_DIR)/package.mk
-include $(STAGING_DIR)/mk/ugw-loglevel.mk

define Package/libhelper
  SECTION:=utils
  CATEGORY:=Intel
  SUBMENU:=UGW Framework
  TITLE:=UGW SDK Helper library
  URL:=http://www.intel.com
  MAINTAINER:=Intel Corporation
  DEPENDS:=+libsafec
  MENU:=1
endef

define Package/libhelper/description
	UGW SDK Helper Library to define function,prototypes,structs,enums which are
	used for list manipulation and debug purposes.
endef

define Package/libhelper/config
	config libhelper_MEM_DEBUG
	depends on PACKAGE_libhelper
		bool "Memory Debug"
		help
		  Memory Debug
endef

TARGET_CFLAGS += $(if $(CONFIG_libugwhelper_MEM_DEBUG),-DMEM_DEBUG)

define Build/Prepare
	$(call Build/Prepare/Default)
	$(INSTALL_DIR) $(STAGING_DIR)/usr/include
	touch $(STAGING_DIR)/usr/include/vendor.h
	echo "#define VENDOR_PATH \"$(VENDOR_PATH)\"" > $(STAGING_DIR)/usr/include/vendor.h
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/docs
	$(INSTALL_DIR) $(STAGING_DIR)/mk/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/include/*.h $(1)/usr/include/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/include/*.h $(1)/usr/docs/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libhelper.so $(1)/usr/lib/
	$(INSTALL_DATA) ./files/ugw-loglevel.mk $(STAGING_DIR)/mk/
	$(RM) $(1)/usr/docs/list.h
endef

define Package/libhelper/install
	$(INSTALL_DIR) $(1)/$(VENDOR_PATH)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libhelper.so $(1)/$(VENDOR_PATH)/usr/lib/
endef

$(eval $(call BuildPackage,libhelper))
