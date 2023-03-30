#/bin/sh

echo "This is a template.  You must run from one of the concrete branches."
exit

DOCKER=/usr/bin/podman
GREP=/usr/bin/grep
AWK=/usr/bin/awk

OS=debian
IMAGE_NAME=${OS}-wsl
WSL_TAR=${OS}-wsl.tar

echo Creating Image
$DOCKER image build --squash \
	--build-arg "USER=${USER:?USER is required}" \
	--build-arg "PASSWORD=${PASSWORD:?PASSWORD is required}" \
	--build-arg "EMAIL=${EMAIL:?EMAIL is required}" \
	--build-arg "FULLNAME=${FULLNAME:?FULLNAME is required}" \
	--build-arg "VERSION=${VERSION:-bullseye}" \
	--tag "$IMAGE_NAME" .

echo Creating Container
$DOCKER run ${DEBUG:+-it} $IMAGE_NAME

echo Determining ID
ID=$($DOCKER container ls -a | $GREP -i $IMAGE_NAME | $AWK '{print $1}')
echo Container ID: $ID

echo Exporting
$DOCKER export $ID > $WSL_TAR

echo Cleaning up
$DOCKER container rm $ID
$DOCKER image rm $IMAGE_NAME



