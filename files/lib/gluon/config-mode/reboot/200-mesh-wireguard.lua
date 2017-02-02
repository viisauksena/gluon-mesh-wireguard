#!/bin/sh
/lib/gluon/upgrade/400-wireguard 
local uci = luci.model.uci.cursor()
local meshvpn_enabled = uci:get("wireguard", "wireguard", "enabled", "0")

if meshvpn_enabled ~= "1" then
	  return nil
  else
    local i18n = require "luci.i18n"
    local util = require "luci.util"
    local gluon_luci = require 'gluon.luci'
    local site = require 'gluon.site_config'
    local sysconfig = require 'gluon.sysconfig'
    local pretty_hostname = require 'pretty_hostname'
    local pubkey = util.trim(util.exec("uci get" .. "wireguard.wireguard.secret"))
    local hostname = pretty_hostname.get(uci)
    local contact = uci:get_first("gluon-node-info", "owner", "contact")

    local msg = i18n.translate('gluon-config-mode:pubkey')
    return function ()
	luci.template.render_string(msg, {
		pubkey = pubkey,
		hostname = hostname,
		site = site,
		sysconfig = sysconfig,
		contact = contact,
		escape = gluon_luci.escape,
		urlescape = gluon_luci.urlescape,
	})
   end
end
