# ---------------- create ssh key using tls_private_key --------------------------

resource "tls_private_key" "iti_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "iti_ssh_key" {
  key_name   = "iti_lab_key"
  public_key = tls_private_key.iti_key.public_key_openssh
}

# ------------- create aws secret manager --------------------------
resource "aws_secretsmanager_secret" "iti_secret" {
  name                    = "iti_secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "iti_secret_version" {
  secret_id     = aws_secretsmanager_secret.iti_secret.id
  secret_string = tls_private_key.iti_key.private_key_pem
}


# ------------- create aws ec2 bastion  --------------------------

resource "aws_instance" "bastion" {
  ami                         = "ami-052efd3df9dad4825"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.iti_sg.id]
  key_name                    = aws_key_pair.iti_ssh_key.key_name
  subnet_id                   = aws_subnet.iti_public_subnet1.id
  associate_public_ip_address = true

  tags = {
    Name      = "iti-bastion"
    createdBy = "terraform"
  }
  root_block_device {
    delete_on_termination = true
  }
}

resource "aws_instance" "application_instance" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.iti_sg.id]
  key_name               = aws_key_pair.iti_ssh_key.key_name
  subnet_id              = aws_subnet.iti_private_subnet1.id
  tags = {
    Name      = "iti-application_instance"
    createdBy = "terraform"
  }
  root_block_device {
    delete_on_termination = true
  }
}