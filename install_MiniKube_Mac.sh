#!/bin/bash -e
# ---------------------------------------------------------------------------- #
echo ""
echo "--- Installing/Updating MiniKube from HomeBrew -------------------------"

echo ""
echo "--- Installing Kubernetes ..."
brew install kubectl

echo ""
echo "--- Installing MiniKube ..."
brew cask install minikube

# echo ""
# echo "--- Installing XHyve ..."
# brew install docker-machine-driver-xhyve
# echo "*** Now, run the two 'sudo' commands it requests you to"
# echo "***    \$ sudo chown root:wheel /usr/local/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve"
# echo "***    \$ sudo chmod u+s /usr/local/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve"

echo ""
echo "--- Installing HyperKit (instead of XHyve) ..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
&& sudo install -o root -g wheel -m 4755 docker-machine-driver-hyperkit /usr/local/bin/

echo ""
echo "--- Confirming Kubernetes is configured to work with 'minikube' ..."
echo "    (kubectl config current-context)"
CURRENT_CONTEXT=`kubectl config current-context`
if [[ $CURRENT_CONTEXT == "minikube" ]]
then
  echo "    OK (got '$CURRENT_CONTEXT')"
else
  echo "    FAILED - got '$CURRENT_CONTEXT'"
fi

echo ""
echo "*** To start the Kubernetes cluster,"
echo "*** run:"
echo "***     \$ minikube start --vm-driver=hyperkit"
# echo "***     \$ minikube start --vm-driver=xhyve"
