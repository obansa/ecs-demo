resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "app" {
  family = "app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu       = "256"
  memory    = "512"
  container_definitions = jsonencode([
    {
      name      = "my-app"
      image     = "obansa/my-ecs-demo-image:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort = 8000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "name" {
  name = "web-server"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count = 3
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.subnets
    assign_public_ip = true
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = var.lb_tg_arn
    container_name = "my-app"
    container_port = 8000  
  }

  depends_on = [ var.lb_listener_arn]
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
