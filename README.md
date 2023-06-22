# tilt gotest 

This is an example repository with a simple go application, without external dependecies for demonstration purpose, and it was create to use [Tilt](https://docs.tilt.dev/index.html) to automate all development process like docker build, helm/kustomize and kubernetes deployment.

## Tools

- docker (or any other container runtime that works for you)
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl), [kustomize](https://kustomize.io/) and/or [helm](https://helm.sh/) depending what do you prefer.
- [make](https://www.gnu.org/software/make/) to easy use it. (MacOS users [here](https://formulae.brew.sh/formula/make))
- [kind](https://kind.sigs.k8s.io/) or [k3d](https://k3d.io/) for local kubernetes deployment. Use our make command below.
- [tilt](https://github.com/tilt-dev/tilt), [ctlptl](https://github.com/tilt-dev/ctlptl). Use our make command below.
- [go](https://go.dev/) if you want to change golang code. For this demonstration you really don't need go.


## How to use it

1. Install requirements: `make k3d-install-linux` or `make k3d-install-macos`
2. Create local cluster: `make k3d-cluster-create`
3. Run it: `make tilt` or `make tilt-remote` (in case you are running in a local remote machine ;) )
4. Test it: Open Tilt UI, usually `http://127.0.0.1:10350/` and click in Application Link inside Tilt UI. There are 2 endpoints available: "/" with just an OK and "/info" with built information like version. You can run `make status` to check all kubernetes resources created if you want.
5. Play with it. Enjoy! 

## Tiltfiles

- Tiltfile: Helm based version
- Tiltfile-kustomize: Kustomize version. Replace that other and test it.

## Removing everything

1. Run `make tilt-down`
2. Run `make k3d-cluster-delete`

## FAQ

1. What's is `make tilt-remote`? I usually run it in a local server that is hosted in my local network, for it, I need to change `REMOTE_IP_ADDRESS` variable if I want to connect to my remote server. 
2. Kind architecture variable is used to download, please change it in case of ARM arch to `arm64`.
3. Update `CTLPTL_VERSION` variable to update it. 