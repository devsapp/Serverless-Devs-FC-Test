#!/bin/bash
set -x
set -e
s clean --all

export core_load_serverless_devs_component="devsapp/fc-build@dev;devsapp/fc-core@dev;devsapp/fc-local-invoke@dev"

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

echo "test nodejs10 runtime ..."
rm -rf .s
s build -d -t s-node10.yaml
s local invoke -e '{"hello":"fc"}' -t s-node10.yaml
s deploy -y --use-local -t s-node10.yaml
s invoke -e '{"hello":"fc"}' -t s-node10.yaml

echo "test nodejs8 runtime ..."
rm -rf .s
s build -d -t s-node8.yaml
s local invoke -e '{"hello":"fc"}' -t s-node8.yaml
s deploy -y --use-local -t s-node8.yaml
s invoke -e '{"hello":"fc"}' -t s-node8.yaml

echo "remove all"
s remove -y