resource "aws_cloudwatch_event_rule" "rule" {
  name                = "${var.app_name}_expirycheck"
  description         = "Check user expiry for ${var.app_name}."
  is_enabled          = true
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.rule.name
  target_id = "TriggerLambdaOnSchedule"
  arn       = aws_lambda_function.function.arn
}