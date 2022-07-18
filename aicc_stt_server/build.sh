if [ $# -lt 2 ] ; then
    echo "Enter Argument : sh build.sh [Dist] [Version]"
    exit 0
fi

IMAGE_NAME="aicc_stt_server"
DIST=$1
VERSION=$2
ARCHES="x86_64"
PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo $ARCHES | sed "s/,/ /g"); do printf 'linux/%s,' "$var"; done | sed 's/,*$//g'`

# gRPC base image 생성
docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}:${VERSION}" "dist/base/${VERSION}"

# aia용 빌드 이미지 생성
if [ "$DIST" = "aia" ]; then
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b adt --single-branch https://github.com/LeeYangseung/STT_Server_E2E.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/${DIST}/${VERSION}"
fi

# adt용 빌드 이미지 생성
if [ "$DIST" = "adt" ]; then
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b adt --single-branch https://github.com/LeeYangseung/STT_Server_E2E.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/${DIST}/${VERSION}"
fi