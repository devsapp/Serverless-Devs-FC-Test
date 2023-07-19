#!/bin/bash
set -x
set -e
s clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test Nodjs Runtime
cd nodejs
echo "test nodejs12 runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test nodejs14 runtime ..."
s build -d -t s-node14.yaml
s local invoke -e '{"hello":"fc"}' -t s-node14.yaml
s deploy -y --use-local -t s-node14.yaml
s invoke -e '{"hello":"fc"}' -t s-node14.yaml

echo "test nodejs16 runtime ..."
s build -d -t s-node16.yaml
s local invoke -e '{"hello":"fc"}' -t s-node16.yaml
s deploy -y --use-local -t s-node16.yaml
s invoke -e '{"hello":"fc"}' -t s-node16.yaml
