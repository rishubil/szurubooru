#!/bin/bash

set -e

docker-compose -f docker-compose.build.yml run --rm node
