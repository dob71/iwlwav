include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=iwlwav-driver-uci
PKG_REV:=152720864ca7dc06c0d3b298c47b1b1d1f1bc2f8
PKG_VERSION:=6.1.0
PKG_RELEASE:=$(PKG_REV)
PKG_SOURCE:=iwlwav-driver-uci-$(PKG_VERSION)-$(PKG_REV).tar.bz2
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/iwlwav-dev.git
PKG_SOURCE_SUBDIR:=iwlwav-driver-uci-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git
PKG_BUILD_DIR:=$(BUILD_DIR)/iwlwav-driver-uci-$(PKG_VERSION)
CONFIG_FOLDER:=../lq-wave-300_6x-uci/files/config
PKG_BUILD_DEPENDS:=kmod-directconnect-dp

CONFIG_FILE:=GRX350_GRX550_WAVE600_CONFIG
ifeq ($(CONFIG_TARGET_lantiq_xrx500_easy350_anywan_axepoint),y)
 CONFIG_FILE:=AXEPOINT_WAVE600_CONFIG
endif

include $(INCLUDE_DIR)/package.mk

define Package/iwlwav-driver-uci
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Wave Driver
  DEPENDS:=+kmod-iwlwav-driver-kernel-uci
  MENU:=1
endef

define Package/iwlwav-driver-uci/description
  Wave driver package
endef

define KernelPackage/iwlwav-driver-kernel-uci
  SUBMENU:=Intel
  TITLE:=Kernel Support for Wave WLAN
  DEPENDS:=+PACKAGE_kmod-directconnect-dp:kmod-directconnect-dp
  KCONFIG:= \
    CONFIG_CRYPTO_SHA256=y \
    CONFIG_FW_LOADER=y \
    CONFIG_HOTPLUG=y \
    CONFIG_WIRELESS=y \
    CONFIG_CRYPTO_CCM=y \
    CONFIG_CRYPTO_CMAC=y \
    CONFIG_ATH5K_PCI=n \
    CONFIG_CFG80211=m \
    CONFIG_CFG80211_CRDA_SUPPORT=y \
    CONFIG_CFG80211_DEBUGFS=n \
    CONFIG_CFG80211_DEFAULT_PS=y \
    CONFIG_CFG80211_DEVELOPER_WARNINGS=n \
    CONFIG_CFG80211_INTERNAL_REGDB=n \
    CONFIG_CFG80211_WEXT=y \
    CONFIG_CFG80211_WEXT_EXPORT=y \
    CONFIG_IWL4965=n \
    CONFIG_LTQ_DATAPATH_CPUFREQ=n \
    CONFIG_LTQ_DATAPATH_PTP1588=n \
    CONFIG_LTQ_DATAPATH_PTP1588_SW_WORKAROUND=n \
    CONFIG_MAC80211=m \
    CONFIG_MAC80211_DEBUGFS=n \
    CONFIG_MAC80211_DEBUG_MENU=n \
    CONFIG_MAC80211_HAS_RC=y \
    CONFIG_MAC80211_HWSIM=n \
    CONFIG_MAC80211_LEDS=n \
    CONFIG_MAC80211_MESH=n \
    CONFIG_MAC80211_RC_DEFAULT="minstrel_ht" \
    CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y \
    CONFIG_MAC80211_RC_MINSTREL=y \
    CONFIG_MAC80211_RC_MINSTREL_HT=y \
    CONFIG_MAC80211_RC_MINSTREL_VHT=n \
    CONFIG_MCAST_HELPER_PACKAGE=n \
    CONFIG_MCAST_HELPER_REG=n \
    CONFIG_MDIO_BOARDINFO=y \
    CONFIG_MT7601U=n \
    CONFIG_MWIFIEX=n \
    CONFIG_NL80211_TESTMODE=n \
    CONFIG_RSI_91X=n \
    CONFIG_RTL8XXXU=n \
    CONFIG_WCN36XX=n \
    CONFIG_WIFI_PROXY_DEBUG=n \
    CONFIG_WIL6210=n \
    CONFIG_WILC1000_SPI=n \
    CONFIG_WLAN_VENDOR_ADMTEK=y \
    CONFIG_WLAN_VENDOR_ATH=y \
    CONFIG_WLAN_VENDOR_ATMEL=y \
    CONFIG_WLAN_VENDOR_BROADCOM=y \
    CONFIG_WLAN_VENDOR_CISCO=y \
    CONFIG_WLAN_VENDOR_INTEL=y \
    CONFIG_WLAN_VENDOR_INTERSIL=y \
    CONFIG_WLAN_VENDOR_MARVELL=y \
    CONFIG_WLAN_VENDOR_MEDIATEK=y \
    CONFIG_WLAN_VENDOR_RALINK=y \
    CONFIG_WLAN_VENDOR_REALTEK=y \
    CONFIG_WLAN_VENDOR_RSI=y \
    CONFIG_WLAN_VENDOR_ST=y \
    CONFIG_WLAN_VENDOR_TI=y \
    CONFIG_WLAN_VENDOR_ZYDAS=y
endef

define KernelPackage/iwlwav-driver-kernel-uci/description
 Enable Wlan related options in Kernel
endef

CROSS_COMPILE=$(if $(CONFIG_EXTERNAL_TOOLCHAIN),$(CONFIG_TOOLCHAIN_ROOT)/bin/$(CONFIG_TOOLCHAIN_PREFIX),$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)) # fix for non external toolchain!

define Build/Compile
	@echo "Config files use: $(CONFIG_FILE)"
	$(SED) '1s/.*/BACKPORTS_VERSION="v$(LINUX_VERSION)"/' $(PKG_BUILD_DIR)/versions
	$(CP) $(CONFIG_FOLDER)/$(CONFIG_FILE) $(PKG_BUILD_DIR)/defconfigs/iwlwav
	$(MAKE) -C $(PKG_BUILD_DIR) defconfig-iwlwav KLIB_BUILD=$(LINUX_DIR) KLIB=$(TARGET_DIR)/$(TARGET_MODULES_DIR)
	$(MAKE) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH) KLIB_BUILD=$(LINUX_DIR) KLIB=$(TARGET_DIR)/$(TARGET_MODULES_DIR) UGW_DRIVER_VERSION=$(PKG_REV)
endef

define Package/iwlwav-driver-uci/install
	$(INSTALL_DIR) $(1)/lib/modules/$(LINUX_VERSION)
	$(INSTALL_DIR) $(1)/opt/intel/lib/modules/$(LINUX_VERSION)/net
	$(INSTALL_DIR) $(STAGING_DIR)/usr/include/
	$(INSTALL_DIR) -p $(1)/etc
	$(INSTALL_DIR) -p $(1)/etc/init.d
	$(CP) $(PKG_BUILD_DIR)/compat/compat.ko $(1)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_BUILD_DIR)/net/mac80211/mac80211.ko $(1)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_BUILD_DIR)/net/wireless/cfg80211.ko $(1)/lib/modules/$(LINUX_VERSION)/
	$(CP) $(PKG_BUILD_DIR)/drivers/net/wireless/intel/iwlwav/mtlk.ko $(1)/opt/intel/lib/modules/$(LINUX_VERSION)/net/
	$(CP) $(PKG_BUILD_DIR)/drivers/net/wireless/intel/iwlwav/tools/mtlkroot/mtlkroot.ko $(1)/opt/intel/lib/modules/$(LINUX_VERSION)/net/
	$(CP) $(PKG_BUILD_DIR)/drivers/net/wireless/intel/iwlwav/wireless/shared/wave_fapi_nl_if.h $(STAGING_DIR)/usr/include/
	$(CP) ./files/wireless_startup $(1)/etc/init.d/
	echo -e "iwlwav_driver_hash=\"$(PKG_REV)\"\niwlwav_driver_tag=\"$(PKG_REV)\"" > $(1)/etc/iwlwav_driver.ver
endef

$(eval $(call KernelPackage,iwlwav-driver-kernel-uci))
$(eval $(call BuildPackage,iwlwav-driver-uci))
