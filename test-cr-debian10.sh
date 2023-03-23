#!/bin/bash
set -x
set -e
s clean --all

# export FC_DOCKER_VERSION=1.10.7
export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test custom runtime
cd custom.debian10/python

echo "test custom python runtime event function ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test custom python runtime http function ..."
rm -rf .s
s build -d -t s-http.yaml
s deploy -y --use-local -t s-http.yaml
s invoke -f ./event/http.json


cd ../go
echo "test custom runtime go ..."
rm -rf .s
s deploy -y --use-local
s invoke -e "hello world from github action"
s local invoke -e "hello world from github action local invoke"