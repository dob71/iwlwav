include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=iwlwav-iw
PKG_REV:=2661aff5fbd3ca7259bc5bab5df7419d1571976d
PKG_VERSION:=4.14
PKG_RELEASE:=$(PKG_REV)
PKG_BASE_NAME:=iwlwav-iw
PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/iwlwav-iw.git
PKG_SOURCE_SUBDIR:=$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_DEFAULT_CUSTOM_SOURCE_DIR:=$(shell pwd)
SBIN_FOLDER:=usr/sbin
PKG_BUILD_DEPENDS:=libnl3 libnl PACKAGE_ltq-wlan-wave_6x-uci:ltq-wlan-wave_6x-uci

include $(INCLUDE_DIR)/package.mk

define Package/iwlwav-iw
  SECTION:=net
  CATEGORY:=Network
  TITLE:=iw for Wave
  DEPENDS:=+libnl
  MENU:=1
endef

define Package/iwlwav-iw/description
  iw for Wave
endef

LIBNL_DIR:=$(wildcard $(BUILD_DIR)/libnl-3*)

IFX_CFLAGS += -I$(LIBNL_DIR)/include
IFX_LDFLAGS += -L$(LIBNL_DIR)/lib/.libs -lnl-3

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) clean
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(PKG_BUILD_DIR) \
		IFX_CFLAGS="$(IFX_CFLAGS)" IFX_LDFLAGS="$(IFX_LDFLAGS)"
endef

define Package/iwlwav-iw/install
	$(INSTALL_DIR) $(1)/$(SBIN_FOLDER)
	$(INSTALL_DIR) -p $(1)/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iw $(1)/$(SBIN_FOLDER)/
	echo -e "iwlwav_iw_hash=\"$(PKG_REV)\"\niwlwav_iw_tag=\"$(PKG_REV)\"" > $(1)/etc/iwlwav_iw.ver
endef

$(eval $(call BuildPackage,iwlwav-iw))
