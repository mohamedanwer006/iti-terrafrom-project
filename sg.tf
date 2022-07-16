# security group for ssh 

resource "aws_security_group" "iti_sg" {
  name        = "iti-project-sg"
  description = "security group for bastion server"
  vpc_id      = module.network.vpc_id
  tags = {
    Name      = "iti_sg_22"
    createdBy = "terraform : mohamedanwer006"
  }
}


#------------------------ Inbound traffic ---------------------


# allow ssh 
resource "aws_security_group_rule" "sg_inbound_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # allows ssh from anywhere  
  security_group_id = aws_security_group.iti_sg.id
}



# security group for 3000 port

resource "aws_security_group" "iti_sg2" {
  name        = "iti-project-sg2"
  description = "security group open port 3000"
  vpc_id      = module.network.vpc_id
  tags = {
    Name      = "iti_sg_3000"
    createdBy = "terraform : mohamedanwer006"
  }
}


#------------------------ Inbound traffic ---------------------

# allow traffic at port 3030
resource "aws_security_group_rule" "sg_inbound_allow_http" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"] # allows from vpc cider 
  security_group_id = aws_security_group.iti_sg2.id

}

