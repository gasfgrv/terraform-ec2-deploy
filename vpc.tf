
resource "aws_vpc" "terraform_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "Terraform vpc"
  }
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Terraform subnet"
  }
}

resource "aws_internet_gateway" "terraform_internet_gateway" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    "Name" = "Terraform intenet gateway"
  }
}

resource "aws_route_table" "terraform_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    "Name" = "Terraform Route Table"
  }
}

resource "aws_route" "terraform_route" {
  route_table_id         = aws_route_table.terraform_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform_internet_gateway.id
}

resource "aws_route_table_association" "terraform_route_table_association" {
  route_table_id = aws_route_table.terraform_route_table.id
  subnet_id      = aws_subnet.terraform_subnet.id
}
