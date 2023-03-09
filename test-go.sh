#!/bin/bash
set -x
set -e
s clean --all

# export FC_DOCKER_VERSION=1.10.6
export core_load_serverless_devs_component='devsapp/fc@dev;devsapp/domain@dev'

# Test go1.x Runtime
cd go
echo "test go1.x runtime ..."
rm -rf .s
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

s local invoke -e '{"hello":"fc local invoke"}'