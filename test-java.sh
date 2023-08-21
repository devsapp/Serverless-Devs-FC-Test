#!/bin/bash
set -x
set -e
s3 clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test Java Runtime
echo "test java8 runtime ..."
cd java
rm -rf .s
s3 build -d
s3 local invoke -e '{"hello":"fc"}'
s3 deploy -y --use-local
s3 invoke -e '{"hello":"fc"}'

echo "test java11 runtime ..."
rm -rf .s
s3 build -d -t s-java11.yaml
s3 local invoke -e '{"hello":"fc"}' -t s-java11.yaml
s3 deploy -y --use-local -t s-java11.yaml
s3 invoke -e '{"hello":"fc"}' -t s-java11.yaml