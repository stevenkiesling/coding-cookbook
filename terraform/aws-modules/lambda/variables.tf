variable "name" {
  description = "The name of the lambda to create, which also defines (i) the archive name (.zip), (ii) the file name, and (iii) the function name"
}
variable "filename" {
  description = "The path to the file associated with this lambda."
}
variable "runtime" {
  description = "The runtime of the lambda to create"
  default     = "nodejs"
}
variable "handler" {
  description = "The handler name of the lambda (a function defined in your lambda)"
  default     = "handler"
}
variable "role" {
  description = "IAM role attached to the Lambda Function (ARN)"
}
variable "layers" {
  description = "The layers associated to the Lambda Function (ARN)"
}
variable "timeout" {
  description = "The function execution time at which Lambda should terminate the function."
  default = 3
}
variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  default = 128
}

