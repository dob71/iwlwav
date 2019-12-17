include $(TOPDIR)/rules.mk

PKG_NAME:=dwpal_6x-uci
PKG_VERSION:=1.0.0.1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/dwpal.git
PKG_SOURCE_VERSION:=eb4964a4f17eccc5b18c70a8038abbceda2709d3
PKG_SOURCE_PROTO:=git
PKG_BUILD_DIR:=$(BUILD_DIR)/dwpal_6x-uci-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/dwpal_6x-uci
  SECTION:=net
  CATEGORY:=Intel
  SUBMENU:=UGW Software
  TITLE:=D-WPAL Library
  URL:=http://www.intel.com
  MAINTAINER:=Intel Corporation
  DEPENDS:= +libnl +librt +libsafec +libncurses +libreadline +iwlwav-hostap-uci
  MENU:=1
endef

define Package/dwpal_6x-uci/description
	D-WPAL: Dynamic Wireless Platform Abstraction Layer
endef

LIBNL_DIR:=$(wildcard $(BUILD_DIR)/libnl-3*)

IWLWAV_HOSTAP_DIR:=$(KERNEL_BUILD_DIR)/iwlwav-hostap-uci-2.6
IWLWAV_IW_DIR:=$(wildcard $(BUILD_DIR)/iwlwav-iw-*)

IFX_CFLAGS += -I$(IWLWAV_IW_DIR) -I$(IWLWAV_HOSTAP_DIR)/src/common/ -I$(IWLWAV_HOSTAP_DIR)/src/utils/ -I$(LIBNL_DIR)/include
IFX_LDFLAGS += -L$(LIBNL_DIR)/lib/.libs -lnl-3

define Build/Compile
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(PKG_BUILD_DIR) \
		IFX_CFLAGS="$(IFX_CFLAGS)" IFX_LDFLAGS="$(IFX_LDFLAGS)" IWLWAV_HOSTAP_DIR="$(IWLWAV_HOSTAP_DIR)" IWLWAV_IW_DIR="$(IWLWAV_IW_DIR)"
endef

define Package/dwpal_6x-uci/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/opt/intel/wave/scripts/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libdwpal.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dwpal_cli $(1)/usr/sbin
	chmod 555 $(1)/usr/sbin/dwpal_cli
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libdwpal.so $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/include/*.h $(1)/usr/include/
	#$(INSTALL_BIN) $(PKG_BUILD_DIR)/*.h $(1)/usr/include/
endef

$(eval $(call BuildPackage,dwpal_6x-uci))
