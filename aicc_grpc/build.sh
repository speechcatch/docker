if [ $# -lt 2 ] ; then
    echo "Enter Argument : sh build.sh [Dist] [Version]"
    exit 0
fi

IMAGE_NAME="aicc_grpc"
DIST=$1
VERSION=$2
ARCHES="x86_64"
PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo ${ARCHES} | sed "s/,/ /g"); do printf 'linux/%s,' "${var}"; done | sed 's/,*$//g'`

echo "Build ${DIST} ${VERSION}"

# gRPC base image 생성
docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}:${VERSION}" "dist/base/${VERSION}"

# aia용 빌드 이미지 생성
if [ "$DIST" = "aia" ]; then
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b aia --single-branch https://github.com/LeeYangseung/grpc_go.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/${DIST}/${VERSION}"
fi

# 소스에 있는대로 이미지 생성
if [ "$DIST" = "aia_fromsource" ]; then
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/aia/${VERSION}"
fi

# adt용 빌드 이미지 생성
if [ "$DIST" = "adt" ]; then
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b adt --single-branch https://github.com/LeeYangseung/grpc_go.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/${DIST}/${VERSION}"
fi

if [ "$DIST" = "adt_fromsource" ]; then
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/adt/${VERSION}"
fi