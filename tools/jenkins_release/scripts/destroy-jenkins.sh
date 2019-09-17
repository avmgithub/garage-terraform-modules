#!/usr/bin/env bash
set -x 

NAMESPACE="$1"

if [[ -n "${KUBECONFIG_IKS}" ]]; then
    export KUBECONFIG="${KUBECONFIG_IKS}"
fi

kubectl delete all -n "${NAMESPACE}" -l app=jenkins
