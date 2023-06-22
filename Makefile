VERSION := 1.0
REMOTE_IP_ADDRESS := "192.168.188.10"
LOCAL_REGISTRY := "127.0.0.1:5005"
CTLPTL_VERSION := "0.8.20"
KIND_ARQ := "amd64"

kind-install-macos:
	brew install kind
	brew install tilt-dev/tap/ctlptl

k3d-install-macos:
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
	brew install tilt-dev/tap/ctlptl


kind-install-linux:
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-$(KIND_ARQ) && chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind
	curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$(CTLPTL_VERSION)/ctlptl.$(CTLPTL_VERSION).linux.x86_64.tar.gz | sudo tar -xzv -C /usr/local/bin ctlptl

k3d-install-linux:
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
	curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$(CTLPTL_VERSION)/ctlptl.$(CTLPTL_VERSION).linux.x86_64.tar.gz | sudo tar -xzv -C /usr/local/bin ctlptl


k3d-cluster-create:
	ctlptl create registry ctlptl-registry --port=5005
	ctlptl create cluster k3d --registry=ctlptl-registry

kind-cluster-create:
	ctlptl create registry ctlptl-registry --port=5005
	ctlptl create cluster kind --registry=ctlptl-registry

k3d-cluster-delete:
	ctlptl delete cluster k3d --cascade=true
	ctlptl delete registry ctlptl-registry

kind-cluster-delete:
	ctlptl delete cluster kind --cascade=true
	ctlptl delete registry ctlptl-registry

tilt:
	tilt up

tilt-remote:
	tilt up --host $(REMOTE_IP_ADDRESS)

tilt-down:
	tilt down

status:
	kubectl get svc,deploy,pods


build:
	docker build \
		-f deploy/Dockerfile \
		-t tilt-gotest:$(VERSION) \
		--build-arg VERSION=$(VERSION) .

push-local:
	docker tag tilt-gotest:$(VERSION) $(LOCAL_REGISTRY)/tilt-gotest:$(VERSION) \
    && docker push $(LOCAL_REGISTRY)/tilt-gotest:$(VERSION)

build-push: build push-local