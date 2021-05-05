#!/usr/bin/env bash

DATASET_DIR=${DATASET_DIR:-"graph500_22"}
EXE_DIR=${EXE_DIR:-$(dirname $0)}
source ${EXE_DIR}/common.sh

# Run RedisGraph bulk import script
redisgraph-bulk-loader graph500_22 --enforce-schema \
  --nodes ${DATASET}/Node.csv \
  --relations${DATASET}/IS_CONNECTED.csv \
  --max-buffer-size 512 \
  --index "Node:IS_CONNECTED" \
  --host ${DATABASE_HOST} --port ${DATABASE_PORT} || exit 1
