#
# Copyright (C) 2009 OpenWrt.org
# Copyright (C) 2017 Intel Corporation
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id: $

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=iwlwav-base-files
PKG_RELEASE:=1

PKG_BUILD_DEPENDS:=hostapd_wave

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SUBMENU:=Base Files
  SECTION:=base
  CATEGORY:=Intel
  TITLE:=Common files for Intel OWRT CPE Systems
  URL:=http://www.intel.com/
  MAINTAINER:=Intel
  DEPENDS:=+busybox
endef

#define Package/$(PKG_NAME)/conffiles
#endef

define Package/$(PKG_NAME)/description
 This package contains files and system scripts for OpenWrt,
 common for all Intel CPE Targets.
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/mnt
	$(INSTALL_DIR) $(1)/usr/sbin
	$(LN) /tmp/mounts $(1)/mnt/usb
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))

