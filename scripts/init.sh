#!/bin/bash

set -e

docker-compose -f docker-compose.build.yml build --force-rm --no-cache
docker-compose -f docker-compose.dev.yml build --force-rm --no-cache
docker-compose -f docker-compose.build.yml run --rm node
docker-compose -f docker-compose.dev.yml run --rm --entrypoint "alembic upgrade head" szurubooru
