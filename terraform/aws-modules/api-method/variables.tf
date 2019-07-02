variable "rest_api_id" {
  description = "The ID of the associated REST API."
}
variable "resource_id" {
  description = "The API resource ID."
}
variable "method" {
  description = "The HTTP method."
}
variable "api_key_required" {
  description = "The key required flag."
}
variable "path" {
  description = "The API resource path."
}
variable "statement_id" {
  description = "A unique statement identifier."
}
variable "lambda" {
  description = "The lambda name to invoke."
}
variable "region" {
  description = "The AWS region, e.g., us-east-1."
}
variable "account_id" {
  description = "The AWS account ID."
}
variable "content_type" {
  description = "The response content type, e.g., application/json."
  default     = "application/json"
}
variable "request_mapping" {
  description = "A mapping value to the integration's request templates content_type."
}
variable "passthrough_behavior" {
  description = "The integration passthrough behavior."
  default = "WHEN_NO_TEMPLATES"
}
variable "integration_content_handing" {
  description = "Specifies how to handle request payload content type conversions."
}
variable "response_content_handling" {
  description = "Specifies how to handle request payload content type conversions."
}
