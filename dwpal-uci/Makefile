#
# Openwrt Makefile for dwpal
#

#### Includes ###################################
include $(TOPDIR)/rules.mk

#### Package Info ############################### 
PKG_NAME:=dwpal_6x-uci
PKG_REV:=eb4964a4f17eccc5b18c70a8038abbceda2709d3
PKG_VERSION:=1.0.0.1
PKG_RELEASE:=$(PKG_REV)
PKG_BASE_NAME:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/dwpal.git
PKG_SOURCE_SUBDIR:=$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git
#PKG_MD5SUM:=40b89c61036add0c2dd1fc10767d3b5f

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_DEFAULT_CUSTOM_SOURCE_DIR:=$(shell pwd)


PKG_BUILD_DEPENDS:=libnl3 libnl librt libncurses iwlwav-hostap-uci iwlwav-iw PACKAGE_safeclibs libreadline

include $(INCLUDE_DIR)/package.mk
define Package/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Intel
  SUBMENU:=UGW Software
  TITLE:=D-WPAL Library
  URL:=http://www.intel.com
  MAINTAINER:=Intel Corporation
  DEPENDS:= +libnl +librt +libsafec +libncurses +libreadline
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	D-WPAL: Dynamic Wireless Platform Abstraction Layer
endef

#### Directory Paths ############################
LIBNL_DIR:=$(wildcard $(BUILD_DIR)/libnl-3*)

IWLWAV_HOSTAP_DIR:=$(wildcard $(BUILD_DIR)/iwlwav-hostap-uci-*)
IWLWAV_IW_DIR:=$(wildcard $(BUILD_DIR)/iwlwav-iw-*)

IFX_CFLAGS += -I$(IWLWAV_IW_DIR) -I$(IWLWAV_HOSTAP_DIR)/src/common/ -I$(IWLWAV_HOSTAP_DIR)/src/utils/ -I$(LIBNL_DIR)/include
IFX_LDFLAGS += -L$(LIBNL_DIR)/lib/.libs -lnl-3


#### Target Rules ###############################
define Build/Compile
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(PKG_BUILD_DIR) \
		IFX_CFLAGS="$(IFX_CFLAGS)" IFX_LDFLAGS="$(IFX_LDFLAGS)" IWLWAV_HOSTAP_DIR="$(IWLWAV_HOSTAP_DIR)" IWLWAV_IW_DIR="$(IWLWAV_IW_DIR)"
endef

# To ipkg / Rootfs
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/opt/intel/wave/scripts/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libdwpal.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dwpal_cli $(1)/usr/sbin
	chmod 555 $(1)/usr/sbin/dwpal_cli
endef

define Build/Clean
	if [ -d $(PKG_BUILD_DIR) ]; then $(MAKE) -C $(PKG_BUILD_DIR) clean; \
	$(RM) -r $(PKG_BUILD_DIR)/ipkg-$(BOARD); fi
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libdwpal.so $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/include/*.h $(1)/usr/include/
	#$(INSTALL_BIN) $(PKG_BUILD_DIR)/*.h $(1)/usr/include/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
