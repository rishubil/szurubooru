#!/bin/bash
set -eo pipefail

cd /yfbooru/client

if [ ! -z $1 ]
then
  exec $@
else
  npm install
  npm run build
fi
