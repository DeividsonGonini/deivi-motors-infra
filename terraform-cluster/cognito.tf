# Cognito User Pool
resource "aws_cognito_user_pool" "cognito" {
  name = "backend-app-user-pool"

  # Login utilizando email
  username_attributes = ["email"]

  # Verificação automática do email
  auto_verified_attributes = ["email"]

  # CPF como atributo customizado
  schema {
    name                = "cpf"
    attribute_data_type = "String"
    required            = false # custom attributes não podem ser required
    mutable             = false
    string_attribute_constraints {
      min_length = 11
      max_length = 11
    }
  }
  
  # Política de senha
  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
  }

  # Cadastro feito pelo próprio usuário
  # Desabilita fluxo de usuário criado por admin (convite/senha temporária)
  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  # Configura signup direto (sem convite)
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

# User Pool Client
resource "aws_cognito_user_pool_client" "client" {
  name         = "backend-app-client"
  user_pool_id = aws_cognito_user_pool.cognito.id

  generate_secret     = false
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH"]
}