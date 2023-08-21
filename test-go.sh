#!/bin/bash
set -x
set -e
s3 clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test go1.x Runtime
cd go
echo "test go1.x runtime ..."
rm -rf .s
s3 deploy -y --use-local
s3 invoke -e '{"hello":"fc"}'

s3 local invoke -e '{"hello":"fc local invoke"}'