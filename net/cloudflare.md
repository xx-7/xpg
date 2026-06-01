

```bash


# 验证AuthToken
curl "https://api.cloudflare.com/client/v4/user/tokens/verify" \
	-H "Authorization: Bearer $AuthToken" \
	-H "Content-Type: application/json"


# Creating a Cloudflare API Auth/Key Token (AuthToken)
# My Profile -> API Tokens -> Create Token

# Getting the Cloudflare DNS domain Zone ID (DnsZoneID)
# dashboard -> domain "Overview" -> right buttom "API Zone ID"

# DnsRcName: xx.main.com

# 查ID DnsRcrdID
curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$DnsZoneID/dns_records?type=AAAA&name=$DnsRcName" \
	-H "Authorization: Bearer $AuthToken" \
	-H "Content-Type: application/json"

# 设置dns
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$DnsZoneID/dns_records/$DnsRcrdID" \
	-H "Authorization: Bearer $AuthToken" \
	-H "Content-Type: application/json" \
    -d '{
  "type": "AAAA",
  "name": $DnsRcName,
  "content": $Ip,
  "ttl": 60,
  "proxied": false,
  "comment": "ros"
}'

```