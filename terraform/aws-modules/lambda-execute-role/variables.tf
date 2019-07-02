variable "aws_iam_role_name" {
  description = "The name of the role. If omitted, Terraform will assign a random, unique name."
}
variable "aws_iam_role_policy_name" {
  description = "The name of the role policy. If omitted, Terraform will assign a random, unique name."
}
variable "region" {
  description = "The AWS region, e.g., us-east-1"
}
variable "account_id" {
  description = "The AWS account ID"
}
variable "lambda_name" {
  description = "The lambda resource which will have cloud watch permissions."
}
