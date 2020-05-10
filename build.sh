#!/bin/bash
# get a list of papermc versions
versions=($(curl -k https://papermc.io/api/v1/paper/ | jq -r '.versions | @sh' -))

# build all versions
for i in "${!versions[@]}"; do
    # clean version number
    version=$(echo "${versions[$i]//\'/}")

    # image tag
    current_image="${CI_REGISTRY_USER}/papermc-docker-distroless:${version}"

    echo "Building ${current_image}"

    # build and push image
    docker build . --pull --tag ${current_image} --build-arg PAPERMC_VERSION=${version}
    docker push ${current_image}

    # tag and push latest if latest version
    if [ $i == 0 ]; then
        latest_image="${CI_REGISTRY_USER}/papermc-docker-distroless:latest"
        echo "Building ${latest_image}"
        docker tag ${current_image} ${latest_image}
        docker push ${latest_image}
    fi
done
