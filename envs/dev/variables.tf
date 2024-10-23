variable "region" {
    description = "Region for resources"
    type = string 
    default = "us-east-1"
}

variable "aws_access_key_id" {
    type = string
    default = ""
}

variable "aws_secret_access_key" {
    type = string
    default = ""
}

variable "cluster_name" {
  description = "Name for the EKS cluster"
  type = string
  default = "dev-eks-cluster"
}

variable "node_group_name" {
    description = "Name of the EKS cluster node group"
    type = string
    default = "dev-eks-node-group"
}
# name = var.eks_node_group_role_name
variable "eks_cluster_role_name" {
    description = "Name for the EKS cluster IAM role"
    type = string 
    default = "dev-role-eks-cluster-role-name"
}

variable "eks_node_group_role_name" {
    description = "Name for the EKS cluster node group IAM role"
    type = string 
    default = "dev-eks-node-group-role-name"
}

variable "eks_node_group_profile" {
    description = "Name for Instance Profile for EKS node group"
    type = string 
    default = "dev-eks-node-group-profile"
}

variable "eks_node_group_volume_policy_name" {
    description = "Name for EKS node group volume policy"
    type = string  
    default = "dev-eks-node-group-volume-policy-name"
}

variable "cloudwatch_role_name" {
    description = "Name for CloudWatch IAM role"
    type = string
    default = "dev-cloudwatch-role-name"
}

variable "eks_cluster_autoscaler_role_name" {
    description = "Name for EKS Cluster autoscaler IAM role"
    type = string 
    default = "dev-eks-cluster-autoscaler-role-name"
}

variable "eks_cluster_autoscaler_policy_name" {
    description = "Name for EKS Cluster autoscaler IAM policy"
    type = string 
    default = "dev-eks-cluster-autoscaler-policy-name"
}

variable "log_group_name" {
    description = "Name for EKS Cluster log group"
    type = string 
    default = "/aws/eks/cluster-logs-dev"
}

# variable "retention_in_days" {
#     description = "Rentention days for the EKS Cluster log group"
#     type = number
#     default = 30
# }

variable "alarm_topic_name" {
    description = "SNS Topic name for CloudWatch"
    type = string 
    default = "dev-high-cpu-alarm-topic"
}

variable "subscription_protocol" {
    description = "SNS Topic subscription protocol for CloudWatch"
    type = string 
    default = "email"
}

variable "subscription_endpoint" {
    description = "SNS Topic subscription endpoint for CloudWatch"
    type = string 
    default = "oloruntobiolurombi@gmail.com" # Change this 
}

variable "alarm_name" {
    description = "CloudWatch Metric Alarm Name"
    type = string 
    default = "dev-eks-high-cpu"
}

variable "main_sg_name" {
    description = "Security Group Name"
    type = string
    default = "dev-main-sg"
}

variable "main_sg_description" {
    description = "Security Group Description"
    type = string
    default = "This is the security group for EKS Cluster Dev"
}

variable "tags_main_sg_eks" {
    description = "Security Group tag"
    type = string 
    default = "dev-eks-sg"
}

variable "tags_igw" {
    description = "dev internet gateway tag"
    type = string 
    default = "dev-eks-igw"
}

variable "tags_public_rt" {
    description = "dev public vpc route table tag"
    type = string 
    default = "dev-public-rt"
    
}

variable "tags_private_rt" {
  description = "Tag for public route table"
    type = string 
    default = "dev-private-rt"
}

variable "tags_nat" {
    description = "dev nat vpc route table tag"
    type = string 
    default = "dev-nat"
}

variable "tags_k8s-nat" {
    description = "dev nat gateway tag"
    type = string 
    default = "dev-k8s-nat"
}

# "10.1.0.0/16"
variable "eks_vpc_cidr" {
    description = "VPC for EKS Cluster cidr block"
    type = string 
    default = "10.0.0.0/16"
}

#"10.2.0.0/16"
variable "on_prem_vpc_cidr" {
    description = "VPC for On prem cidr block"
    type = string 
    default = "10.1.0.0/16"

}
#"10.1.1.0/24"
# variable "eks_public_subnets_cidr" {
#     description = "Cidr Block public Subnet for eks"
#     type = list(string) 
#     default = ["10.3.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
# }

#"10.1.2.0/24"
# variable "eks_private_subnets_cidr" {
#     description = "Cidr Block private Subnet for eks"
#     type = list(string)
#     default = ["10.3.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
# }

# 10.2.1.0/24
# variable "onprem_subnet_cidr" {
#     description = "Cidr Block Subnet for onprem"
#     type = string 
#     default = "10.2.1.0/24"
# }

variable "eks_vpc_tags" {
  type = string 
  default = "dev-eks-vpc"
}

variable "on_prem_vpc_tags" {
  default = "dev-onprem-vpc"
}