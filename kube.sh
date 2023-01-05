#!/bin/bash

DEFAULT_KUBE_CONTEXTS="$HOME/.kube/config"
if test -f "${DEFAULT_KUBE_CONTEXTS}"
then
  export KUBECONFIG="$DEFAULT_KUBE_CONTEXTS"
fi

echo "How you want to name this kubeconfig?"
read name
while [ -f "$CUSTOM_KUBE_CONTEXTS/$name.yml" ]
do
echo "File exists"
echo "Write anouther name"
read name
done

cp "$DEFAULT_KUBE_CONTEXTS" "$CUSTOM_KUBE_CONTEXTS/$name.yml"

# Other conexts
CUSTOM_KUBE_CONTEXTS="$HOME/.kube/custom-contexts"
mkdir -p "${CUSTOM_KUBE_CONTEXTS}"

for contextFile in `find "${CUSTOM_KUBE_CONTEXTS}" -type f -name "*.yml"`
do
    export KUBECONFIG="$contextFile:$KUBECONFIG"
done
