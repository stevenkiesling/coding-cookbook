#!/bin/sh
set -e

BIN_FOLDER=/code/cloud-computing/aws/edge-detector/deploy/edge_detector_lambda
BIN_ZIP=edge_detector.zip
if [ ! -d "deploy" ]; then
  mkdir deploy
fi
cd deploy
if [ -d "$BIN_FOLDER" ]; then
    rm -rf "$BIN_FOLDER"
fi
if [ -f "$BIN_ZIP" ]; then
    rm "$BIN_ZIP"
fi
mkdir -p "$BIN_FOLDER/bin"
cp edge_detector "$BIN_FOLDER/bin"
cp ../src/bootstrap "$BIN_FOLDER"
chmod +x "$BIN_FOLDER/bootstrap"
CWD=$PWD
cd "$BIN_FOLDER"
zip --symlinks --recurse-paths "$BIN_ZIP" -- *
mv "$BIN_ZIP" "$CWD"
cd "$CWD"
rm -r "$BIN_FOLDER"
