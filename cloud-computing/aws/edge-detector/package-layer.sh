#!/bin/sh
set -e

SHARED_LIBS_FOLDER=/code/cloud-computing/aws/edge-detector/deploy/edge_detector_layer
LAYER_ZIP=edge_detector_layer.zip
PKG_BIN_PATH=./edge_detector
if [ ! -d "deploy" ]; then
  mkdir deploy
fi
cd deploy
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib64"
if [ -d "$SHARED_LIBS_FOLDER" ]; then
    rm -rf "$SHARED_LIBS_FOLDER"
fi
if [ -f "$LAYER_ZIP" ]; then
    rm "$LAYER_ZIP"
fi
mkdir -p "$SHARED_LIBS_FOLDER"/lib
list=$(ldd "$PKG_BIN_PATH" | awk '{print $(NF-1)}')
for i in $list
  do
    filename=$(basename "$i")
    if [[ -z "${filename##ld-*}" ]]; then
        cp "$i" "$SHARED_LIBS_FOLDER"
    else
        cp "$i" "$SHARED_LIBS_FOLDER/lib"
    fi
  done
CWD=$PWD
cd "$SHARED_LIBS_FOLDER"
zip --symlinks --recurse-paths "$LAYER_ZIP" -- *
mv "$LAYER_ZIP" "$CWD"
cd "$CWD"
rm -r "$SHARED_LIBS_FOLDER"
