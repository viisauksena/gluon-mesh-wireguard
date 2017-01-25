include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-mesh-wireguard
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/gluon-mesh-wireguard
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=gluon-mesh-wireguard
  DEPENDS:=+gluon-core +micrond +kmod-gre +kmod-gre6 +ip-full +kmod-wireguard +wireguard-tools +gluon-config-mode-core-virtual
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(call GluonBuildI18N,gluon-mesh-wireguard,i18n)
	$(call GluonSrcDiet,./luasrc,$(PKG_BUILD_DIR)/luadest/)
endef

define Package/gluon-mesh-wireguard/install
        $(CP) ./files/* $(1)/
	$(CP) $(PKG_BUILD_DIR)/luadest/* $(1)/
	$(call GluonInstallI18N,gluon-mesh-wireguard,$(1))
endef

$(eval $(call BuildPackage,gluon-mesh-wireguard))

