locals {
  # oidc_provider = replace(
  #   data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer,
  #   "https://",
  #   ""
  # )

  assume_role_policy_external_secrets = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.oidc.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_provider}:sub" = "system:serviceaccount:external-secrets:external-secrets-sa"
            # "${local.oidc_provider}:sub" = "system:serviceaccount:external-secrets:external-secrets"
          }
        }
      }
    ]
  }
}

locals {
  oidc_provider = replace(
    aws_iam_openid_connect_provider.oidc.url,
    "https://",
    ""
  )
}

locals {
  oidc_issuer = replace(
    aws_iam_openid_connect_provider.oidc.url,
    "https://",
    ""
  )
}