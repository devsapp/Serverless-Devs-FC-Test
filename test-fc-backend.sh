#!/bin/bash
set -x
set -e
s clean --all

export core_load_serverless_devs_component='devsapp/fc-deploy@dev'

if [[ `uname` == 'Linux' ]]; then
  echo "Linux test fc-backend start..."
  export BUILD_IMAGE_ENV=fc-backend
  # Test Python Runtime
  cd python
  echo "test python3.6 runtime ..."
  rm -rf .s
  s build -d
  s deploy -y --use-local
  s invoke -e '{"hello":"fc"}'

  echo "test python3.9 runtime ..."
  rm -rf .s
  s build -d -t s-python39.yaml
  s deploy -y --use-local -t s-python39.yaml
  s invoke -e '{"hello":"fc"}' -t s-python39.yaml

  cd ../nodejs
  echo "test nodejs12 runtime ..."
  rm -rf .s
  s build -d
  s deploy -y --use-local
  s invoke -e '{"hello":"fc"}'

  echo "test nodejs14 runtime ..."
  s build -d -t s-node14.yaml
  s deploy -y --use-local -t s-node14.yaml
  s invoke -e '{"hello":"fc"}' -t s-node14.yaml
else
  echo "no need test!"
fi