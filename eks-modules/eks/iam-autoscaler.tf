data "aws_iam_policy_document" "eks_cluster_autoscaler_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}


resource "aws_iam_role" "eks_cluster_autoscaler_role" {
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_autoscaler_assume_role_policy.json
  name               = var.eks_cluster_autoscaler_role_name
}

resource "aws_iam_policy" "eks_cluster_autoscaler_policy" {
  name = var.eks_cluster_autoscaler_policy_name

  policy = jsonencode({
    Statement = [{
      Action = [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_autoscaler_attach" {
  role       = aws_iam_role.eks_cluster_autoscaler_role.name
  policy_arn = aws_iam_policy.eks_cluster_autoscaler_policy.arn
}

# # Add Cluster Autoscaler Helm chart 
# resource "helm_release" "cluster_autoscaler" {
#   name       = "cluster-autoscaler"
#   chart      = "cluster-autoscaler"
#   repository = "https://kubernetes.github.io/autoscaler"
#   namespace  = "kube-system"

#   set {
#     name  = "awsRegion"
#     value = var.region
#   }

#   set {
#     name  = "autoDiscovery.clusterName"
#     value = aws_eks_cluster.eks_cluster.name
#   }

#   set {
#     name  = "rbac.serviceAccount.create"
#     value = "true"
#   }

#   set {
#     name  = "extraArgs.scale-down-unneeded-time"
#     value = "10m"
#   }

#   set {
#     name  = "extraArgs.scale-down-delay-after-add"
#     value = "10m"
#   }

#   set {
#     name  = "extraArgs.expander"
#     value = "least-waste"
#   }

#   depends_on = [
#     aws_eks_cluster.eks_cluster,
#     aws_iam_role_policy_attachment.eks_cluster_autoscaler_attach,
#   ]
# }