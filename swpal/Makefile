#
# Openwrt Makefile for libspal
#
#

#### Includes ###################################
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

#### Package Info ############################### 
PKG_NAME:=libspal
PKG_SOURCE_VERSION:=6.1.0
PKG_VERSION:=$(PKG_SOURCE_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/swpal.git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_VERSION)


include $(INCLUDE_DIR)/package.mk
-include $(STAGING_DIR)/mk/ugw-loglevel.mk

define Package/$(PKG_NAME)
  SECTION:=utils
  CATEGORY:=Intel
  SUBMENU:=UGW Static Config Updates SWPAL
  TITLE:=Intel WLAN SL
  URL:=http://www.intel.com
  MAINTAINER:=Intel Corporation
  DEPENDS:= +libugwhelper +libcal +csd +servd +libuci +safeclibs
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Intel SWPAL for WLAN Support
endef

PKG_BUILD_DEPENDS:=libugwhelper libuci

ifeq ($(CONFIG_USE_MUSL),y)
  TARGET_CFLAGS += -DCONFIG_USE_MUSL
endif
  
TARGET_CFLAGS += -DCONFIG_RPCD

# To ipkg / Rootfs
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/$(VENDOR_PATH)/usr/lib
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/lib/wifi
	$(INSTALL_DIR) $(1)/lib/netifd
	$(INSTALL_DIR) $(1)/lib/netifd/wireless
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_DIR) $(1)/opt/intel/wave/scripts/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libspal.so $(1)/$(VENDOR_PATH)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/lib/netifd/netifd-wireless.sh $(1)/lib/netifd/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/lib/netifd/hostapd.sh $(1)/lib/netifd/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/lib/netifd/wireless/* $(1)/lib/netifd/wireless/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/lib/wifi/* $(1)/lib/wifi/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/sbin/wifi $(1)/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/etc/wave/scripts/load_dut.sh $(1)/opt/intel/wave/scripts/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/etc/wave/scripts/flash_file_saver.sh $(1)/opt/intel/wave/scripts/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/scripts/etc/wave/scripts/debug_toolbox.sh $(1)/opt/intel/wave/scripts/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libspal.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/include/uci_wrapper.h $(1)/usr/include/
endef

define Build/Clean
	if [ -d $(PKG_BUILD_DIR) ]; then $(MAKE) -C $(PKG_BUILD_DIR) clean; \
	$(RM) -r $(PKG_BUILD_DIR)/ipkg-$(BOARD); fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
