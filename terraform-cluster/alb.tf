# IAM policy para o Load Balancer Controller
resource "aws_iam_policy" "aws_lb_controller" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = file("iam_policy.json") # baixado do repositório oficial
}

# IAM role para o ServiceAccount
resource "aws_iam_role" "aws_lb_controller_role" {
  name = "eks-aws-lb-controller-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }
  }
}

# ServiceAccount Kubernetes via Terraform
resource "kubernetes_service_account" "aws_lb_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_lb_controller_role.arn
    }
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
  }
  depends_on = [aws_iam_openid_connect_provider.oidc]
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller_attach" {
  role       = aws_iam_role.aws_lb_controller_role.name
  policy_arn = aws_iam_policy.aws_lb_controller.arn
}

#Role do Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}