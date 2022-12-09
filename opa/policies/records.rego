package records

default allow = false

allow { 
  is_issuer
  is_get
  is_records
  is_aud
  match_claims
  is_owner
}

## Allowed issuer(s)
issuers = {"https://opa-kong-tutorial-idsvr:8443/oauth/v2/oauth-anonymous"}

is_issuer {
  input.token.payload.iss == issuers[issuer]
} 

is_get {
	input.method == "GET"
}

is_records {
  startswith(input.path, "/api/records")
}

is_aud {
  input.token.payload.aud = "www"
}

match_claims {
  input.token.payload.scope = "openid records"
}

## Calls record_owner method to verify if the request record is owned by the requesting user (sub)
is_owner{
  record_id := trim_left(input.path, "/api/records/") ##trim the path to get record id
  lower(input.token.payload.sub) == lower(record_owner(record_id).patient)
}

## Method takes a record_id as input to resolve record data
record_owner(record_id) = http.send({
  "url": concat("", ["http://opa-kong-tutorial-api:8080/api/records/", record_id]),
  "method": "GET",
  "force_cache": true,
  "force_cache_duration_seconds": 86400 # Cache response for 24 hours
}).body
