module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = true
  version = "9.16.0"
  name    = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backend-alb
  vpc_id  = local.vpc_id
  subnets = local.private_subnet_ids
  create_security_group = false
  security_groups = [local.security_groups]
  enable_deletion_protection = false
  tags = merge(local.common_tags,
  {
    Name = "${var.project}-${var.environment}-backend-alb"
  }
  )

}


resource "aws_lb_listener" "back_end" {
  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from backend ALB</h1>"
      status_code  = "200"
    }
  }
}