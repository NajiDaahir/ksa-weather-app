# ECS Cluster
resource "aws_ecs_cluster" "weather_app_cluster" {
  name = "weather-app-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "weather_app_task" {
  family                   = "weather-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "weather-app",
      image     = "${aws_ecr_repository.weather_app_repo.repository_url}:latest",
      essential = true,
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ],
      environment = [
        {
          name  = "WEATHER_API_KEY",
          value = "ssm:/weather/api_key"
        }
      ]
    }
  ])
}

# ECS Service
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
