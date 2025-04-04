resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template"
  image_id      = "ami-05238ab1443fdf48f"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my-key.id

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    security_groups = [aws_security_group.HTTP-SG.id]
  }

  user_data = base64encode(<<-EOF
        #!/bin/bash
        yum update -y
        yum install -y python3
        echo "Hello, World from ASG , $(hostname -f) " > /home/ec2-user/index.html
        cd /home/ec2-user
        python3 -m http.server 80 &
  EOF
  )
}

resource "aws_autoscaling_group" "auto_sca_group" {

  min_size         = 1
  desired_capacity = 2
  max_size         = 3

  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  target_group_arns = [aws_lb_target_group.target-group.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
