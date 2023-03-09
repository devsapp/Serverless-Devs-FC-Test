#!/bin/bash
set -x
set -e
# s clean --component

# export FC_DOCKER_VERSION=1.10.6
export core_load_serverless_devs_component='devsapp/fc@dev;devsapp/domain@dev'

# Test go1.x Runtime
cd go
echo "test go1.x runtime ..."
rm -rf .s
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'


cd ../custom/springboot
echo "test custom runtime springboot ..."
rm -rf .s
s deploy -y --use-local
s invoke -f ./event/http.json

echo "test custom runtime springboot start java -jar ..."
rm -rf .s
s deploy -y --use-local -t s.jar.yaml
s invoke -t s.jar.yaml -f ./event/http.json