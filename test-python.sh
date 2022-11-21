#!/bin/bash
set -x
set -e

# export FC_DOCKER_VERSION=1.10.4 
export core_load_serverless_devs_component='devsapp/fc@dev'

# Test Python Runtime
cd python
echo "test python3.6 runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test python2.7 runtime ..."
rm -rf .s
s build -d -t s-python2.yaml
s local invoke -e '{"hello":"fc"}' -t s-python2.yaml
s deploy -y --use-local -t s-python2.yaml
s invoke -e '{"hello":"fc"}' -t s-python2.yaml

echo "test python3.9 runtime ..."
rm -rf .s
s build -d -t s-python39.yaml
s local invoke -e '{"hello":"fc"}' -t s-python39.yaml
s deploy -y --use-local -t s-python39.yaml
s invoke -e '{"hello":"fc"}' -t s-python39.yaml