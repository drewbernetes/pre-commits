#!/usr/bin/env bash


function complete {
  if [ -z "$image_name" ]; then
    echo "no image name supplied"
    exit 1
  fi

  if [ -z "$dockerfile_path" ]; then
    dockerfile_path="./Dockerfile"
    if [ ! -f "$dockerfile_path" ]; then
    printf 'no Dockerfile found at location: %s\n' $dockerfile_path
    exit 1
    fi
  fi

  if [ -z "$context" ]; then
    context="."
  fi
}

function build_image {
  docker build -t local/${image_name}:0.0.0 -f ${dockerfile_path} ${context}
}


cmd="$1"

while [[ $# -gt 0 ]]; do
	case $1 in
		--image-name)
			image_name=$2
			shift
			;;
		--dockerfile-path)
			dockerfile_path="$2"
			shift
			;;
		--context)
			context="$2"
			shift
			;;
	esac
	shift
done

case $cmd in
  build)
    complete
    build_image
    ;;
esac
