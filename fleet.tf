resource "aws_appstream_fleet" "fleet" {
  name = var.app_name

  compute_capacity {
    desired_instances = var.compute_capacity
  }

  description                        = var.app_description
  idle_disconnect_timeout_in_seconds = var.idle_disconnect
  display_name                       = var.app_name
  enable_default_internet_access     = var.enable_internet
  fleet_type                         = var.fleet_type
  image_name                         = var.image_name
  instance_type                      = var.instance_type
  max_user_duration_in_seconds       = var.max_user_duration
  stream_view                        = var.stream_view


  vpc_config {
    subnet_ids         = var.fleet_subnets
    security_group_ids = var.fleet_security_groups
  }
}

resource "aws_appstream_fleet_stack_association" "stack_fleet" {
  fleet_name = aws_appstream_fleet.fleet.name
  stack_name = aws_appstream_stack.stack.name
}
