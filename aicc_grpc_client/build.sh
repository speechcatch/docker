if [ $# -lt 1 ] ; then
    echo "Enter Argument : sh build.sh [Version]"
    exit 0
fi

IMAGE_NAME="aicc_grpc_client"
VERSION=$1
ARCHES="x86_64"
PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo $ARCHES | sed "s/,/ /g"); do printf 'linux/%s,' "$var"; done | sed 's/,*$//g'`

# gRPC client base image 생성
docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}:${VERSION}" "dist/${IMAGE_NAME}/${VERSION}/base"
