# O Terraform é inteligente ao ponto de saber que precisa criar a VPC antes de criar as subnets,
# Assim ele terá os valores necessários quando for criar a Subnet

resource "aws_subnet" "deivi-motors-subnet-public1" {
  vpc_id                  = aws_vpc.vpc-deivi-motors.id #pega o id da VPC que iremos criar
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  # assign_ipv6_address_on_creation                = "false"
  # enable_dns64                                   = "false"
  # enable_lni_at_device_index                     = "0"
  # enable_resource_name_dns_a_record_on_launch    = "false"
  # enable_resource_name_dns_aaaa_record_on_launch = "false"
  # ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  # private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                     = "${var.projectName}-subnet-public1-us-east-1a",
    "kubernetes.io/role/elb" = 1
  }

  tags_all = {
    Name                     = "${var.projectName}-subnet-public1-us-east-1a",
    "kubernetes.io/role/elb" = 1
  }

}

resource "aws_subnet" "deivi-motors-subnet-public2" {
  vpc_id                  = aws_vpc.vpc-deivi-motors.id #pega o id da VPC que iremos criar
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"
  # assign_ipv6_address_on_creation                = "false"
  # enable_dns64                                   = "false"
  # enable_lni_at_device_index                     = "0"
  # enable_resource_name_dns_a_record_on_launch    = "false"
  # enable_resource_name_dns_aaaa_record_on_launch = "false"
  # ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  # private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                     = "${var.projectName}-subnet-public2-us-east-1b",
    "kubernetes.io/role/elb" = 1
  }

  tags_all = {
    Name                     = "${var.projectName}-subnet-public2-us-east-1b",
    "kubernetes.io/role/elb" = 1
  }

}

resource "aws_subnet" "deivi-motors-subnet-private1" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = "10.0.11.0/24"
  enable_dns64                    = "false"
  # enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch             = "false"
  private_dns_hostname_type_on_launch = "ip-name"
  availability_zone                   = "us-east-1a"

  tags = {
    Name                              = "${var.projectName}-subnet-private1-us-east-1a",
    "kubernetes.io/role/internal-elb" = 1
  }

  tags_all = {
    Name                              = "${var.projectName}-subnet-private1-us-east-1a",
    "kubernetes.io/role/internal-elb" = 1
  }

  vpc_id = aws_vpc.vpc-deivi-motors.id #pega o id da VPC que iremos criar
}


resource "aws_subnet" "deivi-motors-subnet-private2" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = "10.0.12.0/24"
  enable_dns64                    = "false"
  # enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch             = "false"
  private_dns_hostname_type_on_launch = "ip-name"
  availability_zone                   = "us-east-1b"

  tags = {
    Name                              = "${var.projectName}-subnet-private2-us-east-1b",
    "kubernetes.io/role/internal-elb" = 1
  }

  tags_all = {
    Name                              = "${var.projectName}-subnet-private2-us-east-1b",
    "kubernetes.io/role/internal-elb" = 1
  }

  vpc_id = aws_vpc.vpc-deivi-motors.id #pega o id da VPC que iremos criar
}