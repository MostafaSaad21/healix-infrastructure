# 1.Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 2.Create Load Balancer
resource "aws_lb" "main_alb" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets

  tags = {
    Name = "Healix-Secure-Gateway" 
  }
}


# 3. Target Group 
resource "aws_lb_target_group" "app_tg" {
  name     = "${var.project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
}

# 4. Listener 
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# 5.Launch Template
resource "aws_launch_template" "app_lt" {
  name_prefix   = "healix-app-node"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "Healix-App-Server"
      Project = "Healix Medical System" 
    }
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.app_sg_id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Healix Medical Platform</h1>" > /var/www/html/index.html
              EOF
  )
}

# 6. Auto Scaling Group 
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.app_subnets
  max_size            = 4
  min_size            = 2
  desired_capacity    = 2
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
}