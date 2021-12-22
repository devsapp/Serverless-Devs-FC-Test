#!/bin/bash
set -x
s clean --all

# Test Python Runtime
cd python
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

echo "remove all"
s remove -y