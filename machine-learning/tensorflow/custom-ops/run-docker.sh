#!/bin/sh
set -e

main() {
  PROJECTDIR=$(dirname "$0")/../../../
  if [ "$1" = "heatmap_test" -o \
    "$1" = "heatmap_pip_pkg" -o \
    "$1" = "heatmap_pkg_test" ]; then
      if [ -z "$(docker images -q tensorflow113-opencv3:1)" ]; then
        echo "building image tensorflow113-opencv3:1."
        sh $PROJECTDIR/docker/tensorflow-opencv/build-image.sh "tensorflow113-opencv3:1"
      fi
      cd "$PROJECTDIR"
      docker run --rm -it -v $PWD:/code --entrypoint "make" tensorflow113-opencv3:1 -C /code/machine-learning/tensorflow/custom-ops "$1"
  else
		echo "usage: sh run-docker.sh heatmap_test | heatmap_pip_pkg | heatmap_pkg_test"
	fi
}

main "$@"