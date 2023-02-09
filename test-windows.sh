#!/bin/bash
set -x
set -e
# s clean --component

export FC_DOCKER_VERSION=1.10.6
# export core_load_serverless_devs_component='devsapp/fc@dev;devsapp/fc-deploy@dev'

# Test custom java,  jar auto zip or no need zip
cd custom/springboot
echo "test custom runtime springboot ..."
rm -rf .s
s deploy -y --use-local
s invoke -f ./event/http.json

echo "test custom runtime springboot start java -jar ..."
rm -rf .s
s deploy -y --use-local -t s.jar.yaml
s invoke -t s.jar.yaml -f ./event/http.json
cd ..