# KSA Weather Aggregator 🌤️🇸🇦

A simple app to display weather data for key cities in Saudi Arabia. Built with AWS, Terraform, Docker, and GitHub Actions for automated deployment on AWS ECS.

## Project Overview

This app retrieves and displays weather data from WeatherAPI for select cities in Saudi Arabia. The setup is containerized and deployed to AWS ECS Fargate using a CI/CD pipeline.

---

## Technologies Used

- **AWS**: ECS, ECR, SSM Parameter Store, CloudWatch
- **Terraform**: Infrastructure as Code
- **Python**: Flask web app
- **Docker**: Containerization
- **GitHub Actions**: CI/CD

---

## Setup Instructions

### Prerequisites
- **AWS Account** with permissions for ECS, ECR, and SSM
- **Terraform**, **Docker**, and **Python** installed locally

### Steps

1. **Clone the Repository**:
   git clone https://github.com/NajiDaahir/ksa-weather-app
   cd ksa-weather-app

2. Configure Terraform:
terraform init

3. Deploy Infrastructure:
terraform apply


After these steps, the CI/CD pipeline will handle building and deploying the Docker image, so there’s no need to manually log in to ECR or push the image.
