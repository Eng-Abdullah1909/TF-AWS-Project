resource "aws_instance" "bastion" {

  ami                         = "ami-05238ab1443fdf48f" #amazon-linux - eu-west-2
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.Bastion-SG.id]
  subnet_id                   = aws_subnet.subnet3.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my-key.id

  tags = {
    Name = "jumb-server"
  }
}


resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = file("C:\\Users\\Abdullah\\.ssh\\my-key.pub")
}



output "Instance-public-ip" {
  description = "Public IP address of the bastion server"
  value       = aws_instance.bastion.public_ip
}

