
resource "aws_lb" "main_alb" {
  name = "main-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = var.subnets
  enable_deletion_protection = false

  tags = {
    Name: "main_alb"
  }
}

resource "aws_security_group" "alb_sg" {
    name = "alb-sg"
    vpc_id = var.vpc_id
    tags = {
      Name: "alb_sg"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_lb_target_group" "main_tg" {
  name = "main-tg"
  port = 8000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  stickiness {
    type = "lb_cookie"
    enabled = true
  }
}

resource "aws_lb_listener" "main_listener" {
  load_balancer_arn = aws_lb.main_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main_tg.arn
  }
}