gluon-mesh-wireguard
============

script to install all neccesary components to use encrypted wireguard Tunnel in combination with gretap and batman-adv to use as an alternative to fastd or l2tp

## some things work slightly different:
the main difference will be that you have an extra wireguard interface in which a gretap tunnel is established.
The Kernel Module Wireguard make encrypted Layer 3 Routing, gretap brings the needed features for layer 2 Batman-adv meshing.
This results in a Extra Ip inside the wireguard Tunnel, so beside a public key you will have a wireguard internal ip.
This has to be generated and shared. 
Other than that its quiet similar to fastd.

## include to modules
you can include this package to your modules.
```
GLUON_SITE_FEEDS='... airtime meshwireguard ...'
PACKAGES_MESHWIREGUARD_REPO=https://github.com/viisauksena/gluon-mesh-wireguard.git
PACKAGES_MESHWIREGUARD_COMMIT=6926422044dbd05810802da6abe2e501e6debd86
PACKAGES_MESHWIREGUARD_BRANCH=master
```

## Things to do:

* load on boot - actual micron.d regular check (for br-wan also) with load feature
* on 841v10 with factory : reboot after 1 minute,maybe because of script
  dir505 with sysupgrade only is running fine (with and without uplink)
* make use of uci saved values whenever possible in wg0 up script
* change naming and location of scripts , to make it more sane
* config-mode advance : make server/peer configurable
* config-mode : check if option for on/off is working
* config-mode : read data from site.conf (actually all Data is fixed)
* config-mode : rethink the whole thing
* forbid freifunk tunnel inside freifunk (hopefully done)
* automatism for deactivating / activating if br-wan is active (hopefully done)
* choose between v4 and v6 gretap (maybe v6 has drawbacks - but than we need clever 
  automatic decision which ipv4 a router should choose for wg0 internal adress.
  There shouldnt be the same adress twice)
* check the whole mtu firewall stuff
* internal freifunk routing / bridges / dns

## Things that actually work:
* autogenerating key and a fixed ipv6 for internal wg0 tunnel
  (but this is based on mac, which has drawbacks if the list of peers is public, since the mac of "one" router is exposed,
   which is actually also true for evere Freifunk Community using Meshviewer or something similar)
* showing key and ip on config-mode reboot screen
* autoload on boot (see problems)
* wg0 up - ip6gretap up - batctl if add
* many entries in : uci show wireguard
in general, if you have a wireguard endpoint running you can connect and run batman through this tunnel.

we expect wireguard with gretap and batman-adv to be 3 Times Faster than regular fastd connections, which are commonly used in Freifunk Communities. Some Tests can be found on https://forum.freifunk.net/search?q=wireguard

for more Information on WireGuard see 
https://wireguard.io
