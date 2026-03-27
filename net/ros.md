# Ros

- 都不添加默认路由表


# ips

```bash

/ip firewall address-list remove [/ip firewall address-list find list=VPN]
/ip firewall address-list

sudo pacman -S bind-tools
nslookup -q=TXT _netblocks[1-5].google.com 8.8.8.8

ip firewall address-list
add list=VPN comment=_netblocks5.google.com address=209.85.218.92/30
add list=VPN address=209.85.161.92/30
add list=VPN address=209.85.210.220/30
add list=VPN address=35.190.247.0/24
add list=VPN address=64.233.160.0/19
add list=VPN address=66.102.0.0/20

```

# 安装固件

```bash
# https://wiki.mikrotik.com/wiki/Manual:Netinstall
# https://mikrotik.com/product/rb4011igs_rm#fndtn-downloads
# https://mikrotik.com/download

# 设置ip为 192.168.88.2 gateway 192.168.88.1
# 打开netinstall 设置 net booting server: 192.168.88.3
# 断开路由电源, 有线连接到路由第一个口, 按信复位键插入电源, 直到 netinstall drives 里出现设备松开
# 浏览目录，选择包进行安装

```

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
add action=change-mss chain=forward comment="fix IPv4 mss for WAN" new-mss=1440 passthrough=yes protocol=tcp tcp-flags=syn
add action=accept chain=prerouting comment=" access to ONU" src-address-list=lan_ipv4 dst-address-list=onu_ipv4

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

# IPV6

```bash

# Ipv6 Client

IPv6 -> DHCPv6 Client -> New
Interface: PPPOE
Request: prefix
Pool Name: v6-pool1
Pool Prefix Length: 64
Use Peer DNS: uncheck
Add Default Route: check

# Ipv6 Address 

IPv6 -> Adresses -> new

# Gla 
Address = :1/64
From Pool: v6-pool1
Interface: lan-bridge
Advertise: checked


# Gla 
# https://cd34.com/rfc4193/ 网桥mac地址生成只取前一节
Address = fd46::1/64
From Pool: v6-pool1
Interface: lan-bridge
Advertise: checked

# ND 配置
# 规避windows 临时地址问题
IPv6 -> ND -> Prefixes -> Default

Valid Lifetime: 01:30:00  # 最大有效期
Preferred Lifetime: 01:00:00 #  建议有效期

# 默认是使用 eui64 算法根据mac 生成后64位地址 : https://eui64-calc.princelle.org/  - https://www.calcip.com/eui-64/
# windows 禁用临时地址 策略
netsh interface ipv6 set privacy state=disabled store=active
netsh interface ipv6 set privacy state=disabled store=persistent
netsh interface ipv6 set global randomizeidentifiers=disabled store=active
netsh interface ipv6 set global randomizeidentifiers=disabled store=persistent

# Neighbor Discovery 禁用默认all接口的
IPv6 -> ND Interfaces

Interface：lan-bridge
RA Interval:300-900
RA Lifetime:2700
Hop Limit: 64
# 上面设置的gla地址
DNS Servers = fd46::1
Advertise MAC Address：checked
Advertise DNS：yes

# IP -> DNS
dns = 2400:3200::1


/ipv6 firewall address-list

add address=::1/128 comment="RFC6890 - loopback" list=bad_ipv6
add address=::/128 comment="RFC6890 - unspecified" list=bad_ipv6
add address=100::/64 comment="RFC6890 - discard-only" list=bad_ipv6
add address=0000::/96 comment="RFC4291 - IPv4 compatible" list=bad_ipv6
add address=::ffff:0:0/96 comment="RFC6890 - IPv4 mapped" list=bad_ipv6
add address=2001::/23 comment="RFC6890 - reserved" list=bad_ipv6
add address=2001:db8::/32 comment="RFC6890 - documentation" list=bad_ipv6
add address=2001:10::/28 comment="RFC4843 - ORCHID" list=bad_ipv6
add address=2001:20::/28 comment="RFC7343 - ORCHIDv2" list=bad_ipv6
add address=fec0::/10 comment="RFC3879 - site local" list=bad_ipv6


/ipv6 firewall filter

add action=accept chain=input comment="accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=accept chain=input comment="accept ICMPv6" protocol=icmpv6
add action=accept chain=input comment="accept UDP traceroute" dst-port=33434-33534 protocol=udp
add action=accept chain=input comment="accept DHCPv6-Client prefix delegation" dst-port=546 protocol=udp src-address=fe80::/10 log=yes log-prefix="[ipv6-pd]"
add action=drop chain=input comment="drop all not from LAN" in-interface=!lan-bridge

add action=accept chain=forward comment="accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=forward comment="drop invalid" connection-state=invalid
add action=drop chain=forward comment="drop bogon IPs" src-address-list=bad_ipv6
add action=drop chain=forward comment="drop bogon IPs" dst-address-list=bad_ipv6
add action=drop chain=forward comment="rfc4890 drop hop-limit=1" hop-limit=equal:1 protocol=icmpv6
add action=accept chain=forward comment="accept ICMPv6" protocol=icmpv6
add action=drop chain=forward comment="drop all not from LAN" in-interface=!lan-bridge


/ipv6 firewall nat

add action=masquerade chain=srcnat comment="masquerade" out-interface=PPPOE disabled=yes


/ipv6 firewall mangle

add action=change-mss chain=forward comment="change mss for WAN" new-mss=clamp-to-pmtu passthrough=yes protocol=tcp tcp-flags=syn

# 黑洞
/ipv6 route
add blackhole comment="RFC6890 - unspecified" disabled=no dst-address=::/128
add blackhole comment="RFC4291 - IPv4 compatible" disabled=no dst-address=0000::/96
add blackhole comment="RFC6890 - IPv4 mapped" disabled=no dst-address=::ffff:0:0/96
add blackhole comment="RFC6890 - discard-only" disabled=no dst-address=100::/64
add blackhole comment="RFC6890 - reserved" disabled=no dst-address=2001::/23
add blackhole comment="RFC6890 - TEREDO" disabled=no dst-address=2001::/32
add blackhole comment="RFC6890 - benchmarking" disabled=no dst-address=2001:2::/48
add blackhole comment="RFC6890 - documentation" disabled=no dst-address=2001:db8::/32
add blackhole comment="RFC4843 - ORCHID" disabled=no dst-address=2001:10::/28
add blackhole comment="RFC7343 - ORCHIDv2" disabled=no dst-address=2001:20::/28
add blackhole comment="RFC6890 - 6to4" disabled=no dst-address=2002::/16
add blackhole comment="RFC6890 - unique local" disabled=no dst-address=fc00::/7
add blackhole comment="RFC6890 - link local" disabled=no dst-address=fe80::/10
add blackhole comment="RFC3879 - site local" disabled=no dst-address=fec0::/10


#  ipv6 script

/environment print
:set cidrCacheV6 "clear"

# ***  ipv6Runner script ***

:global cidrCacheV6;
:global nameApiToken $TOKCEN

:local ipv6Prefix [/ipv6 dhcp-client get [find interface="PPPOE" status=bound] prefix]
:local cidrNetwork [:pick $ipv6Prefix 0 ([:find $ipv6Prefix "::" -1] + 1)]
:if ($cidrCacheV6 != $cidrNetwork) do={
    # :log info ("CIDR Changed: ". $cidrCacheV6 . " -> " . $cidrNetwork)
    :set cidrCacheV6 $cidrNetwork
    :global hostFunc [:parse [/system script get ipv6Host source]]
    $hostFunc mark="25-desk" domain=$DOMAIN$ host="s25" id=$ID$ ipv6="56bf:64ff:fe64:29a4"
}


# ***  ipv6Host script ***

:global cidrCacheV6;
:global nameApiToken;

:local newAddress  "$cidrCacheV6$ipv6"

# :log info ("mark: " .$mark . ", cidr: " . $cidrCacheV6 . " IPV6: " . $newAddress)

:local oldAddress [/ipv6 firewall filter get [/ipv6 firewall filter find comment=$mark] dst-address]
:if ($newAddress != $oldAddress) do={ 
    # :log info ("setip : ". $newAddress)
    /ipv6 firewall filter set [/ipv6 firewall filter find comment=$mark] dst-address=$newAddress
}

:if ($newAddress != $oldAddress && $domain != "") do={ 
    /tool fetch http-method=put mode=https url="https://api.name.com/core/v1/domains/$domain/records/$id" http-header-field="Authorization: Basic $nameApiToken,content-type:application/json" as-value output=user http-data="{\"answer\":\"$newAddress\",\"type\":\"AAAA\",\"fqdn\":\"$host.$domain\",\"host\":\"$host\",\"priority\":123,\"ttl\":300}";

}

```

# IPV6 Find By Mac

```bash

# ***  ipv6Host script ***

:global cidrCacheV6;
:global nameApiToken;

:local newAddress ""

# :log info ("Host: ". $mac . ", mark: " .$mark . ", cidr: " . $cidrCacheV6)

:local ipAddressList [/ipv6 neighbor find mac-address=$mac]
:foreach neighborId in=$ipAddressList do={

    :local ipv6Address [/ipv6 neighbor get $neighborId address]
    :local ipv6Status [/ipv6 neighbor get $neighborId status]
    :local foundPosition [:find $ipv6Address $cidrCacheV6]

    :if ($foundPosition >= 0 && $ipv6Status = "reachable") do={
        :set newAddress $ipv6Address;
    }
}

:local oldAddress [/ipv6 firewall filter get [/ipv6 firewall filter find comment=$mark] dst-address]
:if ($newAddress != $oldAddress) do={ 
    # :log info ("setip : ". $newAddress)
    /ipv6 firewall filter set [/ipv6 firewall filter find comment=$mark] dst-address=$newAddress
}

:if ($newAddress != $oldAddress && $domain != "") do={ 
    /tool fetch http-method=put mode=https url="https://api.name.com/core/v1/domains/$domain/records/$id" http-header-field="Authorization: Basic $nameApiToken,content-type:application/json" as-value output=user http-data="{\"answer\":\"$newAddress\",\"type\":\"AAAA\",\"fqdn\":\"$host.$domain\",\"host\":\"$host\",\"priority\":123,\"ttl\":300}";
}

```