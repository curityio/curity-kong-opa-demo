package records

default allow = false

allow { 
    is_get
	is_records
    is_issuer
    is_aud
    is_owner
	match_claims
}

is_owner{
    record_id := trim_left(input.path, "/api/records/") ##trim the path to get record id
    lower(input.token.payload.sub) == lower(record_owner(record_id).patient)
}

is_get {
	input.method == "GET"
}

is_records {
    startswith(input.path, "/api/records")
}

match_claims {
    input.token.payload.scope = "openid records"
}

is_issuer {
    input.token.payload.iss == issuers[issuer]
}   

is_aud {
    input.token.payload.aud = "www"
}

##Method takes a record id as input to resolve record data
record_owner(record_id) = http.send({
    "url": concat("", ["http://api:8080/api/records/", record_id]),
    "method": "GET",
    "force_cache": true,
    "force_cache_duration_seconds": 86400 # Cache response for 24 hours
}).body

## Allowed issuer(s)
issuers = {"https://idsvr:8443/oauth/v2/oauth-anonymous"}