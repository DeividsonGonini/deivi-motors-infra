resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc-deivi-motors.id

  route {
    cidr_block = "0.0.0.0/0" #Aberto para todas as origens
    gateway_id = aws_internet_gateway.igw.id
  }

  #Rota para utilização na Internet
  route {
    cidr_block = "0.0.0.0/0" #Aberto para todas as origens
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_association_0" {
  subnet_id      = aws_subnet.deivi-motors-subnet-public1.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rt_association_1" {
  subnet_id      = aws_subnet.deivi-motors-subnet-public2.id
  route_table_id = aws_route_table.rt_public.id
}