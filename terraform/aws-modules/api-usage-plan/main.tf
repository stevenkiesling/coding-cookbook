resource "aws_api_gateway_usage_plan" "usage_plan" {
  name = "${var.usage_plan_name}"
  api_stages {
    api_id = "${var.api_id}"
    stage  = "${var.stage_name}"
  }
  quota_settings {
    limit  = "${var.quota_settings_limit}"
    offset = "${var.quota_settings_offset}"
    period = "${var.quota_settings_period}"
  }
  throttle_settings {
    burst_limit = "${var.throttle_settings_burst_limit}"
    rate_limit  = "${var.throttle_settings_rate_limit}"
  }
}
resource "aws_api_gateway_api_key" "apikey" {
  name          = "${var.key_name}"
  count         = "${var.create_key ? 1 : 0}"
}
resource "aws_api_gateway_usage_plan_key" "main" {
  count         = "${var.create_key ? 1 : 0}"
  key_id        = "${aws_api_gateway_api_key.apikey[0].id}"
  key_type      = "${var.key_type}"
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"
}