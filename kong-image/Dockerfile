FROM kong:latest

WORKDIR /usr/kong/

# Install OPA plugin
RUN git clone https://github.com/open-policy-agent/contrib &&\
  mv contrib/kong_api_authz /usr/kong/opa/ &&\
  rm -rf contrib

WORKDIR /usr/kong/opa

# switch to root to install rocks in /usr/local 
USER root

# build and install the plugin
RUN luarocks make

RUN cd .. &&\
  git clone https://github.com/curityio/kong-phantom-token-plugin &&\
  mv kong-phantom-token-plugin/plugin  /usr/local/share/lua/5.1/kong/plugins/phantom-token

# back to kong user
USER kong