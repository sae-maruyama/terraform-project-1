# modules/network/main.tf

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-internet-gw"
  }
}

# Web Subnet (Public)
resource "aws_subnet" "web" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidrs.web
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-web-subnet-01"
  }
}

# API Subnet (Private)
resource "aws_subnet" "api" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs.api
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.name_prefix}-api-subnet-01"
  }
}

# DB Subnet (Private)
resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs.db
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.name_prefix}-db-subnet-01"
  }
}

# ELB Subnet 1 (Public)
resource "aws_subnet" "elb_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidrs.elb_1
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-elb-subnet-01"
  }
}

# ELB Subnet 2 (Public)
resource "aws_subnet" "elb_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidrs.elb_2
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-elb-subnet-02"
  }
}

# DB Subnet 2 (Private) - RDS用
resource "aws_subnet" "db_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs.db_2
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.name_prefix}-db-subnet-02"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.web.id

  tags = {
    Name = "${var.name_prefix}-nat-gw"
  }

  depends_on = [aws_internet_gateway.main]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.name_prefix}-public-rt"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.name_prefix}-private-rt"
  }
}

# Route Table Associations - Public
resource "aws_route_table_association" "web" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "elb_1" {
  subnet_id      = aws_subnet.elb_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "elb_2" {
  subnet_id      = aws_subnet.elb_2.id
  route_table_id = aws_route_table.public.id
}

# Route Table Associations - Private
resource "aws_route_table_association" "api" {
  subnet_id      = aws_subnet.api.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db" {
  subnet_id      = aws_subnet.db.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db_2" {
  subnet_id      = aws_subnet.db_2.id
  route_table_id = aws_route_table.private.id
}
