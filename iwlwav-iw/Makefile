include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=iwlwav-iw
PKG_REV:=2661aff5fbd3ca7259bc5bab5df7419d1571976d
PKG_VERSION:=4.14
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/iwlwav-iw.git
PKG_SOURCE_VERSION:=2661aff5fbd3ca7259bc5bab5df7419d1571976d
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk

define Package/iwlwav-iw
  SECTION:=net
  CATEGORY:=Network
  TITLE:=iw for Wave
  DEPENDS:=+libnl +iwlwav-driver-uci
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
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) -p $(1)/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/iw $(1)/usr/sbin/
	echo -e "iwlwav_iw_hash=\"$(PKG_REV)\"\niwlwav_iw_tag=\"$(PKG_REV)\"" > $(1)/etc/iwlwav_iw.ver
endef

$(eval $(call BuildPackage,iwlwav-iw))
