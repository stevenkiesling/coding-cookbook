resource "aws_lambda_layer_version" "lambda_layer" {
    filename            = "${var.filename}"
    layer_name          = "${var.layer_name}"
    compatible_runtimes = "${var.compatible_runtimes}"
    source_code_hash    = "${base64sha256(filebase64("${var.filename}"))}"
}
