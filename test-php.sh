#!/bin/bash
set -x
set -e
s clean --all

export FC_DOCKER_REGISTRY=registry.cn-beijing.aliyuncs.com 
export core_load_serverless_devs_component='devsapp/fc-core@dev'

# Test Php7.2 Runtime
cd php
echo "test php7.2 runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'