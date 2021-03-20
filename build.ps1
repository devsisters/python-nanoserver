$TARGET_PYTHON_VERSION=('3.8.8')
$TARGET_WINDOWS_VERSION=(
    '10.0.17763.1817-amd64', # LTSC 2019
    '10.0.18363.1198-amd64', # 1909
    '10.0.19041.867-amd64'   # 2004
)

$TARGET_PYTHON_PIP_VERSION='21.0.1'
$TARGET_PYTHON_GET_PIP_URL='https://github.com/pypa/get-pip/raw/d59197a3c169cef378a22428a3fa99d33e080a5d/get-pip.py'

foreach ($EACH_PYTHON_VERSION in $TARGET_PYTHON_VERSION) {
    foreach ($EACH_WIN_VERSION in $TARGET_WINDOWS_VERSION) {
        $IMAGE_TAG="${EACH_PYTHON_VERSION}_${EACH_WIN_VERSION}"
        docker build `
            -t python-nanoserver:$IMAGE_TAG `
            --build-arg WINDOWS_VERSION=$EACH_WIN_VERSION `
            --build-arg PYTHON_VERSION=$EACH_PYTHON_VERSION `
            --build-arg PYTHON_RELEASE=$EACH_PYTHON_VERSION `
            --build-arg PYTHON_PIP_VERSION=$TARGET_PYTHON_PIP_VERSION `
            --build-arg PYTHON_GET_PIP_URL=$TARGET_PYTHON_GET_PIP_URL `
            .
        docker tag python-nanoserver:$IMAGE_TAG 425927401566.dkr.ecr.ap-northeast-1.amazonaws.com/python-nanoserver:$IMAGE_TAG
        docker push 425927401566.dkr.ecr.ap-northeast-1.amazonaws.com/python-nanoserver:$IMAGE_TAG
        docker rmi python-nanoserver:$IMAGE_TAG
    }
}

docker container prune
docker image prune
