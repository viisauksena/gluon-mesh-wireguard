include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-mesh-wireguard
PKG_VERSION:=2

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(TOPDIR)/../package/gluon.mk

PKG_CONFIG_DEPENDS += $(GLUON_I18N_CONFIG)


define Package/gluon-mesh-wireguard
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=gluon-mesh-wireguard
  DEPENDS:=+gluon-core +micrond +kmod-gre +kmod-gre6 +ip-full +kmod-wireguard +wireguard-tools +kmod-udptunnel6 +kmod-udptunnel4 +kmod-ipt-hashlimit
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-mesh-wireguard/install
        $(CP) ./files/* $(1)/
        $(call GluonInstallI18N,gluon-mesh-wireguard,$(1))
endef

$(eval $(call BuildPackage,gluon-mesh-wireguard))

