#!/bin/sh
set -e

package() {
  if [ -d "deploy" ]; then
    rm -rf deploy
  fi
  mkdir deploy
  make BIN_NAME=edge_detector
  sh package-bin.sh
  sh package-layer.sh
}

deploy() {
  cd terraform
  terraform init -input=false
  terraform plan -input=false
  terraform apply -input=false -auto-approve
}

test() {
  cd terraform
  ARGS=$(terraform output --json | jq '. | "\(.url.value)\(.res_path.value) \(.api_key.value)"' | sed 's/"//g')
  cd ../
  make -C "$PWD/aws-tester"
  IMAGE_PATH="$PWD/aws-tester/earth.jpeg"
  EDGE_IMAGE_PATH="$PWD/aws-tester/edge.jpeg"
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
  ./aws-tester/aws-tester $ARGS $IMAGE_PATH $EDGE_IMAGE_PATH
}

cd $(dirname "$0")
if [ $1 = "package" ]; then
  package
elif [ $1 = "deploy" ]; then
  deploy
elif [ $1 = "test" ]; then
  test
elif [ $1 = "destroy" ]; then
  cd terraform
  terraform destroy -force
else
  echo "package, deploy, test, or destroy are the only acceptable arguments."
fi
