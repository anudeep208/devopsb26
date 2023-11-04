resource "aws_vpc" "default" {
  cidr_block           = "10.5.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name        = "Terraform-vpc"
    Owner       = "Anudeep Bodla"
    environment = "PROD"
  }
}
resource "aws_subnet" "subnet1-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.5.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraformpublic-1"
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.5.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Terraformpublic-2"
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.5.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "Terraformpublic-3"
  }

}
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "Terraform-IGW"
  }
}
resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "Terraform-RT"
  }
}

resource "aws_route_table_association" "terraform-public" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terraform-public.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "s3" {
  bucket = "cloudvision.social"
  tags = {
    Name = "devops"
  }
  depends_on = [aws_route_table_association.terraform-public]
}