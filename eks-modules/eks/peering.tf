resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id = aws_vpc.eks_vpc.id
  peer_vpc_id = aws_vpc.on_prem_vpc.id
  auto_accept = true
}

resource "aws_route" "eks_to_on_prem" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "10.1.2.0/24"  #var.on_prem_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  depends_on = [aws_route_table.private_rt]
}

resource "aws_route" "on_prem_to_eks" {
    route_table_id = aws_route_table.private_rt.id
    destination_cidr_block = "10.1.7.0/24" #var.eks_vpc_cidr 
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
    depends_on = [aws_route_table.private_rt]
}
