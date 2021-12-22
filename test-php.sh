#!/bin/bash
set -x
s clean --all

# Test Php7.2 Runtime
cd php
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

echo "remove all"
s remove -y