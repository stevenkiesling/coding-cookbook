resource "aws_api_gateway_method" "request_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${var.resource_id}"
  http_method   = "${var.method}"
  authorization = "NONE"
  api_key_required = "${var.api_key_required}"
}
resource "aws_api_gateway_integration" "request_method_integration" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.request_method.http_method}"
  type        = "AWS"
  uri         = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${var.lambda}/invocations"
  integration_http_method = "POST"
  content_handling        = "${var.integration_content_handing}"
  passthrough_behavior = "${var.passthrough_behavior}"
  request_templates = {
    "${var.content_type}" = "${var.request_mapping}"
  }
  depends_on  = ["aws_api_gateway_method.request_method"]
}
resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "${var.statement_id}"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.rest_api_id}/*/${aws_api_gateway_method.request_method.http_method}${var.path}"
  depends_on = ["aws_api_gateway_integration.request_method_integration"]
}
resource "aws_api_gateway_integration_response" "response_method_integration" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_integration.request_method_integration.http_method}"
  status_code = "200"
  content_handling = "${var.response_content_handling}"
  depends_on  = ["aws_lambda_permission.allow_api_gateway"]
}
resource "aws_api_gateway_method_response" "response_method" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_integration.request_method_integration.http_method}"
  status_code = "200"
  response_models = {
    "${var.content_type}" = "Empty"
  }
  depends_on  = ["aws_api_gateway_integration_response.response_method_integration"]
}
