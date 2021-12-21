#!/bin/bash
set -x
rm -rf ~/.s/components/devsapp.cn/fc@dev

# Test custom container
cd custom-container
echo "test custom-container runtime ..."
rm -rf .s
s build -d
s local invoke -e '{"hello":"fc"}'
s deploy -y --use-local
s invoke -e '{"hello":"fc"}'

