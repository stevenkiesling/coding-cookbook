output "url" {
  value = "${aws_api_gateway_deployment.EdgeDetectorDeployment.invoke_url}"
}
output "api_id" {
  value = "${aws_api_gateway_rest_api.api.id}"
}
output "resource_id" {
  value = "${aws_api_gateway_resource.resource.id}"
}
output "res_path" {
  value = "${aws_api_gateway_resource.resource.path}"
}
output "api_key" {
  value = "${module.api_usage.apikey}"
}
