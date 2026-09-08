## VPC ##
output "aws_vpc-deivi-motors_id" {
  value = aws_vpc.vpc-deivi-motors.id
}

## Subnet ##
output "aws_subnet_deivi-motors-subnet-public2_id" {
  value = aws_subnet.deivi-motors-subnet-public2.id
}

output "aws_subnet_deivi-motors-subnet-private1_id" {
  value = aws_subnet.deivi-motors-subnet-private1.id
}

output "aws_subnet_deivi-motors-subnet-public1_id" {
  value = aws_subnet.deivi-motors-subnet-public1.id
}

output "aws_subnet_deivi-motors-subnet-private2_id" {
  value = aws_subnet.deivi-motors-subnet-private2.id
}


## Security Group ##
output "aws_security_group_sg-balancer-deivi-motors_id" {
  value = aws_security_group.sg-balancer-deivi-motors.id
}

output "aws_security_group_sg-cluster-deivi-motors_id" {
  value = aws_security_group.sg-cluster-deivi-motors.id
}

output "aws_secretsmanager_secret_name" {
  value = aws_secretsmanager_secret.secrets_db.name
}


############### Cognito ###############
output "cognito_userpool_id" {
  value = aws_cognito_user_pool.cognito.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.client.id
}


################################################

# ## DNS Name ##
# output "alb_dns_name" {
#   description = "DNS público do Network Load Balancer"
#   value       = aws_lb.alb.dns_name
# }


## DNS Name ##
# output "api_gateway_id" {
#   description = "ID da API Gateway gerada"
#   value       = aws_apigatewayv2_api.api-gtw.id
# }

# output "api_gateway_invoke_url" {
#   description = "Endpoint base para invocar a API"
#   value       = "https://${aws_apigatewayv2_api.api-gtw.id}.execute-api.${var.region}.amazonaws.com/${aws_apigatewayv2_stage.prod.name}"
# }