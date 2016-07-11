# cached-pip
export PIP_TRUSTED_HOST=devpi.axado.com.br
export PIP_INDEX_URL=http://${PIP_TRUSTED_HOST}:3141/root/pypi/+simple/

# cached-npm
export NPM_CONFIG_PROXY=http://hack-01:8080/
export NPM_CONFIG_HTTPS_PROXY=http://hack-01:8080/
export NPM_CONFIG_STRICT_SSL=false

# cached-bower
export BOWER_REGISTRY=http://hack-01:6010