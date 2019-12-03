include $(TOPDIR)/rules.mk

PKG_NAME:=prplmesh
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_REV:=c40e66e

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REV).tar.gz
PKG_SOURCE_URL:=https://github.com/prplfoundation/prplMesh.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_CONFIG_DEPENDS := CONFIG_PRPLMESH_USE_DWPAL

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/prplmesh
	SECTION:=net
	CATEGORY:=Network
	TITLE:=prplmesh
	URL:=https://github.com/prplfoundation/prplMesh/README.md
	MENU:=1
	MAINTAINER:=prplfoundation
	DEPENDS:=+bridge +dwpal_6x-uci +@PACKAGE_hostapd-openssl +hostapd +libjson-c +libnl +libopenssl +libpthread +libreadline +librt +libsafec3 +libstdcpp +libzmq-nc +ubox +ubus +uci
endef

define Package/prplmesh/description
prplMesh is an open-source, carrier-grade and certifiable
implementation of the WiFi Alliance’s Multi-AP specification.
endef

define Package/prplmesh/config
	source "$(SOURCE)/Config.in"
endef

CMAKE_SOURCE_DIR:=
CMAKE_OPTIONS+= \
	-DTARGET_PLATFORM=openwrt \
	-DTARGET_PLATFORM_TYPE=ugw \
	-DCMAKE_INSTALL_PREFIX=/opt/prplmesh \
	-DPLATFORM_BUILD_DIR=$(BUILD_DIR) \
	-DPLATFORM_STAGING_DIR=$(STAGING_DIR) \
	-DPLATFORM_INCLUDE_DIR=$(STAGING_DIR)/usr/include \
	-DBUILD_TESTS=ON \
	-DMSGLIB=zmq \
	-DBWL_TYPE=DWPAL \
	-H. -B./build

ifeq ($(CONFIG_PRPLMESH_USE_DWPAL),y)
	CMAKE_OPTIONS+= -DBWL_TYPE=DWPAL
else
	CMAKE_OPTIONS+= -DBWL_TYPE=nl80211
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

$(eval $(call BuildPackage,prplmesh))
