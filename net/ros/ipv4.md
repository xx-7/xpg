# 配置

```bash

# change name to lan wan
# create PPPOE interface wan1
# create bridge lan-bridge
# add lan interface to lan-bridge

# set address lan-bridge 10.8.8.1/24 10.8.8.0
IP -> Addresses

# add address pools 
#   Name: dhcp-pool8
#   Addresses: 10.8.8.50-10.8.8.200
IP -> Pools -> New

# add dhcp server 
#   Interface: lan-bridge
#   Address pool: dhcp-pool8
IP -> DHCP Server -> DHCP -> New

# add dhcp networks
#   Address: 10.8.8.0:24
#   Gateway: 10.8.8.1
IP -> DHCP Server -> Networks -> New

# add wan dhcp client
#   Name: wan1
#   Interface: wan1
IP -> DHCP Client -> New


/ip firewall address-list

add address=192.168.1.1 comment="local ONU address" list=onu_ipv4
add address=10.8.8.0/24 comment="local LAN address" list=lan_ipv4

/ip firewall filter

add action=accept chain=input comment="accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=accept chain=input comment="accept ICMP" protocol=icmp
add action=drop chain=input comment="drop all not from LAN" in-interface=!lan-bridge

add action=fasttrack-connection chain=forward comment="fasttrack" connection-state=established,related disabled=yes
add action=accept chain=forward comment="accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=forward in-interface=!lan-bridge comment="drop invalid" connection-state=invalid
add action=drop chain=forward comment="drop all from WAN not DSTNATed" connection-nat-state=!dstnat connection-state=new in-interface=PPPOE log=yes log-prefix="[wan-not-dnat]"
add action=drop chain=forward comment=" drop all from ONU not DSTNATed" connection-nat-state=!dstnat connection-state=new in-interface=wan1 log=yes log-prefix="[onu-not-dnat]"

/ip firewall nat
add action=masquerade chain=srcnat comment="masquerade IPv4" out-interface=PPPOE
add action=masquerade chain=srcnat comment="access to ONU" out-interface=wan1 src-address-list=lan_ipv4 dst-address-list=onu_ipv4

/ip firewall mangle
add action=change-mss chain=forward comment="fix IPv4 mss for WAN" new-mss=clamp-to-pmtu passthrough=yes protocol=tcp tcp-flags=syn
add action=accept chain=prerouting comment="access to ONU" src-address-list=lan_ipv4 dst-address-list=onu_ipv4

/ip settings
set max-neighbor-entries=8192 rp-filter=loose tcp-syncookies=yes

/ip neighbor discovery-settings
set discover-interface-list=none


/ip proxy
set enabled=no

/ip socks
set enabled=no

/ip upnp
set enabled=no

/ip cloud
set ddns-enabled=auto update-time=no

# 黑洞
/ip route
add blackhole comment="RFC6890 - this network" disabled=no dst-address=0.0.0.0/8
add blackhole comment="RFC6890 - private networks" disabled=no dst-address=10.0.0.0/8
add blackhole comment="RFC6890 - shared address" disabled=no dst-address=100.64.0.0/10
add blackhole comment="RFC6890 - link local" disabled=no dst-address=169.254.0.0/16
add blackhole comment="RFC6890 - private networks" disabled=no dst-address=172.16.0.0/12
add blackhole comment="RFC6890 - reserved" disabled=no dst-address=192.0.0.0/24
add blackhole comment="RFC6890 - DS-Lite" disabled=no dst-address=192.0.0.0/29
add blackhole comment="RFC6890 - TEST-NET-1" disabled=no dst-address=192.0.2.0/24
add blackhole comment="RFC6890 - 6to4 relay" disabled=no dst-address=192.88.99.0/24
add blackhole comment="RFC6890 - private networks" disabled=no dst-address=192.168.0.0/16
add blackhole comment="RFC6890 - benchmarking" disabled=no dst-address=198.18.0.0/15
add blackhole comment="RFC6890 - TEST-NET-2" disabled=no dst-address=198.51.100.0/24
add blackhole comment="RFC6890 - TEST-NET-3" disabled=no dst-address=203.0.113.0/24
add blackhole comment="RFC6890 - reserved" disabled=no dst-address=240.0.0.0/4


```