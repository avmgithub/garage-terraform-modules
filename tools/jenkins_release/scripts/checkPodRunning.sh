#!/usr/bin/env bash

NAME="$1"
NAMESPACE="$2"

if [[ -z "${NAME}" ]]; then
    echo "NAME not provided"
    exit 1
fi

if [[ "${NAME}" == "--help" ]]; then
    echo "Usage: ${0} {POD_NAME}"
    exit 1
fi

if [[ -z "${NAMESPACE}" ]]; then
    NAMESPACE="tools"
fi

if [[ -z "${EXCLUDE_POD_NAME}" ]]; then
    EXCLUDE_POD_NAME="EXCLUDE_POD_NAME"
fi

POD_NAME=$(kubectl get pods -n ${NAMESPACE} | grep -v "${EXCLUDE_POD_NAME}" | grep -m 1 "${NAME}" | sed -E "s/([a-zA-Z0-9-]+) +.*/\1/g")

STATUS=$(kubectl get pod/${POD_NAME} -n ${NAMESPACE} -o jsonpath="{ .status.phase }")

if [[ "Running" == "${STATUS}" ]]; then
    exit 0
else
    exit 1
fi
