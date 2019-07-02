provider "aws" {
  region = "${var.aws_region}"
}
data "aws_caller_identity" "current" { }
module "lambda_layer" {
  source              = "../../../../terraform/aws-modules/lambda-layer"
  layer_name          = "edge_detector_layer"
  filename            = "../deploy/edge_detector_layer.zip"
  compatible_runtimes = ["provided"]
}
module "lambda" {
  source    = "../../../../terraform/aws-modules/lambda"
  name      = "edge_detector"
  filename  = "../deploy/edge_detector.zip"
  runtime   = "provided"
  layers    = ["${module.lambda_layer.arn}"]
  role      = "${module.iam_role_for_lambda.arn}"
}
module "iam_role_for_lambda" {
  source                    = "../../../../terraform/aws-modules/lambda-execute-role"
  aws_iam_role_name         = "edge_detector_execute_role"
  aws_iam_role_policy_name  = "edge_detector_execute_role_policy"
  region                    = "${var.aws_region}"
  account_id                = "${data.aws_caller_identity.current.account_id}"
  lambda_name               = "${module.lambda.name}"
}
resource "aws_api_gateway_rest_api" "api" {
  name                = "EdgeDetector"
  binary_media_types  = ["application/x-protobuf"]
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
resource "aws_api_gateway_resource" "resource" {
  path_part   = "detect-edges"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  depends_on  = ["aws_api_gateway_rest_api.api"]
}
module "api_method" {
  source                      = "../../../../terraform/aws-modules/api-method"
  rest_api_id                 = "${aws_api_gateway_rest_api.api.id}"
  resource_id                 = "${aws_api_gateway_resource.resource.id}"
  method                      = "POST"
  api_key_required            = true
  path                        = "${aws_api_gateway_resource.resource.path}"
  statement_id                = "EdgeDetectorPermission"
  lambda                      = "${module.lambda.name}"
  region                      = "${var.aws_region}"
  account_id                  = "${data.aws_caller_identity.current.account_id}"
  content_type                = "application/x-protobuf"
  request_mapping             = "\"$input.body\""
  passthrough_behavior        = "WHEN_NO_TEMPLATES"
  integration_content_handing = "CONVERT_TO_TEXT"
  response_content_handling   = "CONVERT_TO_BINARY"
}
resource "aws_api_gateway_deployment" "EdgeDetectorDeployment" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "test"
  depends_on  = ["module.api_method"]
}
module "api_usage" {
  source          = "../../../../terraform/aws-modules/api-usage-plan"
  api_id          = "${aws_api_gateway_rest_api.api.id}"
  usage_plan_name = "edge_detector_usage_plan"
  stage_name      = "${aws_api_gateway_deployment.EdgeDetectorDeployment.stage_name}"
  key_name        = "edge_detector_key"
}