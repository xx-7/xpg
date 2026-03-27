

```

# https://docs.name.com/api/v1/reference/dns/update-record


# API-TOKEN   base64(username:token)

# records
curl --request GET \
  --url https://api.name.com/core/v1/domains/DOMAIN/records \
  --header 'Authorization: Basic API-TOKEN


# update
curl --request PUT \
  --url https://api.name.com/core/v1/domains/{domainName}/records/{id} \
  --header 'Authorization: Basic <encoded-value>' \
  --header 'Content-Type: application/json' \
  --data '
{
  "answer": "<string>",
  "type": "A",
  "fqdn": "<string>",
  "host": "<string>",
  "priority": 123,
  "ttl": 123
}
'

```