#!/bin/bash

set -e

cat $2 | docker exec -i $1 psql -U postgres