#!/usr/bin/env bash

# Data folder
DATASET_NAME=${DATASET_NAME:-"graph500_22-tmp"}
EDGE_FILE_URL=${EDGE_FILE_URL:-"https://s3.amazonaws.com/benchmarks.redislabs/redisgraph/datasets/graph500-22/IS_CONNECTED.csv"}
NODE_FILE_URL=${NODE_FILE_URL:-"https://s3.amazonaws.com/benchmarks.redislabs/redisgraph/datasets/graph500-22/Node.csv"}
BULK_DATA_DIR=${BULK_DATA_DIR:-"/tmp/bulk_data"}

# Ensure DATA DIR available
mkdir -p ${BULK_DATA_DIR}
chmod a+rwx ${BULK_DATA_DIR}

# Ensure DATASET DIR available
mkdir -p ${BULK_DATA_DIR}/${DATASET_NAME}
chmod a+rwx ${BULK_DATA_DIR}/${DATASET_NAME}

LOCAL_EDGE_FILE=${BULK_DATA_DIR}/${DATASET_NAME}/IS_CONNECTED.csv
LOCAL_NODE_FILE=${BULK_DATA_DIR}/${DATASET_NAME}/Node.csv

echo ""
echo "---------------------------------------------------------------------------------"
echo "Retrieving IS_CONNECTED.csv to ${LOCAL_EDGE_FILE}"
echo "---------------------------------------------------------------------------------"

if [ ! -f ${LOCAL_EDGE_FILE} ]; then
  echo "${LOCAL_EDGE_FILE} not found locally. Retrieving... it from ${EDGE_FILE_URL}"
  curl ${EDGE_FILE_URL} > ${LOCAL_EDGE_FILE}
else
  echo "Dataset found locally at ${LOCAL_EDGE_FILE}. No need to retrieve again."
fi

echo ""
echo "---------------------------------------------------------------------------------"
echo "Retrieving Node.csv to ${LOCAL_NODE_FILE}"
echo "---------------------------------------------------------------------------------"

if [ ! -f ${LOCAL_NODE_FILE} ]; then
  echo "${LOCAL_NODE_FILE} not found locally. Retrieving... it from ${NODE_FILE_URL}"
  curl ${NODE_FILE_URL} > ${LOCAL_NODE_FILE}
else
  echo "Dataset found locally at ${LOCAL_NODE_FILE}. No need to retrieve again."
fi

