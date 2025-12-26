# Tell Terraform to use the AWS provider
provider "aws" {
  region = "us-east-1"  # Change if you prefer another region
}

# Create a VPC (the foundation of Project 5)
resource "aws_vpc" "multi_tier_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "multi-tier-vpc-terraform"
    Project = "Project5-IaC"
  }
}

# Output the VPC ID so we can see it after apply
output "vpc_id" {
  value = aws_vpc.multi_tier_vpc.id
}

# Public Subnets
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.multi_tier_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.multi_tier_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-b"
  }
}

# Private Subnets
resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.multi_tier_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.multi_tier_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.multi_tier_vpc.id

  tags = {
    Name = "main-igw"
  }
}

# Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

# Regional NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "regional-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.multi_tier_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Public Route Table Associations
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.multi_tier_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

# Private Route Table Associations
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP/HTTPS from internet to ALB"
  vpc_id      = aws_vpc.multi_tier_vpc.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow HTTP from ALB only"
  vpc_id      = aws_vpc.multi_tier_vpc.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from EC2 only"
  vpc_id      = aws_vpc.multi_tier_vpc.id

  ingress {
    description     = "MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  tags = {
    Name = "rds-sg"
  }
}

# Target Group for ASG instances
resource "aws_lb_target_group" "tg" {
  name     = "multi-tier-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.multi_tier_vpc.id

  health_check {
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "multi-tier-tg"
  }
}

# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "multi-tier-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  enable_deletion_protection = false

  tags = {
    Name = "multi-tier-alb"
  }
}

# HTTP Listener (redirect to HTTPS)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:771826808882:certificate/8e70f060-88db-4037-aaf0-56d7fc6eebf7"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# Output ALB DNS for testing
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

# IAM Role for EC2 Instances
resource "aws_iam_role" "ec2_role" {
  name = "multi-tier-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "multi-tier-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# Launch Template
resource "aws_launch_template" "web" {
  name = "multi-tier-web-lt"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t4g.micro"  # Graviton for free tier + better perf

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd php php-mysqlnd
    systemctl enable httpd
    systemctl start httpd

    # Simple app page
    cat << 'HTML' > /var/www/html/index.php
    <?php
    echo "<h1>Hello from AWS App Runner Replacement!</h1>";
    echo "<p>Instance: " . gethostname() . "</p>";
    echo "<p>Time: " . date('Y-m-d H:i:s') . "</p>";
    ?>
    HTML

    # Health check
    echo "OK" > /var/www/html/health

    chown -R apache:apache /var/www/html
    chmod -R 755 /var/www/html
    EOF
  )

  tags = {
    Name = "multi-tier-web-template"
  }
}

# AMI Data Source (Latest Amazon Linux 2023 ARM64)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  name                = "multi-tier-web-asg"
  vpc_zone_identifier = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  health_check_type   = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]

  tag {
    key                 = "Name"
    value               = "multi-tier-web-instance"
    propagate_at_launch = true
  }
}

# RDS Subnet Group (private subnets)
resource "aws_db_subnet_group" "private" {
  name       = "multi-tier-private-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "multi-tier-db-subnet-group"
  }
}

# RDS MySQL Instance (free tier)
resource "aws_db_instance" "mysql" {
  identifier             = "multi-tier-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t4g.micro"  # Free tier eligible
  allocated_storage      = 20
  storage_type           = "gp3"
  username               = "admin"
  password               = "SuperSecretPassword123!"
  db_name                = "app_db"

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.private.name

  publicly_accessible    = false
  skip_final_snapshot    = true  # For easy destroy
  apply_immediately      = true

  tags = {
    Name = "multi-tier-db"
  }
}

# Output RDS Endpoint
output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}