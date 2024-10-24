# Provides a security group 
resource "aws_security_group" "main_sg" {
    name = var.main_sg_name 
    description = var.main_sg_description
    vpc_id = aws_vpc.eks_vpc.id 

    ingress  {
        description = "ssh access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress  {
        description = "Kubernetes API access"
        from_port = 443
        to_port = 443 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1 
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.tags_main_sg_eks
    }
}