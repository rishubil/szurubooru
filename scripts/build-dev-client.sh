#!/bin/bash

set -e

docker-compose -f docker-compose.build-dev.yml run --rm node
