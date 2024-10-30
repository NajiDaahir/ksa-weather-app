output "ecr_repository_url" {
  value = aws_ecr_repository.weather_app_repo.repository_url
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.weather_app_cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.weather_app_service.name
}
