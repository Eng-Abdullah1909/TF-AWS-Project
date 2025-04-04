resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.HTTP-SG.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_target_group" "target-group" {
  name     = "lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    protocol            = "HTTP"
    path                = "/home/ec2-user/index.html"
    interval            = 10 # Check every 10 seconds
    timeout             = 5  # Mark unhealthy if no response in 5 seconds
    healthy_threshold   = 3  # Needs 3 successful checks to be considered healthy
    unhealthy_threshold = 3  # Needs 3 failed checks to be considered unhealthy
  }


}



resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

