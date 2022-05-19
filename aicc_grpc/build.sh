IMAGE_NAME="aicc_grpc"
VERSION="1.1"
ARCHES="x86_64"
PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo $ARCHES | sed "s/,/ /g"); do printf 'linux/%s,' "$var"; done | sed 's/,*$//g'`

# gRPC base image 생성
docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}:${VERSION}" "dist/${IMAGE_NAME}/${VERSION}/base"

# aia용 빌드 이미지 생성
cp -r /root/go/src/grpc_aia dist/${IMAGE_NAME}/${VERSION}/aia/source
docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/${IMAGE_NAME}/${VERSION}/aia"

# adt용 빌드 이미지 생성
cp -r /root/go/src/grpc_adt dist/${IMAGE_NAME}/${VERSION}/adt/source
docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" --build-arg "VERSION=${VERSION}" "dist/${IMAGE_NAME}/${VERSION}/adt"
