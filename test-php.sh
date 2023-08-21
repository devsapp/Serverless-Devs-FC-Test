#!/bin/bash
set -x
set -e
s3 clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test Php7.2 Runtime
cd php
echo "test php7.2 runtime ..."
rm -rf .s
s3 build -d
s3 local invoke -e '{"hello":"fc"}'
s3 deploy -y --use-local
s3 invoke -e '{"hello":"fc"}'


# test acr image
# export TZ='Asia/Shanghai'

# echo "test php7.2 runtime build/local-invoke use acr image ..."
# rm -rf .s
# s3 build -d
# s3 local invoke -e '{"hello":"fc"}'
# s3 deploy -y --use-local
# s3 invoke -e '{"hello":"fc"}'