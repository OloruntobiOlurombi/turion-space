# Provides a VPC resource
resource "aws_vpc" "eks_vpc" {
  cidr_block       = var.eks_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.eks_vpc_tags
  }
}

resource "aws_vpc" "on_prem_vpc" {
    cidr_block = var.on_prem_vpc_cidr

    tags = {
    Name = var.on_prem_vpc_tags
  }
}

# Provides an VPC Public subnet resource
resource "aws_subnet" "eks_public_1" {
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.1.0/24" # var.eks_public_subnets_cidr_1
  map_public_ip_on_launch = true 
  availability_zone = "us-east-1a" #var.availability_zones
}

resource "aws_subnet" "eks_public_2" {
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.2.0/24" #var.eks_public_subnets_cidr_2
  map_public_ip_on_launch = true 
  availability_zone = "us-east-1b" # var.availability_zones
}

resource "aws_subnet" "eks_public_3" {
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.3.0/24" #var.eks_public_subnets_cidr_3
  map_public_ip_on_launch = true 
  availability_zone = "us-east-1c" #var.availability_zones
}

resource "aws_subnet" "eks_private_1" {
    vpc_id = aws_vpc.eks_vpc.id 
    cidr_block = "10.0.4.0/24" # var.eks_private_subnets_cidr_1
    availability_zone = "us-east-1a" # var.availability_zones
}

resource "aws_subnet" "eks_private_2" {
    vpc_id = aws_vpc.eks_vpc.id 
    cidr_block = "10.0.5.0/24" # var.eks_private_subnets_cidr_2
    availability_zone = "us-east-1b" #var.availability_zones
}

resource "aws_subnet" "eks_private_3" {
    vpc_id = aws_vpc.eks_vpc.id 
    cidr_block = "10.0.6.0/24" #var.eks_private_subnets_cidr_3
    availability_zone = "us-east-1c" # var.availability_zones
}

resource "aws_subnet" "onprem_subnet" {
  vpc_id = aws_vpc.on_prem_vpc.id
  cidr_block = "10.1.1.0/24" #var.onprem_subnet_cidr
  availability_zone = "us-east-1a" # element(var.availability_zones, count.index)
}