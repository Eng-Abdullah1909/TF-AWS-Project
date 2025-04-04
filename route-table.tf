resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "private-RT for subnet 1&2"
  }
}


resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-RT for subnet 3&4"
  }
}


resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.private-RT.id
}


resource "aws_route_table_association" "subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.private-RT.id
}


resource "aws_route_table_association" "subnet3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route_table_association" "subnet4" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.public-RT.id
}
