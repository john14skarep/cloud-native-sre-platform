resource "aws_vpc" "sre_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sre-vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.sre_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.sre_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "sre_igw" {
  vpc_id = aws_vpc.sre_vpc.id
}

resource "aws_route_table" "sre_route_table" {
  vpc_id = aws_vpc.sre_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sre_igw.id
  }
}

resource "aws_route_table_association" "subnet_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.sre_route_table.id
}

resource "aws_route_table_association" "subnet_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.sre_route_table.id
}

resource "aws_security_group" "ecs_sg" {
  name   = "ecs-security-group"
  vpc_id = aws_vpc.sre_vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "sre_cluster" {
  name = "sre-cluster"
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_lb" "sre_alb" {
  name               = "sre-load-balancer"
  load_balancer_type = "application"
  subnets = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]

  security_groups = [aws_security_group.ecs_sg.id]
}

resource "aws_lb_target_group" "sre_target_group" {
  name        = "sre-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.sre_vpc.id
  target_type = "ip"
}

resource "aws_lb_listener" "sre_listener" {
  load_balancer_arn = aws_lb.sre_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sre_target_group.arn
  }
}

resource "aws_ecs_task_definition" "sre_task" {
  family                   = "sre-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${aws_ecr_repository.app_repo.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/sre-platform"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
resource "aws_ecs_service" "sre_service" {
  name            = "sre-service"
  cluster         = aws_ecs_cluster.sre_cluster.id
  task_definition = aws_ecs_task_definition.sre_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = [
      aws_subnet.public_subnet_a.id,
      aws_subnet.public_subnet_b.id
    ]

    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.sre_target_group.arn
    container_name   = "app"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.sre_listener]
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/sre-platform"
  retention_in_days = 7
}

