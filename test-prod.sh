#!/bin/bash
set -x
set -e
s clean --all

# export FC_DOCKER_VERSION=1.10.8
# export core_load_serverless_devs_component='devsapp/fc-core@dev;devsapp/fc-deploy@dev;devsapp/fc-build@dev;devsapp/fc-local-invoke@dev'

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

# Test Nodjs Runtime
cd ../nodejs
echo "test nodejs12 runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test nodejs14 runtime ..."
s build -d -t s-node14.yaml
s local invoke -e '{"hello":"fc"}' -t s-node14.yaml
s deploy -y --use-local -t s-node14.yaml
s invoke -e '{"hello":"fc"}' -t s-node14.yaml


echo "test nodejs16 runtime ..."
s build -d -t s-node16.yaml
s local invoke -e '{"hello":"fc"}' -t s-node16.yaml
s deploy -y --use-local -t s-node16.yaml
s invoke -e '{"hello":"fc"}' -t s-node16.yaml

# Test Python Runtime
cd ../python
echo "test python3.6 runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

echo "test python2.7 runtime ..."
rm -rf .s
s build -d -t s-python2.yaml
s local invoke -e '{"hello":"fc"}' -t s-python2.yaml
s deploy -y --use-local -t s-python2.yaml
s invoke -e '{"hello":"fc"}' -t s-python2.yaml

echo "test python3.9 runtime ..."
rm -rf .s
s build -d -t s-python39.yaml
s local invoke -e '{"hello":"fc"}' -t s-python39.yaml
s deploy -y --use-local -t s-python39.yaml
s invoke -e '{"hello":"fc"}' -t s-python39.yaml

# Test Php7.2 Runtime
cd ../php
echo "test php7.2 runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

# Test custom container
cd ../custom-container
echo "test custom-container runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'


# Test custom runtime
cd ../custom
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
