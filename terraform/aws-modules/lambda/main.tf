resource "aws_lambda_function" "lambda" {
  filename              = "${var.filename}"
  function_name         = "${var.name}"
  role                  = "${var.role}"
  handler               = "${var.name}.${var.handler}"
  runtime               = "${var.runtime}"
  layers                = "${var.layers}"
  timeout               = "${var.timeout}"
  memory_size           = "${var.memory_size}"
  source_code_hash      = "${base64sha256(filebase64("${var.filename}"))}"
}
