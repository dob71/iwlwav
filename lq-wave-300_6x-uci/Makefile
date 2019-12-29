include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ltq-wlan-wave_6x-uci
PKG_VERSION:=06.01.00
WLAN_BUILD_VERSION:=ER4.31
PKG_SOURCE_VERSION:=da87c46c3ae2d0d888ab53d41d0fd5aa04e1832b
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/wave_bin.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

FW_BIN_FOLDER:=$(PKG_BUILD_DIR)/fw/bin
GENRISC_BIN_FOLDER:=$(PKG_BUILD_DIR)/genrisc/bin
PROGMODEL_BIN_FOLDER:=$(PKG_BUILD_DIR)/progmodel/bin
PSD_BIN_FOLDER:=$(PKG_BUILD_DIR)/psd/bin
REGULATORY_BIN_FOLDER:=$(PKG_BUILD_DIR)/regulatory/bin

BIN_FOLDER:=opt/intel/bin
BINS_FOLDER:=opt/intel/wave/images
SBIN_FOLDER:=opt/intel/sbin

include $(INCLUDE_DIR)/package.mk

define Package/ltq-wlan-wave_6x-uci
	SECTION:=utils
	CATEGORY:=Intel
	TITLE:=Wave components
	DEPENDS:= \
		+PACKAGE_kmod-ltq_wave500_dp_drv:kmod-ltq_wave500_dp_drv \
		+PACKAGE_kmod-lantiq_directconnect_support:kmod-lantiq_directconnect_support \
		@+PACKAGE_ltq-devm:FEATURE_DEVM_WIFILAN \
		@+BUSYBOX_CONFIG_WC \
		@+BUSYBOX_CONFIG_WHICH \
		@+BUSYBOX_CONFIG_AWK \
		@+BUSYBOX_CONFIG_FEATURE_AWK_MATH \
		@+BUSYBOX_CONFIG_FIND \
		@+BUSYBOX_CONFIG_FEATURE_FIND_MTIME \
		@+BUSYBOX_CONFIG_FEATURE_FIND_PERM \
		@+BUSYBOX_CONFIG_FEATURE_FIND_TYPE \
		@+BUSYBOX_CONFIG_FEATURE_FIND_XDEV \
		@+BUSYBOX_CONFIG_FEATURE_FIND_NEWER \
		@+BUSYBOX_CONFIG_FEATURE_FIND_INUM \
		@+BUSYBOX_CONFIG_XARGS \
		@+BUSYBOX_CONFIG_LSMOD \
		@+PACKAGE_libnl3 \
		@+PACKAGE_libopenssl \
		@+PACKAGE_libuuid \
		@+PACKAGE_uuidgen \
		@+PACKAGE_udev \
		@+PACKAGE_dwpal_6x-uci \
		@+PACKAGE_libspal \
		@+PACKAGE_iwlwav-hostap-uci \
		@+PACKAGE_iwlwav-iw \
		@+PACKAGE_iwlwav-tools \
		@+PACKAGE_iwlwav-driver-uci \
		+prplmesh
	URL:=http://www.intel.com
	MAINTAINER:=Intel Corporation
	MENU:=1
endef

define Package/ltq-wlan-wave_6x-uci/description
 This package contains wave binaries components
endef

define Package/ltq-wlan-wave_6x-uci/config
	source "$(SOURCE)/config/Config.in"
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Compile
endef

define Download/ltq-wlan-wave_6x-uci
endef

define Package/ltq-wlan-wave_6x-uci/install
	$(INSTALL_DIR) -p $(1)/$(BIN_FOLDER)/
	$(INSTALL_DIR) -p $(1)/$(SBIN_FOLDER)/
	$(INSTALL_DIR) -p $(1)/$(BINS_FOLDER)/
	$(INSTALL_DIR) -p $(1)/etc/hotplug/
	$(INSTALL_DIR) -p $(1)/etc/hotplug.d/
	$(INSTALL_DIR) -p $(1)/etc/udev/rules.d/
	$(INSTALL_DIR) -p $(1)/lib/firmware/
	$(LN) /dev/null $(1)/etc/udev/rules.d/75-persistent-net-generator.rules
	$(CP) $(FW_BIN_FOLDER)/* $(1)/$(BINS_FOLDER)/
	$(CP) $(FW_BIN_FOLDER)/fw_scd_file.scd $(1)/$(BIN_FOLDER)/
	$(CP) $(GENRISC_BIN_FOLDER)/* $(1)/$(BINS_FOLDER)/
	$(CP) $(PROGMODEL_BIN_FOLDER)/* $(1)/$(BINS_FOLDER)/
	$(CP) $(PSD_BIN_FOLDER)/* $(1)/$(BINS_FOLDER)/
	$(CP) $(FW_BIN_FOLDER)/* $(1)/lib/firmware/
	$(CP) $(FW_BIN_FOLDER)/fw_scd_file.scd $(1)/lib/firmware/
	$(CP) $(GENRISC_BIN_FOLDER)/* $(1)/lib/firmware/
	$(CP) $(PROGMODEL_BIN_FOLDER)/* $(1)/lib/firmware/
	$(CP) $(PSD_BIN_FOLDER)/* $(1)/lib/firmware/
	$(CP) $(REGULATORY_BIN_FOLDER)/* $(1)/lib/firmware/
	$(CP) ./files/binaries/sbin/* $(1)/$(SBIN_FOLDER)/
	$(CP) ./files/etc/* $(1)/etc/
	$(CP) $(PKG_BUILD_DIR)/wave_components.ver $(1)/etc/
	echo -e "wave_release_minor=\"$(PKG_VERSION)$(if $(WLAN_BUILD_VERSION),.$(WLAN_BUILD_VERSION))\"" >> $(1)/etc/wave_components.ver
endef

$(eval $(call BuildPackage,ltq-wlan-wave_6x-uci))
