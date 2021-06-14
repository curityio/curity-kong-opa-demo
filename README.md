# curity-kong-opa-demo

WIP

Run `docker compose build --no-cache` to build
Then run `docker compose up` to start

Go to https://localhost:6749/admin and log in with user admin and password thats defined in `docker-compose.yml`
Go through wizard. 
Upload example policy from developer.curity.io
Obtain a token using the `www` client. Create a user (alice or bob) during the authentication process. The OPA policy checks that the user==owner so authorization will fail if user is a missmatch.
Get a record from the api using the obtained access token
```
curl -Ss -X GET \
http://localhost:8000/records/0 \
-H 'Authorization: Bearer b37b14c7-a23b-4c4b-b59a-4f4bac9ba9af'
```

Alice owns record 0 and acess should be granted. She does not own record 1 and access should be denied.

Policy is is `opa/policies/records.rego`

The records data exposed by the api is in `api/server/records.json`

Kong configuration is in `kong-image/kong.yml`