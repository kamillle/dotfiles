#!/bin/sh

echo "====== Setup k8s ======"

brew install kustomize
# provide kubectx & kubens
brew install kubectx

echo "Install `kubectl krew`, check the url"
echo "https://krew.sigs.k8s.io/docs/user-guide/setup/install/"
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"${OS}_${ARCH}" &&
  "$KREW" install krew
)

echo "Restart shell..."
exec $SHELL -l
echo "Restarted!!"

echo "====== End ======"
