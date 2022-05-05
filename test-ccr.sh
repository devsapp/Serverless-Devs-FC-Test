#!/bin/bash
set -x
set -e
s clean --all

export core_load_serverless_devs_component="devsapp/fc-build@dev;devsapp/fc-core@dev;devsapp/fc-local-invoke@dev"

# Test custom container
cd custom-container
echo "test custom-container runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'