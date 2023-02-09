#!/bin/bash
set -x
set -e
# s clean --component

# export FC_DOCKER_VERSION=1.10.6
export core_load_serverless_devs_component='devsapp/fc-deploy@dev'

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

echo "test nodejs10 runtime ..."
rm -rf .s
s build -d -t s-node10.yaml
s local invoke -e '{"hello":"fc"}' -t s-node10.yaml
s deploy -y --use-local -t s-node10.yaml
s invoke -e '{"hello":"fc"}' -t s-node10.yaml

echo "test nodejs8 runtime ..."
rm -rf .s
s build -d -t s-node8.yaml
s local invoke -e '{"hello":"fc"}' -t s-node8.yaml
s deploy -y --use-local -t s-node8.yaml
s invoke -e '{"hello":"fc"}' -t s-node8.yaml

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
s invoke -f ./event/http.json

cd ../springboot
echo "test custom runtime springboot ..."
rm -rf .s
s deploy -y --use-local
s invoke -f ./event/http.json

echo "test custom runtime springboot start java -jar ..."
rm -rf .s
s deploy -y --use-local -t s.jar.yaml
s invoke -t s.jar.yaml -f ./event/http.json

cd ../go
echo "test custom runtime go ..."
rm -rf .s
s deploy -y --use-local
s invoke -e "hello world from github action"
s local invoke -e "hello world from github action local invoke"


# Test go1.x Runtime
cd ../go
echo "test go1.x runtime ..."
rm -rf .s
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

s local invoke -e '{"hello":"fc local invoke"}'