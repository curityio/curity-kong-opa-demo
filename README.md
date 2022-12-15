# The Curity Identity Server, OPA and Kong demo

[![Quality](https://img.shields.io/badge/quality-experiment-red)](https://curity.io/resources/code-examples/status/)
[![Availability](https://img.shields.io/badge/availability-source-blue)](https://curity.io/resources/code-examples/status/)

A dockerized demo environment with an API that is proxied by Kong Gateway. Kong acts as an enforcement point and will enforce coarse-grained authorization through the [Kong Phantom Token Plugin](https://github.com/curityio/kong-phantom-token-plugin) and fine-grained authorization using the [Kong OPA Plugin](https://github.com/open-policy-agent/contrib/tree/main/kong_api_authz).

## Documentation
The environment is documented and described in the [API Authorization using Open Policy Agent](https://curity.io/resources/learn/curity-opa-kong-api/) article on the Curity website.

## Quickstart

1. Pull down the git repo `git clone https://github.com/curityio/curity-kong-opa-demo`
2. Build the environment `docker compose build`
3. Start the environment `docker compose up`
4. Add the following entry to your `/etc/hosts` file, so that you're able to correctly call the containers from your local machine:

```
127.0.0.1 opa-kong-tutorial-idsvr opa-kong-tutorial-kong
```

5. When the environment has started, go to `https://localhost:6749/admin` and log in with the user admin and password defined in `docker-compose.yml`. Go through the basic wizard and make sure to enable SSL (`Use Existing SSL Key` and selecting `default-admin-ssl-key` works, or choose your own). Upload a valid license and upload the example policy, `curity/curity-opa-kong-config.xml`. This policy can be merged but requires the wizard to be completed and committed first.
6. With the system configured, a client can obtain a token using the `www` client. Make sure to request the `openid` and `records` scope. E.g., you can call the authorization endpoint with this request sent from a browser:

```
https://opa-kong-tutorial-idsvr:8443/oauth/v2/oauth-authorize?client_id=www&scope=openid%20records&response_type=code&redirect_uri=https://localhost:8080/cb
```

There are no users pre-populated in the environment. As part of the authentication process, create a user. The default OPA policy checks that `user==owner` so authorization will fail if there is a mismatch. The owners (patient) of the records are detailed in `api/server/data/records.json`. Either create a user that matches or make changes to `records.json`.

Once you receive the authorization code, you can redeem it with a curl command:

```
curl -k --basic -u www:Password1 -d grant_type=authorization_code&redirect_uri=https://localhost:8080/cb&code=... https://opa-kong-tutorial-idsvr:8443/oauth/v2/oauth-token
```

7. Use the Access Token and perform a GET request to the API exposed by Kong.

```bash
curl -Ss -X GET \
http://opa-kong-tutorial-kong:8000/records/0 \
-H 'Authorization: Bearer b37b14c7-a23b-4c4b-b59a-4f4bac9ba9af'
```

## More Information

Please visit [curity.io](https://curity.io/) for more information about the Curity Identity Server.
