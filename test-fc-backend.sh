#!/bin/bash
set -x
set -e
s clean --all

export core_load_serverless_devs_component='devsapp/fc-deploy@dev'

if [[ `uname` == 'Linux' ]]; then
  echo "Linux test fc-backend start..."
  apt-get update && apt-get -y install sudo curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda -y \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes
  export PATH=/opt/conda/bin:$PATH
  conda create -n py36  python=3.6 -y
  conda create -n py39  python=3.9 -y
  export BUILD_IMAGE_ENV=fc-backend
  # Test Python Runtime
  cd python
  export PATH=/usr/local/envs/py36/bin:$PATH
  python -V
  echo "test python3.6 runtime ..."
  rm -rf .s
  s build -d
  s deploy -y --use-local
  s invoke -e '{"hello":"fc"}'

  echo "test python3.9 runtime ..."
  rm -rf .s
  export PATH=/usr/local/envs/py39/bin:$PATH
  python -V
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