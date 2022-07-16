# ------------- create aws ec2 bastion  --------------------------

resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.ec2_instance_type
  vpc_security_group_ids      = [aws_security_group.iti_sg.id]
  key_name                    = aws_key_pair.iti_ssh_key.key_name
  subnet_id                   = module.network.iti_public_subnet1_id
  associate_public_ip_address = true

  tags = {
    Name      = "iti-bastion"
    createdBy = "terraform"
  }
  root_block_device {
    delete_on_termination = true
  }


  provisioner "local-exec" {
    # print the bastion public ip address
    command = "echo ${self.public_ip}"
  }
  
}

resource "aws_instance" "application_instance" {
  ami                    = var.ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.iti_sg.id]
  key_name               = aws_key_pair.iti_ssh_key.key_name
  subnet_id              = module.network.iti_private_subnet1_id
  tags = {
    Name      = "iti-application_instance"
    createdBy = "terraform2"
  }
  root_block_device {
    delete_on_termination = true
  }
}










