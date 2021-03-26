#! /bin/bash


SCRIPT_DIRECTORY=$(readlink -f $0)
SCRIPT_DIRECTORY=$(cd $(dirname $SCRIPT_DIRECTORY); pwd)


PROJECT_NAME="gitsync"
IMAGE_DIRECTORY="$SCRIPT_DIRECTORY/image"
SOURCE_DIRECTORY="$IMAGE_DIRECTORY/$PROJECT_NAME" 
SOURCE_REPOSITORY_URL="https://github.com/edijon/$PROJECT_NAME.git"


main() {
    get_source_code
    build_image
}


get_source_code() {
    if [ ! -d $IMAGE_DIRECTORY ]
    then
        clone_repository
    else
        pull_repository
    fi
}


clone_repository() {
    mkdir $IMAGE_DIRECTORY && cd $IMAGE_DIRECTORY && git clone --depth=1 $REPOSITORY_URL
    if [ ! -d $SOURCE_DIRECTORY ]
    then
        exit 1
    fi
    cd $SCRIPT_DIRECTORY
}


pull_repository() {
    cd $SOURCE_DIRECTORY && git pull origin main
    cd $SCRIPT_DIRECTORY
}


build_image() {
    cd $SCRIPT_DIRECTORY
    docker image build -f Dockerfile --tag $PROJECT_NAME:$PROJECT_VERSION .
}


main $@