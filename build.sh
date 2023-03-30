#/bin/sh

DOCKER=/usr/bin/podman
GREP=/usr/bin/grep
AWK=/usr/bin/awk

OS=TEMPLATE
IMAGE_NAME=${OS}-wsl
WSL_TAR=${OS}-wsl.tar

if [[ -z "${USER}" ]]; then
        echo USER environment variable required.
        exit 1
fi
if [[ -z "${PASSWORD}" ]]; then
        echo PASSWORD environment variable required.
        exit 1
fi
if [[ -z "${FULLNAME}" ]]; then
        echo FULLNAME environment variable required.
        exit 1
fi
if [[ -z "${EMAIL}" ]]; then
        echo EMAIL environment variable required.
        exit 1
fi

echo Creating Image
$DOCKER image build --squash \
	--build-arg "USER=$USER" \
	--build-arg "PASSWORD=$PASSWORD" \
	--build-arg "EMAIL=$EMAIL" \
	--build-arg "FULLNAME=$FULLNAME" \
	--tag "$IMAGE_NAME" .

echo Creating Container
# TIP: Add '-it' after run to ease debugging.
$DOCKER run $IMAGE_NAME

echo Determining ID
ID=$($DOCKER container ls -a | $GREP -i $IMAGE_NAME | $AWK '{print $1}')
echo Container ID: $ID

echo Exporting
$DOCKER export $ID > $WSL_TAR

echo Cleaning up
$DOCKER container rm $ID
$DOCKER image rm $IMAGE_NAME



