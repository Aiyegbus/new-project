resource "aws_alb" "pro_lb" {
  name               = "Projec-Load-balancer"
  internal           = false
  security_groups    = [aws_security_group.pro_sg.id]
  subnets            = aws_subnet.pro_sub.*.id
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "pro_lb_target" {
  name        = "Load-balancer-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.pro_vpc.id
  target_type = "ip"

  health_check {
    path                = "/health_check"
    interval            = "30"
    timeout             = "3"
    matcher             = "200"
    healthy_threshold   = "3"
    protocol            = "HTTP"
    unhealthy_threshold = "2"
  }
}

resource "aws_lb_listener" "pro_lb_listener" {
  load_balancer_arn = aws_alb.pro_lb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pro_lb_target.id
  }
}
