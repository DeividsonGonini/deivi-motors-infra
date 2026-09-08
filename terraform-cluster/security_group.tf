resource "aws_security_group" "sg-balancer-deivi-motors" {
  description = "Security group do load balancer"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Tudo o que vai chegar no Security Group"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    # self        = "false"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Podera sair pela sua origem, como entrou pela 80 sai pela 80"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    # self        = "false"
  }

  name = "balancers-${var.projectName}-security-group"

  tags = {
    Name    = "balancers-${var.projectName}-security-group"
    project = var.projectName
  }

  tags_all = {
    Name    = "balancers-${var.projectName}-security-group"
    project = var.projectName
  }

  vpc_id = aws_vpc.vpc-deivi-motors.id #pega o id da VPC que iremos criar
}

resource "aws_security_group" "sg-cluster-deivi-motors" {
  description = "SG utilizado nos clusters"
  name        = "cluster-${var.projectName}-security-group"
  vpc_id      = aws_vpc.vpc-deivi-motors.id #pega o id da VPC que iremos criar

  ingress {
    description = "So permitiremos a entrada caso a origem seja do balancers security group"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 9090
    protocol    = "tcp" //HTTP
    self = "true"
  }


  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Podera sair pela sua origem"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = "true"
  }

  tags = {
    Name    = "cluster-${var.projectName}-security-group"
    project = var.projectName
  }

  tags_all = {
    Name    = "cluster-${var.projectName}-security-group"
    project = var.projectName
  }
}
