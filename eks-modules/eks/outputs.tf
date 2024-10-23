# OutPut Resources
output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_name" {
    value = aws_eks_cluster.eks_cluster.name
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
  description = "The ARN of the IAM role for the EKS cluster"
}

output "eks_cluster_autoscaler_role_arn" {
  value = aws_iam_role.eks_cluster_autoscaler_role.arn
  description = "The ARN of the IAM role for the EKS cluster autoscaler"
}


output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.alarm_topic.arn
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.eks_log_group.name
}

output "eks_vpc_id" {
  value = aws_vpc.eks_vpc.id
  description = "The ID of the EKS VPC"
}

# output "eks_private_subnet_ids" {
#   value = aws_subnet.eks_private[*].id
#   description = "The IDs of the private subnets for EKS"
# }