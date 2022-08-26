variable vpc_id {
  type        = string
  default     = "vpc-0a1bb81f8459ae124"
}

data "aws_vpc" "default" {
  id = var.vpc_id
}