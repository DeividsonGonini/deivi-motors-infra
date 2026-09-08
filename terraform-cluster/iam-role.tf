### Roles para node

resource "aws_iam_role" "eks_node_role" {
  name               = "${var.projectName}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    Name = "${var.projectName}-eks-node-role"
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSServicePolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_CloudWatchAgentServerPolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy_document" "document_eks_node__additional_access" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecrets"
    ]
    resources = [aws_secretsmanager_secret.secrets_db.arn]
    # resources = [data.aws_secretsmanager_secret.data_base_secrets.arn]
  }
}

resource "aws_iam_role_policy" "eks_node_additional_policy" {
  name   = "${var.projectName}-eks_node_-additional-policy"
  role   = aws_iam_role.eks_node_role.id
  policy = data.aws_iam_policy_document.document_eks_node__additional_access.json
}

# Police para Cluster acessar o S3
data "aws_iam_policy_document" "document_eks_node_s3_full_access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "*"
    ]
  }
}

# Role para Cluster acessar o S3
resource "aws_iam_role_policy" "eks_node_s3_full_access_policy" {
  name   = "${var.projectName}-eks-node-s3-full-access"
  role   = aws_iam_role.eks_node_role.id
  policy = data.aws_iam_policy_document.document_eks_node_s3_full_access.json
}