# ============================================================================
# ----------------------- Security group for bastion -------------------------
# ============================================================================
resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "security group for bastion server"
  vpc_id      = module.network.vpc_id
  tags = {
    Name      = "bastion-sg"
    createdBy = "terraform : mohamedanwer006"
  }
}

# inbound rules for bastion server
resource "aws_security_group_rule" "sg_inbound_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # allows ssh from anywhere  
  security_group_id = aws_security_group.bastion_sg.id
}

# outbound rules for bastion server
resource "aws_security_group_rule" "sg_inbound_allow_outbound_traffic" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]   
  security_group_id = aws_security_group.bastion_sg.id
}


# ============================================================================
# --------------------- Security group for application -----------------------
# ============================================================================
resource "aws_security_group" "application_sg" {
  name        = "application-sg"
  description = "security group for application server"
  vpc_id      = module.network.vpc_id
  tags = {
    Name      = "application-sg"
    createdBy = "terraform : mohamedanwer006"
  }
}


# Inbound rules for application server
resource "aws_security_group_rule" "sg_inbound_allow_http" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr] # allows from vpc cider 
  security_group_id = aws_security_group.application_sg.id

}


resource "aws_security_group_rule" "sg_inbound_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"] # allows from vpc cider 
  security_group_id = aws_security_group.application_sg.id

}

# Outbound rules for application server
resource "aws_security_group_rule" "sg_inbound_allow_all-outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.application_sg.id
}

# ============================================================================
# -------------------------- Security group for rds --------------------------
# ============================================================================

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "security group for rds "
  vpc_id      = module.network.vpc_id
  tags = {
    Name      = "rds-sg"
    createdBy = "terraform : mohamedanwer006"
  }
}

#  Inbound rules for rds 
resource "aws_security_group_rule" "sg_inbound_allow_rds" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.rds_sg.id
}

# Outbound rules for rds
resource "aws_security_group_rule" "sg_outbound_allow_all_rds" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}

# ============================================================================
# -------------------------- Security group for Elasticache ------------------
# ============================================================================

resource "aws_security_group" "redis_sg" {
  name        = "redis-sg"
  description = "security group for redis  "
  vpc_id      = module.network.vpc_id
  tags = {
    Name      = "redis-sg"
    createdBy = "terraform : mohamedanwer006"
  }
}


#  Inbound rules for redis
resource "aws_security_group_rule" "sg_inbound_allow_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.redis_sg.id
}

# Outbound rules for rds
resource "aws_security_group_rule" "sg_outbound_allow_all_redis" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.redis_sg.id
}


# ============================================================================
# -------------------------- Security group for ALB --------------------------
# ============================================================================

# resource "aws_security_group" "alb_sg" {
#   name        = "alb-sg"
#   description = "security group for alb "
#   vpc_id      = module.network.vpc_id
#   tags = {
#     Name      = "alb-sg"
#     createdBy = "terraform : mohamedanwer006"
#   }
# }

# # Inbound rules for alb

# resource "aws_security_group_rule" "allow_alb" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.alb_sg.id
# }
# resource "aws_security_group_rule" "allow_alb_outbound" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.alb_sg.id
# }
