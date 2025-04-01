resource "aws_eip" "lb" {
  tags = {
  Name = "natGW-eip"
  }
}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.subnet4.id

  tags = {
    Name = "gw NAT"
  }
}