include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=iwlwav-hostap-uci
PKG_REV:=9fef901a55596770b3e710c9195a4eff0ed1bfbf
PKG_VERSION:=2.6
PKG_RELEASE:=$(PKG_REV)
PKG_BASE_NAME:=iwlwav-hostap-uci
PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/iwlwav-hostap.git
PKG_SOURCE_SUBDIR:=$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_DEFAULT_CUSTOM_SOURCE_DIR:=$(shell pwd)
BIN_FOLDER:=/usr/sbin
PKG_BUILD_DIR_HAPD:=$(PKG_BUILD_DIR)/hostapd
PKG_BUILD_DIR_WPAS:=$(PKG_BUILD_DIR)/wpa_supplicant
PKG_BUILD_DEPENDS:=libopenssl libnl3 librt libnl PACKAGE_ltq-wlan-wave_6x-uci:ltq-wlan-wave_6x-uci
PKG_CONFIG_DEPENDS:=CONFIG_WIRELESS_STA

include $(INCLUDE_DIR)/package.mk

define Package/iwlwav-hostap-uci
  SECTION:=net
  CATEGORY:=Network
  TITLE:=hostapd for Wave
  DEPENDS:=+libopenssl +librt +libnl
  MENU:=1
endef

define Package/iwlwav-hostap-uci/description
  IEEE 802.11 AP, IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
endef

define Package/iwlwav-hostap-uci/config
	config WIRELESS_STA
	  depends on PACKAGE_iwlwav-hostap-uci
	  bool 'Linux WPA/WPA2/IEEE 802.1X Supplicant support'
	  help
	      Linux WPA/WPA2/IEEE 802.1X Supplicant
endef

OPENSSL_DIR:=$(wildcard $(BUILD_DIR)/openssl-*)
LIBNL_DIR:=$(wildcard $(BUILD_DIR)/libnl-3*)
LIBRT_DIR:=$(wildcard $(BUILD_DIR)/toolchain/ipkg-lantiq/librt)

IFX_CFLAGS += -I$(OPENSSL_DIR)/include -I$(LIBNL_DIR)/include
IFX_LDFLAGS += -L$(OPENSSL_DIR)/ -L$(LIBNL_DIR)/lib/.libs -lnl-3 -L$(LIBRT_DIR)/lib -lrt

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/src clean
	$(CP) $(PKG_BUILD_DIR_HAPD)/defconfig $(PKG_BUILD_DIR_HAPD)/.config
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(PKG_BUILD_DIR_HAPD) \
		IFX_CFLAGS="$(IFX_CFLAGS)" IFX_LDFLAGS="$(IFX_LDFLAGS)"
	$(if $(CONFIG_WIRELESS_STA), \
		$(MAKE) -C $(PKG_BUILD_DIR)/src clean; \
		$(CP) $(PKG_BUILD_DIR_WPAS)/defconfig $(PKG_BUILD_DIR_WPAS)/.config; \
		$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(PKG_BUILD_DIR_WPAS) \
		    IFX_CFLAGS="$(IFX_CFLAGS)" IFX_LDFLAGS="$(IFX_LDFLAGS)" \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/src/common/wpa_ctrl.h $(1)/usr/include
endef

define Package/iwlwav-hostap-uci/install
	$(INSTALL_DIR) $(1)/$(BIN_FOLDER)
	$(INSTALL_DIR) -p $(1)/etc
	$(INSTALL_BIN) $(PKG_BUILD_DIR_HAPD)/hostapd $(1)/$(BIN_FOLDER)
	$(INSTALL_BIN) $(PKG_BUILD_DIR_HAPD)/hostapd_cli $(1)/$(BIN_FOLDER)
	$(INSTALL_BIN) $(PKG_BUILD_DIR_HAPD)/hostapd.eap_user $(1)/$(BIN_FOLDER)
	$(if $(CONFIG_WIRELESS_STA), \
		$(INSTALL_BIN) $(PKG_BUILD_DIR_WPAS)/wpa_supplicant $(1)/$(BIN_FOLDER); \
		$(INSTALL_BIN) $(PKG_BUILD_DIR_WPAS)/wpa_cli $(1)/$(BIN_FOLDER); \
		$(INSTALL_BIN) $(PKG_BUILD_DIR_WPAS)/wpa_passphrase $(1)/$(BIN_FOLDER) \
	)
	echo -e "iwlwav_hostap_hash=\"$(PKG_REV)\"\niwlwav_hostap_tag=\"$(PKG_REV)\"" > $(1)/etc/iwlwav_hostap.ver
endef

$(eval $(call BuildPackage,iwlwav-hostap-uci))
