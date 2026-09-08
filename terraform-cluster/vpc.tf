resource "aws_vpc" "vpc-deivi-motors" {
  assign_generated_ipv6_cidr_block     = "false"
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = "true"
  enable_dns_support                   = "true"
  enable_network_address_usage_metrics = "false"
  instance_tenancy                     = "default"

  tags = {
    Name    = "${var.projectName}-vpc"
    project = var.projectName
  }

  tags_all = {
    Name    = "${var.projectName}-vpc"
    project = var.projectName
  }
}