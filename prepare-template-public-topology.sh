#!/bin/bash
export CLUSTER_TEMPLATE_YAML=public-topology.tmpl.yaml
export CLUSTER_NAME=test.stackator.com
export KOPS_STATE_STORE_BUCKET=test-stackator-kops-state-store
export REGION=eu-west-1
export K8S_VERSION=1.11.7
export MASTER_PUBLIC_NAME=api.test.stackator.com
export MASTER_IMAGE_ID=ami-02dea79d6a7f53d15
export MASTER_SERVER_TYPE=t2.medium
export MASTER_MAX_SIZE=1
export MASTER_MIN_SIZE=1
export NODES_IMAGE_ID=ami-02dea79d6a7f53d15
export NODES_SERVER_TYPE=t2.xlarge
export NODES_MAX_PRICE=0.2
export NODES_MAX_SIZE=4
export NODES_MIN_SIZE=4
export APP_NODES_IMAGE_ID=ami-02dea79d6a7f53d15
export APP_NODES_SERVER_TYPE=m4.large
export APP_NODES_MAX_PRICE=0.1
export APP_NODES_MAX_SIZE=2
export APP_NODES_MIN_SIZE=2
export CLUSTER_YAML=${CLUSTER_TEMPLATE_YAML%%.*}.yaml

set -ex

declare -A envMap

envMap=(["CLUSTER_NAME"]="${CLUSTER_NAME}"
  ["CLUSTER_TEMPLATE_YAML"]="${CLUSTER_TEMPLATE_YAML}" 
  ["KOPS_STATE_STORE_BUCKET"]="${KOPS_STATE_STORE_BUCKET}" 
  ["REGION"]="${REGION}" 
  ["K8S_VERSION"]="${K8S_VERSION}" 
  ["MASTER_PUBLIC_NAME"]="${MASTER_PUBLIC_NAME}" 
  ["MASTER_IMAGE_ID"]="${MASTER_IMAGE_ID}" 
  ["MASTER_SERVER_TYPE"]="${MASTER_SERVER_TYPE}" 
  ["MASTER_MAX_SIZE"]="${MASTER_MAX_SIZE}" 
  ["MASTER_MIN_SIZE"]="${MASTER_MIN_SIZE}" 
  ["NODES_IMAGE_ID"]="${NODES_IMAGE_ID}" 
  ["NODES_SERVER_TYPE"]="${NODES_SERVER_TYPE}" 
  ["NODES_MAX_PRICE"]="${NODES_MAX_PRICE}" 
  ["NODES_MAX_SIZE"]="${NODES_MAX_SIZE}" 
  ["NODES_MIN_SIZE"]="${NODES_MIN_SIZE}" 
  ["APP_NODES_IMAGE_ID"]="${APP_NODES_IMAGE_ID}" 
  ["APP_NODES_SERVER_TYPE"]="${APP_NODES_SERVER_TYPE}" 
  ["APP_NODES_MAX_PRICE"]="${APP_NODES_MAX_PRICE}" 
  ["APP_NODES_MAX_SIZE"]="${APP_NODES_MAX_SIZE}" 
  ["APP_NODES_MIN_SIZE"]="${APP_NODES_MIN_SIZE}" 
)

for v in "${!envMap[@]}";do
  if  [[ -z ${envMap[${v}]} ]]
  then
    echo -e "ERROR\tThe variable \"${v}\" is NOT set"
    exit 1
  fi
done

envsubst < ${CLUSTER_TEMPLATE_YAML} > ${CLUSTER_YAML}
