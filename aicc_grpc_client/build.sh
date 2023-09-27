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
    # gRPC client base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}:${VERSION}" "dist/base/${VERSION}"

    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi