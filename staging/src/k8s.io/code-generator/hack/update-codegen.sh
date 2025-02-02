#!/usr/bin/env bash

# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..

# generate the code with:
# - --output-base because this script should also be able to run inside the vendor dir of
#   k8s.io/kubernetes. The output-base is needed for the generators to output into the vendor dir
#   instead of the $GOPATH directly. For normal projects this can be dropped.
"${SCRIPT_ROOT}/generate-internal-groups.sh" "client,conversion,deepcopy,defaulter,informer,lister,openapi" \
  k8s.io/code-generator/examples/apiserver \
  k8s.io/code-generator/examples/apiserver/apis \
  k8s.io/code-generator/examples/apiserver/apis \
  "example:v1 example2:v1 example3.io:v1" \
  --output-base "$(dirname "${BASH_SOURCE[0]}")/../../.." \
  --go-header-file "${SCRIPT_ROOT}/hack/boilerplate.go.txt"
"${SCRIPT_ROOT}/generate-groups.sh" "applyconfiguration,client,deepcopy,defaulter,informer,lister" \
  k8s.io/code-generator/examples/crd \
  k8s.io/code-generator/examples/crd/apis \
  "example:v1 example2:v1" \
  --output-base "$(dirname "${BASH_SOURCE[0]}")/../../.." \
  --go-header-file "${SCRIPT_ROOT}/hack/boilerplate.go.txt"
"${SCRIPT_ROOT}/generate-groups.sh" "applyconfiguration,client,deepcopy,defaulter,informer,lister" \
  k8s.io/code-generator/examples/MixedCase \
  k8s.io/code-generator/examples/MixedCase/apis \
  "example:v1" \
  --output-base "$(dirname "${BASH_SOURCE[0]}")/../../.." \
  --go-header-file "${SCRIPT_ROOT}/hack/boilerplate.go.txt"
"${SCRIPT_ROOT}/generate-groups.sh" "applyconfiguration,client,deepcopy,defaulter,informer,lister" \
  k8s.io/code-generator/examples/HyphenGroup \
  k8s.io/code-generator/examples/HyphenGroup/apis \
  "example:v1" \
  --output-base "$(dirname "${BASH_SOURCE[0]}")/../../.." \
  --go-header-file "${SCRIPT_ROOT}/hack/boilerplate.go.txt"
