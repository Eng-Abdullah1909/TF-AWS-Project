resource "aws_security_group" "HTTP-SG" {
  
  vpc_id = aws_vpc.main.id
  description = "HTTP Sec-group for load-balancer"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
     name = "HTTP-SG" 
  }
}


resource "aws_security_group" "Bastion-SG" {
  
  vpc_id = aws_vpc.main.id
  description = "Sec-group for Jump server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
     name = "Jump-server-SG" 
  }
}