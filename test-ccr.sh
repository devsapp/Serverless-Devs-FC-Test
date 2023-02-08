#!/bin/bash
set -x
set -e
s clean --all

export FC_DOCKER_VERSION=1.10.6
# export core_load_serverless_devs_component='devsapp/fc@dev;devsapp/fc-deploy@dev'

# Test custom container
cd custom-container
echo "test custom-container runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'