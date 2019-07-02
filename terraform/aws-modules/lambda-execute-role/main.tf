resource "aws_iam_role" "iam_role_for_lambda" {
  name = "${var.aws_iam_role_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "lambda_logging" {
  name = "${var.aws_iam_role_policy_name}"
  role = "${aws_iam_role.iam_role_for_lambda.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/lambda/${var.lambda_name}",
        "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/lambda/${var.lambda_name}:log-stream:*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}
