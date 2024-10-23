variable "region" {}

variable "cluster_name" {
  description = "Name for the EKS cluster"
  type = string
}

variable "node_group_name" {
    description = "Name of the EKS cluster node group"
    type = string
}

variable "eks_cluster_role_name" {
    description = "EKS Cluster IAM role"
    type = string 
}

variable "eks_node_group_role_name" {
    description = "EKS Node Group Role Name"
    type = string 
}

variable "eks_node_group_profile" {
    description = "EKS Node Group Profile"
    type = string
}

variable "eks_node_group_volume_policy_name" {
    description = "Policy name for eks node group volume "
    type = string 
}


variable "cloudwatch_role_name"{
    description = "CloudWatch IAM Role name"
    type = string 
}

variable "eks_cluster_autoscaler_role_name" {
    description = "EKS Cluster Autoscaler IAM role name"
    type = string 
}

variable "eks_cluster_autoscaler_policy_name" {
    description = "EKS Cluster Autoscaler IAM policy name"
    type = string 
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type = string 
}

variable "retention_in_days" {
  description = "Number of days to retain CloudWatch logs"
  type = number 
  default = 30
}

variable "alarm_topic_name" {
  description = "The name of the SNS topic for alarms"
  type = string 
}

variable "subscription_protocol" {
  description = "The protocol for SNS subscription"
  type = string 
  default = "email"
}

variable "subscription_endpoint" {
  description = "The email address or endpoint to send notifications to"
  type = string 
}

variable "alarm_name" {
  description = "The name of the CloudWatch alarm"
  type = string 
}

variable "evalation_periods" {
  description = "The number of periods over which data is compared to the thresholds"
  type = number 
  default = 2
}


variable "period" {
  description = "The period in seconds to monitor the metric"
  type = number 
  default = 60 
}

variable "statistic" {
  description = "The statistics to apply to the metric"
  type = string
  default = "Average"
}

variable "threshold" {
  description = "The value the metric must exceed to trigger the alarm"
  type = number 
  default = 80
}

variable "tags_igw" {
    description = "Tag for Internet Gateway"
    type = string
}

variable "tags_public_rt" {
    description = "Tag for public route table"
    type = string 
}

variable "tags_private_rt" {
  description = "Tag for public route table"
    type = string 
}

variable "tags_nat" {
    description = "Tag for NAT Gateway"
    type = string
}

variable "tags_k8s-nat" {}

variable "main_sg_name" {
    description = "Security group name"
    type = string 
}

variable "main_sg_description" {
    description = "Security group description"
    type = string 
}

variable "tags_main_sg_eks" {
    description = "Tag Security Group EK8"
    type = string 
}

# "10.1.0.0/16"
variable "eks_vpc_cidr" {
    description = "VPC for EKS Cluster cidr block"
    type = string 
}

#"10.2.0.0/16"
variable "on_prem_vpc_cidr" {
    description = "VPC for On prem cidr block"
    type = string 
}
#"10.1.1.0/24"
# variable "eks_public_subnets_cidr" {
#     description = "Cidr Block public Subnet for eks"
#     type = list(string) 
# }

#"10.1.2.0/24"
# variable "eks_private_subnets_cidr" {
#     description = "Cidr Block private Subnet for eks"
#     type = list(string) 
# }

# 10.2.1.0/24
# variable "onprem_subnet_cidr" {
#     description = "Cidr Block Subnet for onprem"
#     type = string 
# }

variable "eks_vpc_tags" {
  
}

variable "on_prem_vpc_tags" {
  
}