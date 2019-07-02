# Edge Detector API
Performs Canny edge detection on a image.

## Introduction
Using a simple Canny edge detector algorithm we can demonstrate the following AWS features:
* Custom Lambda Runtime(C++)
* Lambda Layers(supporting C/C++ libraries)
* Protobuffer media type
* Binary-to-text integration request content handling
* Text-to-binary integration response content handling
* Terraform Deployment

## Usage
The edge detector api is built, deployed, and tested inside a docker container.
### Packaging:
The following command will build and package the lambda function and supporting layer:
```
sh run-docker.sh package
```
### Deploying:
The following command will deploy the api gateway, lambda layer, and lambda using Terraform modules:
```
sh run-docker.sh deploy
```
### Testing:
The following command will build and run a simple http client to test the deployed api:
```
sh run-docker.sh test
```
### Destroying:
The following command will destroy the terraform-managed AWS infrastructure previously deployed:
```
sh run-docker.sh destroy
```