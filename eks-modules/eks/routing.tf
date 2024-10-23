# Provides a resource to create a VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id 

  tags = {
    Name = var.tags_igw
  }
}

# Provides a resource to create a VPC routing table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_vpc.id 

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
        #carrier_gateway_id         = ""
        #destination_prefix_list_id = ""
        #egress_only_gateway_id     = ""
        #ipv6_cidr_block            = ""
        #local_gateway_id           = ""
        #network_interface_id       = ""
        #transit_gateway_id         = ""
        #vpc_endpoint_id            = ""
        #vpc_peering_connection_id  = ""
    }
  
  tags = {
    Name = var.tags_public_rt
  }
}


# Provides a resource to create a private route table 
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.eks_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.k8s-nat.id
        #carrier_gateway_id         = ""
        #destination_prefix_list_id = ""
        #egress_only_gateway_id     = ""
        #gateway_id                 = ""
        #ipv6_cidr_block            = ""
        #local_gateway_id           = ""
        #network_interface_id       = ""
        #transit_gateway_id         = ""
        #vpc_endpoint_id            = ""
        #vpc_peering_connection_id  = ""
    }

    tags = {
    Name = var.tags_private_rt
  }

}


# Provides a resource to create a NAT Gateway
resource "aws_eip" "nat" {
    domain = "vpc"
    tags = {
        Name = var.tags_nat
    }
}


resource "aws_nat_gateway" "k8s-nat" {
    allocation_id = aws_eip.nat.id 
    subnet_id = aws_subnet.eks_public_1.id
    tags = {
        Name = var.tags_k8s-nat
    }
    depends_on = [aws_internet_gateway.igw]
}


# Provides a resource to create an association between a route table and Public subnets
resource "aws_route_table_association" "public_subnet_association_1" {
    subnet_id = aws_subnet.eks_public_1.id
    route_table_id = aws_route_table.public_rt.id 
}

resource "aws_route_table_association" "public_subnet_association_2" {
    subnet_id = aws_subnet.eks_public_2.id
    route_table_id = aws_route_table.public_rt.id 
}

resource "aws_route_table_association" "public_subnet_association_3" {
    subnet_id = aws_subnet.eks_public_3.id
    route_table_id = aws_route_table.public_rt.id 
}

# Provides a resource to create an association between a route table and Private subnets
resource "aws_route_table_association" "private_subnet_association_1" {
    subnet_id = aws_subnet.eks_private_1.id
    route_table_id = aws_route_table.private_rt.id 
}

resource "aws_route_table_association" "private_subnet_association_2" {
    subnet_id = aws_subnet.eks_private_2.id
    route_table_id = aws_route_table.private_rt.id 
}

resource "aws_route_table_association" "private_subnet_association_3" {
    subnet_id = aws_subnet.eks_private_3.id
    route_table_id = aws_route_table.private_rt.id 
}
