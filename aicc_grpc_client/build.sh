if [ $# -lt 2 ] ; then
    echo "Enter Argument : sh build.sh [Dist] [Version]"
    exit 0
fi

IMAGE_NAME="aicc_grpc_client"
DIST=$1
VERSION=$2
ARCHES="x86_64"
PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo ${ARCHES} | sed "s/,/ /g"); do printf 'linux/%s,' "${var}"; done | sed 's/,*$//g'`

echo "Build ${DIST} ${VERSION}"

if [ "$DIST" = "aia" ]; then
    BASE_NAME="aicc_grpc_client"
    BASE_VERSION="2.1"
    # gRPC client base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base/${BASE_VERSION}"

    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi