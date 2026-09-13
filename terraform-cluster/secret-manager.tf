resource "aws_secretsmanager_secret" "secrets_db" {
  name        = "deivi-motors/databaseprojects-1"
  description = "Configurações banco de dados dos serviços de deivi-motors"

  tags = {
    app = "secret-${var.projectName}"
    env = "prod"
  }
}

resource "aws_secretsmanager_secret_version" "deivi_motors_db" {
  secret_id = aws_secretsmanager_secret.secrets_db.id

  secret_string = jsonencode({
    MONGODB_USERNAME = var.deivi_motors_mongo_db_user
    MONGODB_PASSWORD = var.deivi_motors_mongo_db_password
  })

  lifecycle {
    create_before_destroy = true
  }
}