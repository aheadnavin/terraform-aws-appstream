resource "aws_iam_role" "role" {
  name = "${var.app_name}_expiry"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AmazonAppStreamReadOnlyAccess"
  ]
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "LambdaAssumeRole"
        }
    ]
}
EOF
}

data "aws_s3_object" "function_sha256" {
  bucket = var.lambda_bucket
  key    = var.lambda_key_sha256
}

resource "aws_lambda_function" "function" {
  architectures    = ["arm64"]
  s3_bucket        = var.lambda_bucket
  s3_key           = var.lambda_key
  function_name    = "${var.app_name}_expiry"
  role             = aws_iam_role.role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = chomp(data.aws_s3_object.function_sha256.body)
  runtime          = "python3.9"
  timeout          = 120
  environment {
    variables = {
      CORS             = "*"
      AUTH_TYPE        = var.auth_type
      EXPIRED_USER_AGE = var.expired_user_age
    }
  }
}

resource "aws_lambda_permission" "allow_event" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule.arn
}
