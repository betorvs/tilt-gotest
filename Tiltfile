custom_build(
    'tilt-gotest',
    'make build-push VERSION=$EXPECTED_TAG',
    deps=['main.go', 'go.mod', 'go.sum'], disable_push=False,
    skips_local_docker=True,
)
k8s_yaml(helm('./deploy/helm/tilt-gotest'))
k8s_resource('chart-tilt-gotest', port_forwards="9090:9090")