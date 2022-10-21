data "aws_ami" "golden_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.environment}-*"]
  }
  owners = ["self"] 
}

resource "aws_lb" "alb" {
  depends_on = [
    aws_security_group.lb_default
  ]
  name               = "${var.environment}-default-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_default.id]
  subnets            = [for subnet in var.private_subnet: subnet.id]

  enable_deletion_protection = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_launch_template" "web" {
  name_prefix   = "${var.environment}-default-lt"
  image_id      = data.aws_ami.golden_image.id
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "web" {
  desired_capacity   = var.subnet_count
  max_size           = var.subnet_count
  min_size           = var.subnet_count
  target_group_arns  = [aws_lb.alb.arn]

  launch_template {
    version = "$Latest"
  }
}


resource "aws_instance" "bastion" {
  ami           = data.aws_ami.golden_image.id
  instance_type = var.instance_type
  subnet_id     = var.bastion_subnet
  vpc_security_group_ids = [aws_security_group.ssh.id]
    
  tags = {
    Environment = var.environment
  }
  
}

## DEFAULT SG
resource "aws_security_group" "lb_default" {
  name        = "${var.environment}-default-lb-sg"
  description = "Default security group to allow inbound HTTP"
  vpc_id      = var.vpc_id
  ingress {
    from_port        = "80"
    to_port          = "80"
    protocol         = "tcp"
    self             = true
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    from_port        = "22"
    to_port          = "22"
    protocol         = "tcp"
    self             = true
    cidr_blocks      = var.vpc_cidr_block

  }
  ingress {
    from_port        = "-1"
    to_port          = "-1"
    protocol         = "icmp"
    self             = true
    cidr_blocks      = var.vpc_cidr_block

  }
  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group" "ssh" {
  name        = "${var.environment}-default-ssh-sg"
  description = "Default security group to allow inbound SSH"
  vpc_id      = var.vpc_id
  ingress {
    from_port        = "22"
    to_port          = "22"
    protocol         = "tcp"
    self             = true
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Environment = var.environment
  }
}

