FROM kong:3.0.0-alpine

WORKDIR /usr/kong/

# switch to root to install opa plugin and rocks in /usr/local
USER root

# Install OPA plugin
RUN git clone https://github.com/open-policy-agent/contrib &&\
  mv contrib/kong_api_authz /usr/kong/opa/ &&\
  rm -rf contrib

WORKDIR /usr/kong/opa

#install dependencies
RUN apk update && \
  apk add gcc libc-dev && \
  luarocks install lua-cjson && \
  luarocks install lua-resty-jwt

# build and install the opa plugin
RUN luarocks make

WORKDIR /usr/kong/

#install phantom-token plugin
RUN git config --global url."https://".insteadOf git:// && \
    git config --global advice.detachedHead false && \
    luarocks install kong-phantom-token 2.0.0

# Prepare directory for the volume, so that proper permissions are applied
RUN mkdir /usr/local/kong/declarative && chown kong:kong /usr/local/kong/declarative

# back to kong user
USER kong
