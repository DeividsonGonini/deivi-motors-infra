resource "aws_eks_cluster" "cluster" {
  name = "eks-${var.projectName}"
  role_arn = aws_iam_role.eks_node_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.deivi-motors-subnet-public1.id,
      aws_subnet.deivi-motors-subnet-public2.id
    ]

    security_group_ids = [aws_security_group.sg-cluster-deivi-motors.id]
  }

  # Declara dependencia da criação da IAM Role Police antes de criar o cluster
  depends_on = [
    aws_iam_role.eks_node_role,
    aws_iam_role.eks_cluster_role,
    aws_subnet.deivi-motors-subnet-public1,
    aws_subnet.deivi-motors-subnet-public2,
    aws_security_group.sg-cluster-deivi-motors
  ]
}


# IAM OIDC provider do EKS
resource "aws_iam_openid_connect_provider" "oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0afd10c16"]
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

# Instalar o Helm chart do Load Balancer Controller
resource "helm_release" "aws_lb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version = "1.7.1"

  # Aumenta o tempo máximo de instalação para 10 minutos
  timeout = 660

  values = [
    yamlencode({
      clusterName = aws_eks_cluster.cluster.name
      region      = var.region
      serviceAccount = {
        create = false
        name   = kubernetes_service_account.aws_lb_controller.metadata[0].name
      }
    })
  ]

  depends_on = [
    kubernetes_service_account.aws_lb_controller
  ]

  set {
    name  = "clusterName"
    value = aws_eks_cluster.cluster.name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = aws_vpc.vpc-deivi-motors.id
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_lb_controller.metadata[0].name
  }
}


#Instala o CRDs e External Secrets para o Cluster pegar os dados de Secret Manager
resource "helm_release" "external_secrets" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "external-secrets-sa"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_secrets.arn
  }

  depends_on = [
    aws_eks_cluster.cluster,
    aws_iam_openid_connect_provider.oidc,
    helm_release.aws_lb_controller
  ]
}


resource "aws_iam_role" "external_secrets" {
  name               = "external-secrets-irsa"
  assume_role_policy = jsonencode(local.assume_role_policy_external_secrets)
}
