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
PACKAGES_MESHWIREGUARD_COMMIT=9ddbbcea0f5d376bd7a7ee55b0c71ead05dd0e85
PACKAGES_MESHWIREGUARD_BRANCH=master
```

## including server via site.conf
is actually work in progress, but something like this should work
```
        wireguard = {
                enabled = '1',
                iface = 'wg0',
                v6 = '1',
                v4 = '0', -- not implemented, and maybe never because of gretap complexity
                batman = '1', --  this may include all the gretap magic
                secret = '', -- set on demand on client
                port = '50099', -- not used for s2c because of often used nat
                limit = '1', -- actually unused
                peer = {
                        mesh1 = {
                                enabled = '1',
                                PublicKey ='Gqntn/96zfRrz6SedcNXzw7b+vyjn6IfZlFM8+6U63E=',
                                Endpoints ='136.243.153.228:10099',
                                gretapIP = 'fdf1::16:3e75:72af',
                                AllowedIps ='0.0.0.0/0,::/0',    -- this has to be more narrowed with more mesh-xy
                        },
                },
        },

```

## serverside actions
* you need a wireguard privatekey, and the derived Public Key has to be in site.conf / or uci wireguard.blabla
* you need to know public IP,PORT and internal IP and make it also available to the router
* you have to make sure the publicKey and internal wg0 IP of any router is known to you.
* you have to add the gretap interfaces into you batman network - you dont need to have a fully qualified server (with dns, radvd, dhcp, exit, iprules whatever) - as long as any server is reachable by this wireguard server 
(and you dont have some very special custom rules that forbid connecting server indirectly)

## Things to do:

* load on boot - actual micron.d regular check (for br-wan also) with load feature
* on 841v10 with factory : reboot after 1 minute,maybe because of script
  dir505 with sysupgrade only is running fine (with and without uplink)
* make use of uci saved values whenever possible in wg0 up script (almost done)
* change naming and location of scripts , to make it more sane
* config-mode advance : make server/peer configurable
* config-mode : check if option for on/off is working
* config-mode : read data from site.conf (actually all Data is fixed)
* config-mode : rethink the whole thing
* forbid freifunk tunnel inside freifunk (hopefully done in general, also need to forbid it if router has uplink on yellow which is accidental by itself)
* automatism for deactivating / activating if br-wan is active (hopefully done)
* choose between v4 and v6 gretap (maybe v6 has drawbacks - but actually it seem v4 wg0 internal will be dropped by me)
* check the whole mtu firewall stuff
* internal freifunk routing / bridges / dns

## Things that actually work:
* autogenerating key and a fixed ipv6 for internal wg0 tunnel
  (but this is based on mac, which has drawbacks if the list of peers is public, since the mac of "one" router is exposed,
   which is actually also true for evere Freifunk Community using Meshviewer or something similar)
* showing key and ip on config-mode reboot screen
* autoload on boot (see problems)
* wg0 up - ip6gretap up - batctl if add
* configuration via uci
* using site.conf values - so packet become community indipendent (automation still needed)
* many entries in : uci show wireguard
in general, if you have a wireguard endpoint running you can connect and run batman through this tunnel.

we expect wireguard with gretap and batman-adv to be 3 Times Faster than regular fastd connections, which are commonly used in Freifunk Communities. Some Tests can be found on https://forum.freifunk.net/search?q=wireguard
The gretap variant is also 10-20% faster than the same test with l2tp-ethernet.

for more Information on WireGuard see 
https://wireguard.io
