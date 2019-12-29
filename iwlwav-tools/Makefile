include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=iwlwav-tools
PKG_VERSION:=6.1.0
PKG_RELEASE:=1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ssh://git@gts-chd.intel.com:29418/sw_wave/iwlwav-tools.git
PKG_SOURCE_VERSION:=4aa0ff119c4e8523ee18affaa8c171e952c00e22
PKG_SOURCE_PROTO:=git

include $(INCLUDE_DIR)/package.mk

define Package/iwlwav-tools
  SECTION:=net
  CATEGORY:=Network
  TITLE:=wave SW toolset
  URL:=http://www.intel.com/
  DEPENDS:=+libnl
  MENU:=1
endef

define Package/iwlwav-tools/description
  Intel toolset for wave HW
endef

OUTPUT_DEST=opt/intel/bin/
UBIN_FOLDER=opt/intel/usr/bin/

CROSS_COMPILE=$(if $(CONFIG_EXTERNAL_TOOLCHAIN),$(CONFIG_TOOLCHAIN_ROOT)/bin/$(CONFIG_TOOLCHAIN_PREFIX)gcc,$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)gcc) # fix for non external toolchain!
CROSS_AR=$(if $(CONFIG_EXTERNAL_TOOLCHAIN),$(CONFIG_TOOLCHAIN_ROOT)/bin/$(CONFIG_TOOLCHAIN_PREFIX)ar,$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)ar) # fix for non external toolchain!
CROSS_RANLIB=$(if $(CONFIG_EXTERNAL_TOOLCHAIN),$(CONFIG_TOOLCHAIN_ROOT)/bin/$(CONFIG_TOOLCHAIN_PREFIX)ranlib,$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)ranlib) # fix for non external toolchain!
CROSS_LD=$(if $(CONFIG_EXTERNAL_TOOLCHAIN),$(CONFIG_TOOLCHAIN_ROOT)/bin/$(CONFIG_TOOLCHAIN_PREFIX)ld,$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)ld) # fix for non external toolchain!

LIBNL_DIR:=$(wildcard $(STAGING_DIR)/usr/include/libnl3)

CFLAGS += -I$(LIBNL_DIR)
LDFLAGS += -L$(TOOLCHAIN_DIR)/lib -L$(STAGING_DIR)/usr/lib -lnl-genl-3 -lnl-3 -pthread -lpthread

define Build/Compile
	@echo LDFLAGS: "$(LDFLAGS)"
	$(MAKE) -C $(PKG_BUILD_DIR) clean
	$(MAKE) CC=$(CROSS_COMPILE) AR=$(CROSS_AR) RANLIB=$(CROSS_RANLIB) LD=$(CROSS_LD) -C $(PKG_BUILD_DIR) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"
endef

define Package/iwlwav-tools/install
	$(INSTALL_DIR) -p $(1)/$(OUTPUT_DEST)
	$(INSTALL_DIR) -p $(1)/$(UBIN_FOLDER)/
	$(INSTALL_DIR) -p $(1)/etc
	$(CP) $(PKG_BUILD_DIR)/tools/dutserver/linux/dutserver $(1)/$(OUTPUT_DEST)
	$(CP) $(PKG_BUILD_DIR)/tools/rtlogger/logserver/linux/logserver $(1)/$(OUTPUT_DEST)
	$(CP) $(PKG_BUILD_DIR)/tools/mttools/drvhlpr/drvhlpr $(1)/$(OUTPUT_DEST)
	$(CP) $(PKG_BUILD_DIR)/tools/mttools/mtdump/mtdump $(1)/$(UBIN_FOLDER)
	$(CP) $(PKG_BUILD_DIR)/tools/mttools/mtdump/mtdump.mtidlc $(1)/$(OUTPUT_DEST)
	$(CP) $(PKG_BUILD_DIR)/tools/mttools/mtlk_cli/mtlk_cli $(1)/$(OUTPUT_DEST)
	$(CP) $(PKG_BUILD_DIR)/tools/mttools/mtlk_cli_dbg_srv/mtlk_cli_dbg_server $(1)/$(OUTPUT_DEST)
	$(CP) $(PKG_BUILD_DIR)/tools/BCLSockServer/BCLSockServer $(1)/$(OUTPUT_DEST)/BclSockServer
	$(CP) $(PKG_BUILD_DIR)/tools/dump_handler/dump_handler $(1)/$(OUTPUT_DEST)
	echo -e "iwlwav_tools_hash=\"$(PKG_REV)\"\niwlwav_tools_tag=\"$(PKG_REV)\"" > $(1)/etc/iwlwav_tools.ver
endef

$(eval $(call BuildPackage,iwlwav-tools))
