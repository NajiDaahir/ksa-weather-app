
resource "aws_ecs_cluster" "weather_app_cluster" {
  name = "weather-app-cluster"
}

resource "aws_ecs_task_definition" "weather_app_task" {
  family                   = "weather-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "weather-app",
      image     = "${aws_ecr_repository.weather_app_repo.repository_url}:1.1",
      essential = true,
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ],
      secrets = [
        {
          name      = "WEATHER_API_KEY",
          valueFrom = data.aws_ssm_parameter.weather_api_key.arn
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/weather-app"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}


# ECS Service with public subnet configuration
resource "aws_ecs_service" "weather_app_service" {
  name            = "weather-app-service"
  cluster         = aws_ecs_cluster.weather_app_cluster.id
  task_definition = aws_ecs_task_definition.weather_app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet.id]
    security_groups  = [aws_security_group.weather_app_sg.id]
    assign_public_ip = true 
  }
}