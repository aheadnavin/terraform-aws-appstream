resource "aws_dynamodb_table" "ip" {
  name         = "${var.app_name}_ip"
  hash_key     = "ip_address"
  billing_mode = "PAY_PER_REQUEST"
  /* read_capacity  = 20
  write_capacity = 20
  range_key      = "GameTitle" */

  attribute {
    name = "ip_address"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.db_recovery
  }
}

resource "aws_dynamodb_table" "email" {
  name         = "${var.app_name}_email"
  hash_key     = "email"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "email"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.db_recovery
  }
}