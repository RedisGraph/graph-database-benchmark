#!/usr/bin/env bash

DATASET_DIR=${DATASET_DIR:-"graph500_22"}

EXE_DIR=${EXE_DIR:-$(dirname $0)}
source ${EXE_DIR}/common.sh

## Prepare input files in RedisGraph bulk import format
#python generate_graph500_inputs.py --inputdir ${DATASET} || exit 1

# Run RedisGraph bulk import script
python3  bulk_insert.py graph500_22 -n ${DATASET}/graph500_22_unique_node -r ${DATASET}/graph500_22 \
  --host ${DATABASE_HOST} --port ${DATABASE_PORT} || exit 1

# Create index on node ID property
python3 graph_query.py --name "graph500_22" --query "create index on :graph500_22_unique_node(id)" \
  --host ${DATABASE_HOST} --port ${DATABASE_PORT}
