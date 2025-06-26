provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "rk_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name         = "rk-vpc"
    "Created By" = var.created_by
  }
}

resource "aws_internet_gateway" "rk-IGW" {
  vpc_id = aws_vpc.rk_vpc.id

  tags = {
    Name         = "rk-internet-gateway"
    "Created by" = var.created_by
  }
}

resource "aws_subnet" "rk-public-subnet" {
  vpc_id     = aws_vpc.rk_vpc.id
  cidr_block = "10.0.11.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name         = "rk-subnet-public"
    "Created by" = var.created_by
  }
}

resource "aws_subnet" "rk-private-subnet" {
  vpc_id     = aws_vpc.rk_vpc.id
  cidr_block = "10.0.22.0/24"

  tags = {
    Name         = "rk-subnet-private"
    "Created by" = var.created_by
  }
}

resource "aws_route_table" "rk-route-table" {
  vpc_id = aws_vpc.rk_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rk-IGW.id
  }

  tags = {
    Name         = "rk-route-table"
    "Created by" = var.created_by
  }

}

resource "aws_route_table_association" "rk-rt-assoc" {
  route_table_id = aws_route_table.rk-route-table.id
  subnet_id = aws_subnet.rk-public-subnet.id
}


resource "aws_security_group" "rk-sg" {
  name = "rk-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "rk-SG"
    "Created By" = var.created_by
  }

}


resource "aws_instance" "rk-instance" {
  ami                    = "ami-0f918f7e67a3323f0"
  instance_type          = "t2.micro"
  key_name               = "ec2-terraform"
  vpc_security_group_ids = [aws_security_group.rk-sg.id]

  tags = {
    Name         = "rk-instance"
    "Created By" = var.created_by
  }

}
