#!/bin/bash

GDAL_VERSION=$1
GDAL_VERSION_TAG=${GDAL_VERSION%.*}
RUNTIME=$2
RUNTIME_VERSION=$3
PLATFORM=${PLATFORM:-linux/amd64}

echo "Building image for AWS Lambda | GDAL: ${GDAL_VERSION} | Runtime: ${RUNTIME}:${RUNTIME_VERSION} | Platform: ${PLATFORM}"

cd "$(dirname "$0")/.."

# Other library versions are pinned in versions.env and shared with CI;
# GDAL_VERSION here always overrides whatever is pinned there.
source versions.env
build_args=(--build-arg GDAL_VERSION=${GDAL_VERSION})
while IFS='=' read -r name value; do
    [[ -z $name || $name == \#* || $name == GDAL_VERSION || $name == NUMPY_VERSION ]] && continue
    build_args+=(--build-arg "${name}=${value}")
done < versions.env

docker buildx build \
    --platform=${PLATFORM} \
    "${build_args[@]}" \
    -f dockerfiles/Dockerfile \
    -t ghcr.io/wongcht/lambda-gdal:${GDAL_VERSION_TAG} .

runtime_build_args=(--build-arg GDAL_VERSION_TAG=${GDAL_VERSION_TAG} --build-arg RUNTIME_VERSION=${RUNTIME_VERSION})
if [[ "$RUNTIME" == "python" ]]; then
    runtime_build_args+=(--build-arg NUMPY_VERSION=${NUMPY_VERSION} --build-arg PKG_INSTALLER=dnf)
fi

docker buildx build \
    --platform=${PLATFORM} \
    "${runtime_build_args[@]}" \
    -f dockerfiles/runtimes/${RUNTIME} \
    -t ghcr.io/wongcht/lambda-gdal:${GDAL_VERSION_TAG}-${RUNTIME}${RUNTIME_VERSION} .
