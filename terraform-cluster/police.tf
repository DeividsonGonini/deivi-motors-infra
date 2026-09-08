# Police para IAM Utilização de Secret Manager
resource "aws_iam_policy" "external_secrets_sm_policy" {
  name = "external-secrets-secretsmanager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets",
          "secretsmanager:BatchGetSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}

# Anexe essa policy à role Secret Manager
resource "aws_iam_role_policy_attachment" "external_secrets_attach" {
  role       = aws_iam_role.external_secrets.name
  policy_arn = aws_iam_policy.external_secrets_sm_policy.arn
}