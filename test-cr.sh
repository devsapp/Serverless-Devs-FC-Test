#!/bin/bash
set -x
set -e
s3 clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test custom runtime
cd custom
cd python


echo "test custom python runtime event function ..."
rm -rf .s
s3 build -d
s3 local invoke -e '{"hello":"fc"}'
s3 deploy -y --use-local
s3 invoke -e '{"hello":"fc"}'

echo "test custom python runtime http function ..."
rm -rf .s
s3 build -d -t s-http.yaml
s3 deploy -y --use-local -t s-http.yaml
s3 invoke -f ./event/http.json

cd ../springboot
echo "test custom runtime springboot ..."
rm -rf .s
s3 deploy -y --use-local
s3 invoke -f ./event/http.json

echo "test custom runtime springboot start java -jar ..."
rm -rf .s
s3 deploy -y --use-local -t s.jar.yaml
s3 invoke -t s.jar.yaml -f ./event/http.json



cd ../go
echo "test custom runtime go ..."
rm -rf .s
s3 deploy -y --use-local
s3 invoke -e "hello world from github action"
s3 local invoke -e "hello world from github action local invoke"