include $(TOPDIR)/rules.mk

PKG_NAME:=prplmesh
PKG_RELEASE:=1.4.0
PKG_SOURCE_URL:=https://github.com/prplfoundation/prplMesh.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=d78175d4
PKG_VERSION:=$(PKG_RELEASE)-$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/prplmesh/Default
	SECTION:=net
  	CATEGORY:=Network
	TITLE:=prplmesh
	URL:=https://github.com/prplfoundation/prplMesh/README.md
	MAINTAINER:=prplfoundation
	DEPENDS:=+libstdcpp +libpthread +librt +libjson-c +libreadline +libopenssl +libnl +uci +ubus +ubox +bridge +libzmq-nc
endef

define Package/prplmesh-dwpal
$(call Package/prplmesh/Default)
	TITLE+= - DWPAL
	VARIANT:=dwpal
	PROVIDES:=prplmesh
	DEPENDS+= @TARGET_intel_mips +dwpal_6x-uci +iwlwav-hostap-uci +libsafec3
endef

define Package/prplmesh-nl80211
$(call Package/prplmesh/Default)
	TITLE+= - NL80211
	VARIANT:=nl80211
	PROVIDES:=prplmesh
	DEPENDS+= +hostapd-openssl
endef

CMAKE_SOURCE_DIR:=
CMAKE_OPTIONS+= \
	-DTARGET_PLATFORM=openwrt \
	-DCMAKE_INSTALL_PREFIX=/opt/prplmesh \
	-DPLATFORM_BUILD_DIR=$(BUILD_DIR) \
	-DPLATFORM_STAGING_DIR=$(STAGING_DIR) \
	-DPLATFORM_INCLUDE_DIR=$(STAGING_DIR)/usr/include \
	-DBUILD_TESTS=ON \
	-DMSGLIB=zmq \
	-DREVISION=$(PKG_SOURCE_VERSION) \
	-H. -B./build

ifeq ($(BUILD_VARIANT),dwpal)
	CMAKE_OPTIONS+= -DBWL_TYPE=DWPAL\
		-DTARGET_PLATFORM_TYPE=ugw
endif

ifeq ($(BUILD_VARIANT),nl80211)
	CMAKE_OPTIONS+= -DBWL_TYPE=NL80211 \
		-DTARGET_PLATFORM_TYPE=turris-omnia
endif

Build/Compile:=cmake --build $(PKG_BUILD_DIR)/build -- $(MAKE_INSTALL_FLAGS) install -j
Build/Install:=
Build/Clean:=cd $(PKG_BUILD_DIR) && rm -rf .built .configured_* .prepared_* build/ ipkg-* || true

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/lib/libbml* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/include/beerocks/bml $(1)/usr/include/
endef

define Package/prplmesh/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/opt/prplmesh
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(CP) ./files/etc/config/* $(1)/etc/config/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/bin $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/scripts/prplmesh_utils.sh $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/lib/*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/share $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/config $(1)/opt/prplmesh/
endef

define Package/prplmesh-dwpal/install
$(call Package/prplmesh/install,$(1))
endef

define Package/prplmesh-nl80211/install
$(call Package/prplmesh/install,$(1))
endef

$(eval $(call BuildPackage,prplmesh-dwpal))
$(eval $(call BuildPackage,prplmesh-nl80211))
