terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
terraform {
  backend "s3" {
    bucket = "turion-dev" # change this
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true 
  }
}

provider "aws" {
    region = var.region 
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}



module "eks_cluster" {
  source = "../../eks-modules/eks"

  region = var.region
  cluster_name = var.cluster_name
  node_group_name = var.node_group_name
  eks_cluster_role_name = var.eks_cluster_role_name
  eks_node_group_role_name = var.eks_node_group_role_name
  eks_node_group_profile = var.eks_node_group_profile
  eks_node_group_volume_policy_name = var.eks_node_group_volume_policy_name 
  cloudwatch_role_name = var.cloudwatch_role_name
  eks_cluster_autoscaler_role_name = var.eks_cluster_autoscaler_role_name
  eks_cluster_autoscaler_policy_name = var.eks_cluster_autoscaler_policy_name 
  log_group_name = var.log_group_name
  alarm_topic_name = var.alarm_topic_name 
  subscription_protocol = var.subscription_protocol
  subscription_endpoint = var.subscription_endpoint
  alarm_name = var.alarm_name
  main_sg_name = var.main_sg_name
  main_sg_description = var.main_sg_description
  tags_main_sg_eks = var.tags_main_sg_eks 
  tags_igw = var.tags_igw 
  tags_public_rt = var.tags_public_rt 
  tags_private_rt = var.tags_private_rt
  tags_nat = var.tags_nat 
  tags_k8s-nat = var. tags_k8s-nat
  eks_vpc_cidr = var.eks_vpc_cidr 
  on_prem_vpc_cidr = var.on_prem_vpc_cidr 
  on_prem_vpc_tags = var.on_prem_vpc_tags
  eks_vpc_tags = var.eks_vpc_tags
}

