if [ $# -lt 2 ] ; then
    echo "Enter Argument : sh build.sh [Dist] [Version]"
    exit 0
fi

IMAGE_NAME="aicc_tts_server" 
DIST=$1
VERSION=$2
ARCHES="x86_64"
PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo $ARCHES | sed "s/,/ /g"); do printf 'linux/%s,' "$var"; done | sed 's/,*$//g'`


# speechclone 2.0 빌드 이미지 생성
if [ "$DIST" = "speechclone" ]; then

  rm -rf dist/${DIST}/${VERSION}/source/
  git clone  https://github.com/speechclone/speechclone2.0_inf.git dist/${DIST}/${VERSION}/source

  docker buildx build --load ${PLATFORM_ARG} -t "${DIST}:${VERSION}" --build-arg "VERSION"=${VERSION} "dist/${DIST}/${VERSION}" --no-cache
fi


# aia용 빌드 이미지 생성
if [ "$DIST" = "aia" ]; then
  BASE_NAME="aicc_tts_server_centos"
  BASE_VERSION="1.48"
  # TTS base image 생성
  docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base_centos/${BASE_VERSION}"

  rm -rf dist/${DIST}/${VERSION}/source/
  git clone -b aia --single-branch https://github.com/speechclone/speechclone_8k_inf.git dist/${DIST}/${VERSION}/source
  git clone -b aia --single-branch https://github.com/speechclone/korean_normalizer.git dist/${DIST}/${VERSION}/source/speechclone_tts/utils/korean_normalizer
  git clone https://github.com/speechclone/e2hsk.git dist/${DIST}/${VERSION}/source/speechclone_tts/utils/korean_normalizer/e2hsk

  docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_aia:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}" "dist/${DIST}/${VERSION}" --no-cache
fi


# adt용 빌드 이미지 생성
if [ "$DIST" = "adt" ]; then
  BASE_NAME="aicc_tts_server"
  BASE_VERSION="2.0"
  # TTS base image 생성
  docker buildx build --load ${PLATFORM_ARG} -t "${BASE_NAME}:${BASE_VERSION}" "dist/base/${BASE_VERSION}"

  rm -rf dist/${DIST}/${VERSION}/source/
  git clone -b adt --single-branch https://github.com/speechclone/speechclone_8k_inf.git dist/${DIST}/${VERSION}/source
  git clone -b adt --single-branch https://github.com/speechclone/korean_normalizer.git dist/${DIST}/${VERSION}/source/speechclone_tts/utils/korean_normalizer

  docker buildx build --load ${PLATFORM_ARG} -t "${IMAGE_NAME}_adt:${VERSION}" --build-arg "BUILDER=${BASE_NAME}:${BASE_VERSION}"  "dist/${DIST}/${VERSION}" --no-cache
fi