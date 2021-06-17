# Curity, OPA and Kong demo

[![Quality](https://img.shields.io/badge/quality-experiment-red)](https://curity.io/resources/code-examples/status/)
[![Availability](https://img.shields.io/badge/availability-source-blue)](https://curity.io/resources/code-examples/status/)

A dockerized demo environment with an API that is proxied by Kong Gateway. Kong acts as an enforcement point and will enforce coarse-grained authorization through the [Kong Phantom Token Plugin](https://github.com/curityio/kong-phantom-token-plugin) and fine grained authorization using the [Kong OPA Plugin](https://github.com/open-policy-agent/contrib/tree/main/kong_api_authz).

## Documentation
The environment is documented and described in the [Integrating with Open Policy Agent](https://curity.io/placeholder) article on the Curity website.

## Quickstart

1. Pull down the git repo `git clone https://github.com/curityio/curity-kong-opa-demo`
2. Build the environment `docker compose build`
3. Start the environment `docker compose up`
4. When the environment has started, go to https://localhost:6749/admin and log in with user admin and password that's defined in `docker-compose.yml`. Go through basic wizard and make sure to enable SSL (`Use Existing SSL Key` and select `default-admin-ssl-key` works or choose your own). Upload a valid license and the upload the example policy, `curity/curity-opa-kong-config.xml`. This policy can be merged but requires the wizard to be completed and committed first. 
5. With the system configured a client can be used to obtain a token using the `www` client. Make sure to request the `openid` and `records` scope. There are no users pre-populated in the environment. As part of the authentication process, create a user. The default OPA policy checks that `user==owner` so authorization will fail if there is a mismatch. The owners (patient) of the records are detailed in `api/server/records.json`. Either create a user that matches or make changes to `records.json`.
6. Use the Access Token and perform a GET request to the API exposed by Kong. 

## More Information

Please visit [curity.io](https://curity.io/) for more information about the Curity Identity Server.