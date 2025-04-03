resource "aws_launch_configuration" "app" {
  name = "app-launch-configuration"
  image_id = "ami-05238ab1443fdf48f"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  security_groups = [aws_security_group.HTTP-SG.id]
  key_name               = aws_key_pair.my-key.id
  
  user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y python3
        echo "Hello, World from ASG , $(hostname -f) " > /home/ec2-user/index.html
        cd /home/ec2-user
        python3 -m http.server 80 &
        EOF
}


resource "aws_autoscaling_group" "auto-sca-group" {

  min_size                  = 1
  desired_capacity          = 2
  max_size                  = 3

  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_configuration = aws_launch_configuration.app.id
  vpc_zone_identifier       = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}"]

  }