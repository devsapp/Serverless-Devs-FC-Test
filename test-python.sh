#!/bin/bash
set -x
set -e
s3 clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

# Test Python Runtime
cd python

echo "test python3.10 runtime ..."
rm -rf .s
s3 build -d -t s-python310.yaml
s3 local invoke -e '{"hello":"fc"}' -t s-python310.yaml
s3 deploy -y --use-local -t s-python310.yaml
s3 invoke -e '{"hello":"fc"}' -t s-python310.yaml

echo "test python3.9 runtime ..."
rm -rf .s
s3 build -d -t s-python39.yaml
s3 local invoke -e '{"hello":"fc"}' -t s-python39.yaml
s3 deploy -y --use-local -t s-python39.yaml
s3 invoke -e '{"hello":"fc"}' -t s-python39.yaml

echo "test python3.6 runtime ..."
rm -rf .s
s3 build -d
s3 local invoke -e '{"hello":"fc"}'
s3 deploy -y --use-local
s3 invoke -e '{"hello":"fc"}'

echo "test python2.7 runtime ..."
rm -rf .s
s3 build -d -t s-python2.yaml
s3 local invoke -e '{"hello":"fc"}' -t s-python2.yaml
s3 deploy -y --use-local -t s-python2.yaml
s3 invoke -e '{"hello":"fc"}' -t s-python2.yaml