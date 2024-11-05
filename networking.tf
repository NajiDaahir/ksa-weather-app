resource "aws_vpc" "weather_app_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.weather_app_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true 
}

resource "aws_security_group" "weather_app_sg" {
  vpc_id = aws_vpc.weather_app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.weather_app_vpc.id

  tags = {
    Name = "weather-app-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.weather_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id  
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id

}