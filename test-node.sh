#!/bin/bash
set -x
set -e
s3 clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test Nodjs3 Runtime
cd nodejs
echo "test nodejs12 runtime ..."
rm -rf .s
s3 build -d
s3 local invoke -e '{"hello":"fc"}'
s3 deploy -y --use-local
s3 invoke -e '{"hello":"fc"}'

echo "test nodejs14 runtime ..."
s3 build -d -t s-node14.yaml
s3 local invoke -e '{"hello":"fc"}' -t s-node14.yaml
s3 deploy -y --use-local -t s-node14.yaml
s3 invoke -e '{"hello":"fc"}' -t s-node14.yaml

echo "test nodejs16 runtime ..."
s3 build -d -t s-node16.yaml
s3 local invoke -e '{"hello":"fc"}' -t s-node16.yaml
s3 deploy -y --use-local -t s-node16.yaml
s3 invoke -e '{"hello":"fc"}' -t s-node16.yaml
