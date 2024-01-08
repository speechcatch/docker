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

if [ "$DIST" = "aia" ]; then
    BASE_NAME="aicc_grpc"
    BASE_VERSION="1.1"
    # gRPC base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base/${BASE_VERSION}"

    # aia용 빌드 이미지 생성
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b aia --single-branch https://github.com/speechcatch/grpc_go.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi

# 소스에 있는대로 이미지 생성
if [ "$DIST" = "aia_fromsource" ]; then
    BASE_NAME="aicc_grpc"
    BASE_VERSION="1.1"
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/aia/${VERSION}" --no-cache
fi


if [ "$DIST" = "adt" ]; then
    BASE_NAME="aicc_grpc"
    BASE_VERSION="1.1"
    # gRPC base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base/${BASE_VERSION}"

    # adt용 빌드 이미지 생성
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b adt --single-branch https://github.com/speechcatch/grpc_go.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi

if [ "$DIST" = "adt_fromsource" ]; then
    BASE_NAME="aicc_grpc"
    BASE_VERSION="1.1"
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/adt/${VERSION}" --no-cache
fi

if [ "$DIST" = "onnx" ]; then
    # onnx 개발용
    BASE_NAME="aicc_grpc_centos"
    BASE_VERSION="1.1"
    # gRPC base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base_centos/${BASE_VERSION}"

    # onnx용 빌드 이미지 생성
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone https://github.com/speechcatch/grpc_go.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_onnx:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi

if [ "$DIST" = "accu.aicc" ]; then
    BASE_NAME="aicc_grpc_centos"
    BASE_VERSION="1.1"
    # gRPC base image 생성
    docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base_centos/${BASE_VERSION}"

    # onnx용 빌드 이미지 생성
    rm -rf dist/${DIST}/${VERSION}/source/*
    rm -rf dist/${DIST}/${VERSION}/source/.git*
    git clone -b accu.aicc --single-branch https://github.com/speechcatch/grpc_go.git dist/${DIST}/${VERSION}/source
    docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_accu.aicc:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi