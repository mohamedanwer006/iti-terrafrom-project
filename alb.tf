#--------------------- Target Group Creation ----------------------------

resource "aws_lb_target_group" "tg" {
  name        = "TargetGroup"
  port        = 3000
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = module.network.vpc_id
}

#----------------- Target Group Attachment with Instance --------------------------


resource "aws_alb_target_group_attachment" "tgattachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.application_instance.id
}

# ----------------------- Application Load balancer ----------------------------

resource "aws_lb" "lb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id ]
  subnets            = [module.network.iti_public_subnet1_id,module.network.iti_public_subnet2_id]
}


#-------------------------- Listner ------------------------

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
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

#----------------------- Listener Rule ------------------------------

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }

  condition {
    path_pattern {
      values = ["/var/www/html/index.html"]
    }
  }
}


locals {
  ingress_rules = [{
    name        = "HTTPS"
    port        = 443
    description = "Ingress rules for port 443"
    },
    {
      name        = "HTTP"
      port        = 80
      description = "Ingress rules for port 80"
    },
    {
      name        = "SSH"
      port        = 22
      description = "Ingress rules for port 22"
  }]

}

resource "aws_security_group" "lb_sg" {

  name        = "CustomSG"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.network.vpc_id
  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]


  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "AWS security group dynamic block"
  }

}