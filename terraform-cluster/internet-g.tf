resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-deivi-motors.id
}

