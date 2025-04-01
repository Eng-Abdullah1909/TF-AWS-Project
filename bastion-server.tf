resource "aws_instance" "bastion" {
    
  ami           = ami-05238ab1443fdf48f   #amazon-linux - eu-west-2
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.Bastion-SG ]
  subnet_id = aws_subnet.subnet3.id
  associate_public_ip_address = true

  tags = {
    Name = "jumb-server"
  }
}