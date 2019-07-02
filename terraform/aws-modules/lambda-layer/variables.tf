variable "layer_name" {
  description = "A unique name for your Lambda Layer."
}
variable "compatible_runtimes" {
  description = "A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified."
}
variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
}
