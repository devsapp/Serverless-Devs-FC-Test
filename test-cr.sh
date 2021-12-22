#!/bin/bash
set -x
s clean --all


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

echo "remove all"
s remove -y