#!/bin/bash
set -x
set -e
s clean --all

# export FC_DOCKER_VERSION=1.10.6
export core_load_serverless_devs_component='devsapp/fc-deploy@dev;devsapp/fc@dev;devsapp/fc-build@dev'

# Test Java Runtime
echo "test java8 runtime ..."
cd java
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test java11 runtime ..."
rm -rf .s
s build -d -t s-java11.yaml
s local invoke -e '{"hello":"fc"}' -t s-java11.yaml
s deploy -y --use-local -t s-java11.yaml
s invoke -e '{"hello":"fc"}' -t s-java11.yaml

# Test java8 runtime,  jar no need zip
s init start-fc-event-java8 -d /tmp/start-fc-event-java8 --parameters '{"region":"cn-shenzhen", "serviceName":"fc-build-demo"}'
cd /tmp/start-fc-event-java8 && s deploy  -a quanxi -y --use-local && cd -
s invoke -e "hello" -a quanxi
rm -rf /tmp/start-fc-event-java8 
cd ..