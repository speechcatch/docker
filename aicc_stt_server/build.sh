if [ $# -lt 2 ] ; then
    echo "Enter Argument : sh build.sh [Dist] [Version]"
    exit 0
fi

IMAGE_NAME="aicc_stt_server"
DIST=$1
VERSION=$2
ARCHES="x86_64"
PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo $ARCHES | sed "s/,/ /g"); do printf 'linux/%s,' "$var"; done | sed 's/,*$//g'`

echo "Build ${DIST} ${VERSION}"

# aia용 빌드 이미지 생성
if [ "$DIST" = "aia" ]; then
    BASE_NAME="aicc_stt_server_centos"
    BASE_VERSION="1.44"
    # STT base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base_centos/${BASE_VERSION}"

    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b aia --single-branch https://github.com/LeeYangseung/STT_Server_E2E.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi

# adt용 빌드 이미지 생성
if [ "$DIST" = "adt" ]; then
    BASE_NAME="aicc_stt_server"
    BASE_VERSION="1.48"
    # STT base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base/${BASE_VERSION}"

    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b adt --single-branch https://github.com/LeeYangseung/STT_Server_E2E.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no_cache
fi