#!/bin/bash
set -x
set -e
s clean --all

export FC_DOCKER_VERSION=1.10.4 
export core_load_serverless_devs_component='devsapp/fc-layer@dev;devsapp/fc-info@dev;devsapp/fc-core@dev;devsapp/fc-plan@dev'

# Test custom runtime
cd custom
cd python


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