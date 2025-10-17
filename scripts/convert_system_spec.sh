#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

if ! command -v npx >/dev/null 2>&1; then
  echo "npx is required to run this script. Please install Node.js and npm." >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

SOURCE_SPEC="${TMP_DIR}/System_API.json"
curl -fsSL "https://developer-v4.enphase.com/swagger/spec/System_API.json" -o "${SOURCE_SPEC}"

npx --yes swagger2openapi \
  --outfile "${REPO_ROOT}/openapi/system.yaml" \
  --yaml \
  "${SOURCE_SPEC}"
